//
//  SCUISignal.h
//  iChintPlugin
//
//  Created by Jarry on 14-6-27.
//  Copyright (c) 2014年 iChint. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  消息处理状态
 */
typedef enum
{
    SCUISignalState_None = 1,   // 未开始
    SCUISignalState_Executing,  // 正在执行
    SCUISignalState_Cancel,     // 被取消
    SCUISignalState_Finished,   // 执行完毕且找到响应者
    SCUISignalState_NotFound,   // 执行到最后也没有找到
} SCUISignalState;

@protocol SCUISignalDelegate;

/**
 *  消息逐级传递处理类
 */
@interface SCUISignal : NSObject

@property (retain,nonatomic) NSString *name;//名字,唯一标识
@property (assign,nonatomic) NSInteger tag;//数字,辅助标识
@property (retain,nonatomic) id userInfo;//附带信息或参数

@property (weak,nonatomic) id sender;//发送者,应当是UIView或者UIViewController
@property (weak,nonatomic) id receiver;//接受者,应当是UIView或者UIViewController，如果有，则尝试直接发送至接受者，如为nil，则按链式传递处理
@property (assign,readonly) SCUISignalState state;

- (void) start;
- (void) cancel;

@end

/**
 *  消息逐级传递处理委托
 */
@protocol SCUISignalDelegate <NSObject>
/*!
 *	@brief	处理某个信号，具体的是否处理该消息根据signal的name判别
 *
 *	@param 	signal 	待处理的信号消息
 *
 *	@return	如果返回是YES，则中断响应链，如果是NO，则继续传递消息
 */
- (BOOL) handleUISignal:(SCUISignal *)signal;

@end

/**
 *  UIView添加消息逐级传递处理
 */
@interface UIView (SCUISignal) <SCUISignalDelegate>
//由view中发出信号
- (void) sendUISignalForKey:(NSString*)signalKey;
- (void) sendUISignalForKey:(NSString *)signalKey userInfo:(id)userInfo;
- (void) sendUISignal:(SCUISignal *)signal;
- (UIViewController *) viewControllerForUISignal;
@end

/**
 *  UIViewController添加消息逐级传递处理
 */
@interface UIViewController (SCUISignal) <SCUISignalDelegate>
//在controller中处理
@end

