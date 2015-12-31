//
//  InternationalUtil.h
//  SCUtility
//
//  Created by Jarry on 15/12/31.
//  Copyright © 2015年 iChint. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  internationalization
 */
#define InternationalizationName @"International"
#define InternationalString(key) [[InternationalControl bundle] localizedStringForKey:key value:nil table:InternationalizationName]

/**
 *  本地化语言 工具类
 */
@interface InternationalUtil : NSObject

/**
 *  获取当前资源文件
 */
+ (NSBundle *) bundle;

/**
 *  初始化语言文件
 */
+ (void) initUserLanguage:(BOOL)useSystemDefault;

/**
 *  获取应用当前语言
 */
+ (NSString *) userLanguage;

/**
 *  设置当前语言
 */
+ (void) setUserlanguage:(NSString *)language;


@end
