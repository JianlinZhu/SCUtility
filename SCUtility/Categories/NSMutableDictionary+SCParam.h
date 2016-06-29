//
//  NSMutableDictionary+SCParam.h
//  SCUtility
//
//  Created by Surwin on 14-5-14.
//  Copyright (c) 2014年 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SCParam)

- (void) setParamValue:(id)value forKey:(NSString *)key;
- (void) setParamIntegerValue:(NSInteger)value forKey:(NSString *)key;
- (void) setParamDoubleValue:(double)value forKey:(NSString *)key;
- (void) setParamLongValue:(long long)value forKey:(NSString *)key;

- (void) setParamIntegerString:(NSInteger)value forKey:(NSString *)key;
- (void) setParamDoubleString:(double)value forKey:(NSString *)key;
- (void) setParamLongString:(long long)value forKey:(NSString *)key;

@end
