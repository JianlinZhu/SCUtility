//
//  NSDate+Extend.m
//  SCUtility
//
//  Created by Jarry on 13-5-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "NSDate+SCExtend.h"
#import "SCMacroDefines.h"

@implementation NSDate (SCExtend)

+ (NSTimeInterval) timeIntervalValue
{
    return [[self date] timeIntervalSince1970]; // 精确到秒
}

+ (NSString *) timeIntervalString
{
    return [NSString stringWithFormat:@"%.0f", [self timeIntervalValue]];
}

+ (NSDate *) stringToDate:(NSString *)dateString
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_ch"]];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* inputDate = [inputFormatter dateFromString:dateString];
    return inputDate;
}

+ (NSDate *) hourStringToDate:(NSString *)hourString
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_ch"]];
    [inputFormatter setDateFormat:@"HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:hourString];
    return inputDate;
}

- (BOOL) isToday
{
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear ;
    
    // 获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 获得 self 的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps. month == nowCmps. month ) && (selfCmps.day == nowCmps.day);
}

- (NSString*) formattedDateWithFormatString:(NSString*)dateFormatterString
{
	if(!dateFormatterString) return nil;
	
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:dateFormatterString];
	[formatter setAMSymbol:@"AM"];
	[formatter setPMSymbol:@"PM"];
	return [formatter stringFromDate:self];
}

- (NSString*) formattedExactRelativeDate
{
	NSTimeInterval time = [self timeIntervalSince1970];
	NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
	NSTimeInterval diff = time - now;
	if (diff <= 0) {
        return @"已经结束";
    }
	else if(diff < 60) {
		return [NSString stringWithFormat:@"剩余:%d秒",(int)diff];
	}
	
	diff = round(diff/60);
	if(diff < 60) {
        return [NSString stringWithFormat:@"剩余:%d分钟",(int)diff];
	}
	
	diff = round(diff/60);
	if(diff < 24) {
        return [NSString stringWithFormat:@"剩余:%d小时",(int)diff];
	}
    diff = round(diff/24);
    
	if(diff < 30) {
        return [NSString stringWithFormat:@"剩余:%d天",(int)diff];
	}
	
	return [self formattedDateWithFormatString:@"截止:yy/MM/dd"];
}

- (NSString *) relativeDateString
{
    const int SECOND = 1;
    const int MINUTE = 60 * SECOND;
    const int HOUR = 60 * MINUTE;
    const int DAY = 24 * HOUR;
    const int MONTH = 30 * DAY;
    
    NSDate *now = [NSDate date];
    NSTimeInterval delta = [self timeIntervalSinceDate:now] * -1.0;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger units = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond);
    NSDateComponents *components = [calendar components:units fromDate:self toDate:now options:0];
    
    NSString *relativeString;
    
    if (delta < 0) {
        relativeString = @"";
        
    } else if (delta < 1 * MINUTE) {
        relativeString = (components.second == 1) ? @"1秒钟前" : [NSString stringWithFormat:@"%ld秒钟前",(long)components.second];
        
    } else if (delta < 2 * MINUTE) {
        relativeString =  @"1分钟前";
        
    } else if (delta < 45 * MINUTE) {
        relativeString = [NSString stringWithFormat:@"%ld分钟前",(long)components.minute];
        
    } else if (delta < 90 * MINUTE) {
        relativeString = @"1小时前";
        
    } else if (delta < 24 * HOUR) {
        relativeString = [NSString stringWithFormat:@"%ld小时前",(long)components.hour];
        
    } else if (delta < 48 * HOUR) {
        relativeString = @"昨天";
        
    } else if (delta < 30 * DAY) {
        relativeString = [NSString stringWithFormat:@"%d天前",(int)components.day];
        
    } else if (delta < 12 * MONTH) {
        relativeString = (components.month <= 1) ? @"1个月前" : [NSString stringWithFormat:@"%d个月前",(int)components.month];
        
    } else {
        relativeString = (components.year <= 1) ? @"1年前" : [NSString stringWithFormat:@"%d年前",(int)components.year];
        
    }
    
    return relativeString;
}

- (NSString *) weekday
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *component = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSInteger weekday =  component.weekday;
    NSString *week = nil;
    switch (weekday) {
        case 1:
            week = @"周日";
            break;
        case 2:
            week = @"周一";
            break;
        case 3:
            week = @"周二";
            break;
        case 4:
            week = @"周三";
            break;
        case 5:
            week = @"周四";
            break;
        case 6:
            week = @"周五";
            break;
        case 7:
            week = @"周六";
            break;
        default:
            break;
    }
    return week;
}

- (NSString *) toStringWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:format];
    return [dateFormater stringFromDate:self];
}

- (NSString *) toStringWithDefaultFormat
{
    return [self toStringWithFormat:@"HH:mm"];
}

@end
