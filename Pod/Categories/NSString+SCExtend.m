//
//  NSString+Extend.m
//  SCUtility
//
//  Created by Jarry on 13-5-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "NSString+SCExtend.h"
#import <CommonCrypto/CommonDigest.h>
#import "SCLog.h"

@implementation NSString (SCExtend)

+ (NSString *) MD5:(NSString *)targetStr
{
    return [targetStr MD5String];
}

- (NSString *) MD5String
{
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],  result[1],  result[2],   result[3],
            result[4],  result[5],  result[6],   result[7],
            result[8],  result[9],  result[10],  result[11],
            result[12], result[13], result[14],  result[15] ];
}

- (NSString *) SHA1String
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *) base64EncodedString
{
    // Create NSData object
    NSData *nsdata = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    // Get NSString from NSData object in Base64
    return [nsdata base64EncodedStringWithOptions:0];
}

- (NSString *) base64DecodedString
{
    // NSData from the Base64 encoded str
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:self options:0];
    
    // Decoded NSString from the NSData
    return [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
}

- (NSString *) trim
{
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSNumber *) numericValue
{
    return [NSNumber numberWithInt:[self intValue]];
}

+ (void) printFontAndFamilyName
{
    NSArray *familyNames =[[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    NSMutableString *debugStr = [NSMutableString string];
    for(indFamily=0;indFamily<[familyNames count];++indFamily)
    {
        [debugStr appendFormat:@"Family name: %@", [familyNames objectAtIndex:indFamily]];
        //DEBUGLOG(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames =[[NSArray alloc] initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
        for(indFont=0; indFont<[fontNames count]; ++indFont)
        {
            [debugStr appendFormat:@"\n  Font name: %@",[fontNames objectAtIndex:indFont]];
            //DEBUGLOG(@" Font name: %@",[fontNames objectAtIndex:indFont]);
        }
        [debugStr appendString:@"\n\n"];
    }
    DEBUGLOG(@"%@", debugStr);
}

- (NSString *) urlEncodedString
{
    NSString *encodedString = (__bridge NSString *)
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (__bridge CFStringRef)self,
                                            (__bridge CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8);
    return encodedString;
}

- (CGSize) sizeWithFont:(UIFont *)font maxWidth:(CGFloat)width
{
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect frame = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return frame.size;
}

- (NSString *) removeAllWhitespace
{
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *components = [str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //对components筛选出内容不为 "" 的元素 <> 为不等于 和 != 是一样的效果
    components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]];
    //再用 "" 把筛选的元素拼接起来
    return [components componentsJoinedByString:@""];
}

- (NSString *) unicodeString
{
    NSString *tempStr1 = [self stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
}

// 手机格式检测
- (BOOL) isValidatePhone
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

// 密码格式检测
- (BOOL) isValidatePassword
{
    NSString *passwordRegex = @"(?!^\\d+$)(?!^[a-zA-Z]+$)(?!^[_#@]+$).{6,16}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:self];
}

@end
