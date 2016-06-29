//
//  NSDictionary+SCParam.m
//  SCUtility
//
//  Created by Surwin on 14-5-15.
//  Copyright (c) 2014年 Jarry. All rights reserved.
//

#import "NSDictionary+SCParam.h"

@implementation NSDictionary (SCParam)

- (BOOL) checkNullForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    return [self checkNull:value];
}

- (NSString *) getStringForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    return [self checkNull:value] ? value : @"";
}

- (NSInteger) getIntegerValueForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    return [self checkNull:value] ? [value integerValue] : 0;
}

- (BOOL) getBoolValueForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    return [self checkNull:value] ? [value boolValue] : NO;
}

- (double) getDoubleValueForKey:(NSString *)key
{
    id value = [self objectForKey:key];
    return [self checkNull:value] ? [value doubleValue] : 0.0;
}

- (BOOL) checkNull:(id)object
{
    return ((object != nil) && ![object isEqual:[NSNull null]]);
}

@end
