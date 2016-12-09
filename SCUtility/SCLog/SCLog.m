//
//  SCLog.m
//  SCUtility
//
//  Created by Jarry on 13-6-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#import <CocoaLumberjack/DDLogMacros.h>
#import "SCLog.h"

static BOOL isColorEnabled = NO;

@implementation SCLog

+ (void) initLog
{
    isColorEnabled = YES;
	[DDLog addLogger:[DDASLLogger sharedInstance]];
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagInfo];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagError];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor] forFlag:DDLogFlagVerbose];
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
        case DDLogLevelInfo:
        {
            levelDesc = @"INFO";
            break;
        }
        case DDLogLevelWarning:
        {
            levelDesc = @"WARNING";
            break;
        }
        case DDLogLevelError:
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
        case DDLogLevelVerbose:
        {
            DDLogVerbose(@"%@", newFormat);
            break;
        }
        case DDLogLevelDebug:
        {
            DDLogDebug(@"%@", newFormat);
            break;
        }
        case DDLogLevelInfo:
        {
            DDLogInfo(@"%@", newFormat);
            break;
        }
        case DDLogLevelWarning:
        {
            DDLogWarn(@"%@", newFormat);
            break;
        }
        case DDLogLevelError:
        {
            DDLogError(@"%@", newFormat);
            break;
        }
    }
}

@end
