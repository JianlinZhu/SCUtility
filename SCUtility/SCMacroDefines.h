//
//  SCMacroDefines.h
//  SCUtility
//
//  Created by Jarry on 13-3-29.
//  Copyright (c) 2013年 Jarry. All rights reserved.
//

#ifndef SCUtility_SCMacroDefines_h
#define SCUtility_SCMacroDefines_h

/**
 *  系统
 */
#define     IOS_VERSION         [[[UIDevice currentDevice] systemVersion] floatValue]
#define     SYSTEM_VERSION      ([[UIDevice currentDevice] systemVersion])
#define     SYSTEM_LANGUAGE     ([[NSLocale preferredLanguages] objectAtIndex:0])

#define     SYSTEM_VERSION_EQUAL_TO(v)              ([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedSame)
#define     SYSTEM_VERSION_GREATER_THAN(v)          ([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedDescending)
#define     SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define     SYSTEM_VERSION_LESS_THAN(v)             ([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedAscending)
#define     SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedDescending)

// iOS 7
#define     isIOS7      (IOS_VERSION >= 7.0)
#define     isIOS8      (IOS_VERSION >= 8.0)

// 判断Retina屏幕
#define     isRetina            ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPhone5
#define     isIPhone5           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPhone6
#define     isIPhone6           ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750,1334), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPhone6Plus
#define     isIPhone6Plus       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断iPad
#define     isPad               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// Release safe
#define     RELEASE_SAFELY(__POINTER)   { [__POINTER release]; __POINTER = nil; }
#define     INVALIDATE_TIMER(__TIMER)   { [__TIMER invalidate]; __TIMER = nil; } 

// ARC
#define     ARC_FEATURE         __has_feature(objc_arc)
#define     ARC_WEAK_FEATURE    __has_feature(objc_arc_weak)

#if ARC_WEAK_FEATURE
#define     ARC_WEAK            weak
#elif ARC_FEATURE
#define     ARC_WEAK            unsafe_unretained
#else
#define     ARC_WEAK            assign
#endif

#if ARC_FEATURE
#define     ARC_BRIDGE          __bridge
#else
#define     ARC_BRIDGE
#endif

/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

// G－C－D
#define     GCD_DEFAULT(block)  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define     GCD_MAIN(block)     dispatch_async(dispatch_get_main_queue(),block)
#define     GCD_DELAY(block, delayInSeconds)    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);


// 文件路径
#define     RESOURCE_PATH       [[NSBundle mainBundle] resourcePath]
#define     DOCUMENT_PATH       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define     RESOURCE_FILE(file) [RESOURCE_PATH stringByAppendingPathComponent:file]
#define     DOCUMENT_FILE(file) [DOCUMENT_PATH stringByAppendingPathComponent:file]
#define     ABS_FILE_PATH(file) [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(),file]

// APP 版本号
#define     APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define     BUILD_VERSION       [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

/**
 *  屏幕
 */
#define     kIPhone5Increase    (isIPhone5 ? 88 : 0)
#define     kIOS7Offset         (isIOS7 ? 20 : 0)

#define     SCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
#define     SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)
#define     BOUNDS_HEIGHT       (SCREEN_HEIGHT - 20.0f + kIOS7Offset)
#define     NAVIGATION_HEIGHT   44.0f
#define     HEADER_HEIGHT       (NAVIGATION_HEIGHT + kIOS7Offset)
#define     CONTENT_HEIGHT      (BOUNDS_HEIGHT - HEADER_HEIGHT)

#define     SCREEN_STATUS_FRAME CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
#define     SCREEN_FRAME        CGRectMake(0, 0, SCREEN_WIDTH, BOUNDS_HEIGHT)
#define     CONTENT_FRAME       CGRectMake(0, HEADER_HEIGHT, SCREEN_WIDTH, CONTENT_HEIGHT)
#define     HEADER_FRAME        CGRectMake(0, 0, SCREEN_WIDTH, HEADER_HEIGHT)


/**
 *  颜色
 */
#define     RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define     RGBCOLOR(r,g,b)     RGBACOLOR(r,g,b,1.0)

#define     COLOR_HEX(hex)      [UIColor colorWithHexString:hex]

