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

/**
 *  判断日期是否已过期
 *
 *  @return YES/NO
 */
- (BOOL) isDateExpired;

/**
 *  判断日期是否为 今天、昨天、明天
 *  format : yyyy/MM/dd
 *
 *  @return 返回 “今天”、“明天”、“昨天” 或者 “format”格式
 */
- (NSString *) compareDateWithFormat:(NSString *)format;

@end
