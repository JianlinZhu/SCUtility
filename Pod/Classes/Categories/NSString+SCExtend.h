//
//  NSString+SCExtend.h
//  SCUtility
//
//  Created by Jarry on 13-5-27.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SCExtend)

/**
 *  MD5
 */
+ (NSString *) MD5:(NSString *)targetStr;

- (NSString *) MD5String;

/**
 *  Sha1
 */
- (NSString *) SHA1String;

/**
 *  Base64
 */
- (NSString *) base64EncodedString;

- (NSString *) base64DecodedString;

/**
 *  URL Encoded
 */
- (NSString *) urlEncodedString;

/**
 *  空格过滤
 */
- (NSString *) trim;

- (NSNumber *) numericValue;

+ (void) printFontAndFamilyName;

- (CGSize) sizeWithFont:(UIFont *)font maxWidth:(CGFloat)width;

/**
 *  去除字符串中所有的空白字符
 */
- (NSString *) removeAllWhitespace;

- (NSString *) unicodeString;

@end
