//
//  NSData+SCExtend.h
//  SCUtility
//
//  Created by Jarry on 15/7/28.
//  Copyright (c) 2015年 iChint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SCExtend)

/**
 *  Base64
 */
+ (NSData *) base64EncodedFrom:(NSString *)string;

+ (NSData *) base64DecodedFrom:(NSString *)base64String;

- (NSData *) base64EncodedData;

- (NSData *) base64DecodedData;


@end
