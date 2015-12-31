//
//  SCUISignal.m
//  iChintPlugin
//
//  Created by Jarry on 14-6-27.
//  Copyright (c) 2014年 iChint. All rights reserved.
//

#import "SCUISignal.h"

@implementation SCUISignal

- (id) init
{
    if (self = [super init]) {
        _state = SCUISignalState_None;
    }
    return self;
}

- (void) start
{
    if (!_sender) {
        NSLog(@"-->>>Warning! SCUISignal must have sender!");
        return;
    }
    [self cancel];
    _state = SCUISignalState_Executing;
    if (_receiver) {
        if ([_receiver handleUISignal:self]) {
            _state = SCUISignalState_Finished;
        } else {
            _state = SCUISignalState_NotFound;
        }
    } else {
        [self checkThePossibleHandle:_sender];
    }
}

- (void) cancel
{
    _state = SCUISignalState_Cancel;
}

- (void) finished
{
    _state = SCUISignalState_Finished;
}

- (void) checkThePossibleHandle:(id<SCUISignalDelegate>)possibleHandle
{
    if (_state == SCUISignalState_Executing) {
        if ([possibleHandle handleUISignal:self]) {
            //自己能处理
            [self finished];
        }else {
            if ([possibleHandle isKindOfClass:[UIView class]]) {
                //查找view链
                UIView *superView=[(UIView*)possibleHandle superview];
                if (superView) {
                    [self checkThePossibleHandle:superView];
                }else{
                    //view找到顶了
                    UIViewController *senderViewController=[(UIView*)_sender viewControllerForUISignal];
                    if (senderViewController) {
                        [self checkThePossibleHandle:senderViewController];
                    }
                }
            }else if ([possibleHandle isKindOfClass:[UIViewController class]]) {//查找controll链
                UIViewController *viewControler=(UIViewController*)possibleHandle;
                if ([viewControler isKindOfClass:[UINavigationController class]]) {
                    viewControler=[(UINavigationController*)possibleHandle topViewController];
                    if (viewControler) {
                        [self checkThePossibleHandle:viewControler];
                    }
                }else{
                }
            }else{
            }
        }
        if (_state == SCUISignalState_Executing) {
            //如果最后还没有
            _state = SCUISignalState_NotFound;
        }
    }
}
@end


@implementation UIView (SCUISignal)

- (void) sendUISignalForKey:(NSString*)signalKey
{
    [self sendUISignalForKey:signalKey userInfo:nil];
}

- (void) sendUISignalForKey:(NSString *)signalKey userInfo:(id)userInfo
{
    SCUISignal *signal = [[SCUISignal alloc] init];
    signal.name = signalKey;
    signal.userInfo = userInfo;
    [self sendUISignal:signal];
}

- (void) sendUISignal:(SCUISignal *)signal
{
    if (signal) {
        if (!signal.sender) {
            signal.sender=self;
        }
        [signal start];
    }
}

- (BOOL) handleUISignal:(SCUISignal *)signal
{
    return NO;
}

- (UIViewController *) viewControllerForUISignal
{
    id viewController=[self nextResponder];
    UIView *view=self;
    while (viewController && ![viewController isKindOfClass:[UIViewController class]]) {
        view=[view superview];
        viewController=[view nextResponder];
    }
    return viewController;
}

@end

@implementation UIViewController (SCUISignal)

- (BOOL) handleUISignal:(SCUISignal *)signal
{
    return NO;
}

@end
