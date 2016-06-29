//
//  SCLog.h
//  SCUtility
//
//  Created by Jarry on 13-6-8.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//
#import "DDLog.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"

#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_ERROR;
#endif

/**
 *  基于DDLog 日志输出封装，
 *  支持带颜色的Log，需要安装XcodeColor插件
 *
 **/
@interface SCLog : NSObject

#define LOG(lv,s,...)   [SCLog SCLog:lv file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define DEBUGLOG(s,...) [SCLog SCLog:LOG_LEVEL_DEBUG file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define INFOLOG(s,...)  [SCLog SCLog:LOG_LEVEL_INFO file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define WARNLOG(s,...)  [SCLog SCLog:LOG_LEVEL_WARN file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]
#define ERRORLOG(s,...) [SCLog SCLog:LOG_LEVEL_ERROR file:__FILE__ lineNumber:__LINE__ func:__FUNCTION__ format:(s),##__VA_ARGS__]

+ (void) initLog;

+ (void) SCLog:(NSInteger)level
          file:(const char*)sourceFile
    lineNumber:(int)lineNumber
          func:(const char *)funcName
        format:(NSString*)format,...;

@end
