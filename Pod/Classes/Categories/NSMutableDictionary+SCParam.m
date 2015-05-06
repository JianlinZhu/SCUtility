//
//  NSMutableDictionary+SCParam.m
//  SCUtility
//
//  Created by Surwin on 14-5-14.
//  Copyright (c) 2014年 Jarry. All rights reserved.
//

#import "NSMutableDictionary+SCParam.h"

@implementation NSMutableDictionary (SCParam)

- (void) setParamValue:(id)value forKey:(NSString *)key
{
    if (value) {
        [self setValue:value forKey:key];
    }
}

- (void) setParamIntegerValue:(NSInteger)value forKey:(NSString *)key
{
    [self setValue:[NSNumber numberWithInteger:value] forKey:key];
}

- (void) setParamDoubleValue:(double)value forKey:(NSString *)key
{
    [self setValue:[NSNumber numberWithDouble:value] forKey:key];
}

- (void) setParamLongValue:(long long)value forKey:(NSString *)key
{
    [self setValue:[NSNumber numberWithLongLong:value] forKey:key];
}

- (void) setParamIntegerString:(NSInteger)value forKey:(NSString *)key
{
    [self setValue:[NSString stringWithFormat:@"%ld",(long)value] forKey:key];
}

- (void) setParamDoubleString:(double)value forKey:(NSString *)key
{
    [self setValue:[NSString stringWithFormat:@"%f",value] forKey:key];
}

- (void) setParamLongString:(long long)value forKey:(NSString *)key
{
    [self setValue:[NSString stringWithFormat:@"%lld",value] forKey:key];
}

@end
