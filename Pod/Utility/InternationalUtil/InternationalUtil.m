//
//  InternationalUtil.m
//  SCUtility
//
//  Created by Jarry on 15/12/31.
//  Copyright © 2015年 iChint. All rights reserved.
//

#import "InternationalUtil.h"

@implementation InternationalUtil

static NSBundle *bundle = nil;

+ (NSBundle *) bundle
{
    return bundle;
}

/**
 *  获取系统的语言设置
 *  useSystemDefault = YES, 需要每次在启动的时候检查语言设置
 *  useSystemDefault = NO, 保存之前的语言设置
 */
+ (void) initUserLanguage:(BOOL)useSystemDefault
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *string = [userDefaults valueForKey:@"userLanguage"];
    if(useSystemDefault || (!string || string.length == 0)) {
        // 获取系统当前语言版本(中文zh-Hans,英文en)
        NSArray* languages = [userDefaults objectForKey:@"AppleLanguages"];
        NSString *current = [languages objectAtIndex:0];
        string = current;
        [userDefaults setValue:current forKey:@"userLanguage"];
        [userDefaults synchronize];//持久化，不加的话不会保存
    }
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    // 生成bundle
    bundle = [NSBundle bundleWithPath:path];
}

/**
 *  返回当前设置语言的字符串描述
 *  我在这里设置有转化是考虑到服务器接受的语言版本参数和iOS里的语言字符串描述不一致
 *  比如 iOS 对应的日文为 ja 而服务器接受的日文参数可能为 jp
 */
+ (NSString *) userLanguage
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *language = [[userDefaults valueForKey:@"userLanguage"] substringToIndex:2];
    
    if ([language isEqualToString:@"ja"]) {
        return @"jp";
    }

    return language;
}

/**
 *  设置程序内语言偏好
 *
 *  @param language 语言描述字符串 不能乱写 80行开始可以查找所需的语言字符串描述
 */
+ (void) setUserlanguage:(NSString *)language
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // 1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    bundle = [NSBundle bundleWithPath:path];
    
    // 2.持久化
    [userDefaults setValue:language forKey:@"userLanguage"];
    [userDefaults synchronize];
}

/**
 *  语言描述字符串
 (
 en,
 fr,
 de,
 zh-Hans,
 zh-Hant,
 ja,
 nl,
 it,
 es,
 es-MX,
 ko,
 pt,
 pt-PT,
 da,
 fi,
 nb,
 sv,
 ru,
 pl,
 tr,
 uk,
 ar,
 hr,
 cs,
 el,
 he,
 ro,
 sk,
 th,
 id,
 ms,
 en-GB,
 en-AU,
 ca,
 hu,
 vi
 )
 */

@end
