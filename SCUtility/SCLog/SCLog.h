//
//  SCLog.h
//  SCUtility
//
//  Created by Jarry on 13-6-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//
#import "CocoaLumberjack.h"

#if DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

/**
 *  基于DDLog 日志输出封装，
 *  支持带颜色的Log，需要安装XcodeColor插件
 *
 **/
@interface SCLog : NSObject

#define LOG(lv,s,...)   [SCLog SCLog:lv file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define VERBOSELOG(s,...) [SCLog SCLog:DDLogLevelVerbose file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define DEBUGLOG(s,...) [SCLog SCLog:DDLogLevelDebug file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define INFOLOG(s,...)  [SCLog SCLog:DDLogLevelInfo file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define WARNLOG(s,...)  [SCLog SCLog:DDLogLevelWarning file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define ERRORLOG(s,...) [SCLog SCLog:DDLogLevelError file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]

+ (void) initLog;

+ (void) SCLog:(NSInteger)level
          file:(const char*)sourceFile
    lineNumber:(int)lineNumber
          func:(const char *)funcName
        format:(NSString*)format,...;

@end
