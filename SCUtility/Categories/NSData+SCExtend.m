//
//  NSData+SCExtend.m
//  SCUtility
//
//  Created by Jarry on 15/7/28.
//  Copyright (c) 2015年 iChint. All rights reserved.
//

#import "NSData+SCExtend.h"

@implementation NSData (SCExtend)

+ (NSData *) base64EncodedFrom:(NSString *)string
{
    // Create NSData object
    NSData *nsdata = [string dataUsingEncoding:NSUTF8StringEncoding];
    // Get NSData object in Base64
    return [nsdata base64EncodedData];
}

- (NSData *) base64EncodedData
{
    // Get NSData object in Base64
    return [self base64EncodedDataWithOptions:0];
}

+ (NSData *) base64DecodedFrom:(NSString *)base64String
{
    // NSData from the Base64 encoded str
    return [[NSData alloc] initWithBase64EncodedString:base64String options:0];
}

- (NSData *) base64DecodedData
{
    // NSData from the Base64 data
    return [[NSData alloc] initWithBase64EncodedData:self options:0];
}

@end
