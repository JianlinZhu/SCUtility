//
//  UIButton+SCExtend.h
//  SCUtility
//
//  Created by jarry on 1/7/13.
//  Copyright (c) 2013 jarry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SCExtend)

- (void) setNormalTitle:(NSString *)title;

- (void) setNormalColor:(UIColor *)color;

- (void) setNormalColor:(UIColor *)color highlighted:(UIColor *)highlighted selected:(UIColor *)selected;

- (void) setNormalTitleColor:(UIColor *)normalColor
                disableColor:(UIColor *)disableColor;

- (void) setNormalImage:(NSString *)imageNormal
          selectedImage:(NSString *)imageSelected;

- (void) setNormalImageEx:(UIImage *)imageNormal
          selectedImageEx:(UIImage *)imageSelected;

- (void) setNormalImage:(NSString *)imageNormal
              hilighted:(NSString *)imageHilight
          selectedImage:(NSString *)imageSelected;

- (void) setBackgroundImage:(NSString *)imageNormal
                  hilighted:(NSString *)imageHilight
              selectedImage:(NSString *)imageSelected;

- (void) setBackgroundStretchImage:(NSString *)imageNormal
                     selectedImage:(NSString *)imageSelected
                      leftCapWidth:(CGFloat)leftCapWidth
                      topCapHeight:(CGFloat)topCapHeight;


- (void) doExchangeImage;


@end
