//
//  UIColor+SCExtend.h
//  SCUtility
//
//  Created by Jarry on 14-10-26.
//  Copyright (c) 2014年 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  颜色处理 扩展类
 */
@interface UIColor (SCExtend)

/**
 *  颜色转换 十六进制字符串颜色转换为UIColor
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

@end


