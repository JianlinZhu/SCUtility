//
//  NSDictionary+SCParam.h
//  SCUtility
//
//  Created by Jarry on 14-5-15.
//  Copyright (c) 2014年 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SCParam)

- (BOOL) checkNullForKey:(NSString *)key;

- (NSString *) getStringForKey:(NSString *)key;

- (NSInteger) getIntegerValueForKey:(NSString *)key;

- (BOOL) getBoolValueForKey:(NSString *)key;

- (double) getDoubleValueForKey:(NSString *)key;

@end
