//
//  NetWorkUtils.h
//  SCUtility
//
//  Created by Jarry on 14-5-5.
//  Copyright (c) 2014年 Jarry. All rights reserved.
//

#import "Reachability.h"

@interface NetWorkUtils : NSObject

/**
 *  判断网络状态
 */
+ (BOOL) IsNetworkAvailable;

/**
 *  判断WIFI是否开启
 */
+ (BOOL) IsWIFIEnabled;


/**
 *  判断3G是否开启
 */
+ (BOOL) Is3GEnabled;

/**
 *  获取本地IP地址
 */
+ (NSString *) localIPAddress;

/**
 *  通过IP和子网掩码计算广播地址
 */
+ (NSString *) broadcastAddress:(NSString *)ipAddr mask:(NSString *)netMask;

/**
 *  获取MAC
 */
+ (NSString *) macAddress;

@end