#define     CLEAR_COLOR         [UIColor clearColor]
#define     RED_COLOR           [UIColor redColor]
#define     WHITE_COLOR         [UIColor whiteColor]
#define     BLACK_COLOR         [UIColor blackColor]
#define     GREEN_COLOR         [UIColor greenColor]
#define     BLUE_COLOR          [UIColor blueColor]
#define     GRAY_COLOR          [UIColor grayColor]
#define     LIGHTGRAY_COLOR     [UIColor lightGrayColor] 
#define     DARKGRAY_COLOR      [UIColor darkGrayColor]
#define     ORANGE_COLOR        [UIColor orangeColor]
#define     DARKTEXT_COLOR      [UIColor darkTextColor]

/**
 *  字体
 */
#define     FONTNAMEWITHSIZE(fontName,fontSize) [UIFont fontWithName:fontName size:fontSize]
#define     TNRFONTSIZE(X)          FONTNAMEWITHSIZE(@"Times New Roman",X)
#define     BOLDTNRFONTSIZE(X)      FONTNAMEWITHSIZE(@"TimesNewRomanPS-BoldMT",X)
#define     SYSTEMFONT(X)           [UIFont systemFontOfSize:X]
#define     BOLDSYSTEMFONT(X)       [UIFont boldSystemFontOfSize:X]
#define     ARIALFONTSIZE(X)        FONTNAMEWITHSIZE(@"Arial",X)
#define     BOLDARIALFONTSIZE(X)    FONTNAMEWITHSIZE(@"Arial Black",X)


/**
 *  Block Defines
 */
typedef void (^voidBlock)();
typedef void (^idBlock)( id content);
typedef void (^idBOOLBlock)( id content, BOOL direction);
typedef void (^idRangeBlock)( id content1, id content2);
typedef void (^idRange3Block)( id content1, id content2, id content3);
typedef void (^boolBlock)(BOOL finised);
typedef void (^intBlock)(int flag);
typedef void (^refreshContent)(NSString *name);
typedef void (^intIdBlock)(int type , id content);
typedef BOOL (^boolRetBlock)( id content);

/**
 *  Add this macro before each category implementation, so we don't have to use
 *  -all_load or -force_load to load object files from static libraries that only contain
 *  categories and no classes.
 *  See http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html for more info.
 */
#define     FIX_CATEGORY_BUG(name)  @interface B5M_FIX_CATEGORY_BUG_##name @end \
                                    @implementation B5M_FIX_CATEGORY_BUG_##name @end

/**
 *  其他
 */

// String Format
#define     FORMAT(format, ...) [NSString stringWithFormat:(format), ##__VA_ARGS__]
#define     kIntToString(x)     [NSString stringWithFormat:@"%d", x]
#define     kBOOLToString(x)    [NSNumber numberWithBool:x]
#define     kDoubleToString(x)  [NSString stringWithFormat:@"%.2f", x]
#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
#define     kIntergerToString(x) [NSString stringWithFormat:@"%ld", x]
#define     kFormatArgInt2      @"%02ld"
#define     kFormatArgInt3      @"%03ld"
#else
#define     kIntergerToString(x) [NSString stringWithFormat:@"%d", x]
#define     kFormatArgInt2      @"%02d"
#define     kFormatArgInt3      @"%03d"
#endif

#define     degreesToRadian(x)      (M_PI * (x) / 180.0)
#define     radianToDegrees(radian) (radian*180.0)/(M_PI)

// NSUserDefaults
#define     USER_DEFAULT        [NSUserDefaults standardUserDefaults]

// 读取本地图片, 和imageNamed一样，两个参数，前面一个是 文件名，后面一个是类型
#define     LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

#define     IMAGENAMED(file)    [UIImage imageNamed:file]
#define     IMAGESTRETCH(file,l,t) [[UIImage imageNamed:file] stretchableImageWithLeftCapWidth:l topCapHeight:t]

// Alert Dialog
#define     AlertContent(content) \
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" \
                                                            message:content \
                                                            delegate:nil   \
                                                    cancelButtonTitle:@"确定" \
                                                    otherButtonTitles:nil];  \
            [alert show];  \

// TableView Row index marco
enum eTableViewRowIndex
{
    eTableViewRowIndex00 = 0,
    eTableViewRowIndex01 ,
    eTableViewRowIndex02 ,
    eTableViewRowIndex03 ,
    eTableViewRowIndex04 ,
    eTableViewRowIndex05 ,
    eTableViewRowIndex06 ,
    eTableViewRowIndex07 ,
    eTableViewRowIndex08 ,
    eTableViewRowIndex09 ,
    eTableViewRowIndex10
};

/**
 *
 * #if TARGET_OS_IPHONE         //iPhone Device
 *
 * #if TARGET_IPHONE_SIMULATOR  //iPhone Simulator
 *
 */

#endif
