//
//  SCLog.m
//  SCUtility
//
//  Created by Jarry on 13-6-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import "SCLog.h"

static BOOL isColorEnabled = NO;

@implementation SCLog

+ (void) initLog
{
    isColorEnabled = YES;
	[DDLog addLogger:[DDASLLogger sharedInstance]];
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
}

+ (void) SCLog:(NSInteger)level
          file:(const char*)sourceFile
    lineNumber:(int)lineNumber
          func:(const char *)funcName
        format:(NSString*)format,...
{
    NSString* func = [[NSString alloc] initWithBytes:funcName length:strlen(funcName) encoding:NSUTF8StringEncoding];
    
    NSString* levelDesc = @"DEBUG";
    switch (level)
    {
        case LOG_LEVEL_INFO:
        {
            levelDesc = @"INFO";
            break;
        }
        case LOG_LEVEL_WARN:
        {
            levelDesc = @"WARNING";
            break;
        }
        case LOG_LEVEL_ERROR:
        {
            levelDesc = @"ERROR";
            break;
        }
        default:
            break;
    }
    
    va_list varArgsList;
    va_start(varArgsList, format);
    NSString *formatString = [[NSString alloc] initWithFormat:format arguments:varArgsList];
    va_end(varArgsList);
    
    NSString* newFormat = [NSString stringWithFormat:@"[%@]\n %@",levelDesc,formatString];
    newFormat = [newFormat stringByAppendingFormat:@"\n<< FUNC:%@ -- LINE:%d >>",func,lineNumber];
    
    if (!isColorEnabled) {
        NSLog(@"%@", newFormat);
        return;
    }
        
    switch (level)
    {
        case LOG_LEVEL_DEBUG:
        {
            DDLogDebug(@"%@", newFormat);
            break;
        }
        case LOG_LEVEL_INFO:
        {
            DDLogInfo(@"%@", newFormat);
            break;
        }
        case LOG_LEVEL_WARN:
        {
            DDLogWarn(@"%@", newFormat);
            break;
        }
        case LOG_LEVEL_ERROR:
        {
            DDLogError(@"%@", newFormat);
            break;
        }
    }
}

@end
