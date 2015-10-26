//
//  NSDate+Extend.h
//  SCUtility
//
//  Created by Jarry on 13-5-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SCExtend)

+ (NSTimeInterval) timeIntervalValue; // s

+ (NSString *) timeIntervalString; // s

+ (NSDate *) stringToDate:(NSString *)dateString;

+ (NSDate *) hourStringToDate:(NSString *)hourString;

- (BOOL) isToday;

- (NSString *) formattedDateWithFormatString:(NSString*)dateFormatterString ;

- (NSString *) formattedExactRelativeDate ;
- (NSString *) relativeDateString;
- (NSString *) weekday;
- (NSString *) toStringWithFormat:(NSString *)format;
- (NSString *) toStringWithDefaultFormat;

@end
