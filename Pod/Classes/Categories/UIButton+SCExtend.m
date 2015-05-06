//
//  UIButton+SCExtend.m
//  SCUtility
//
//  Created by jarry on 1/7/13.
//  Copyright (c) 2013 jarry. All rights reserved.
//

#import "UIButton+SCExtend.h"

@implementation UIButton (SCExtend)

- (void) setNormalTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}

- (void) setNormalColor:(UIColor *)color
{
    if (color) {
        [self setTitleColor:color forState:UIControlStateNormal];
    }
}

- (void) setNormalColor:(UIColor *)color highlighted:(UIColor *)highlighted selected:(UIColor *)selected
{
    if (color) {
        [self setTitleColor:color forState:UIControlStateNormal];
    }
    if (highlighted) {
        [self setTitleColor:highlighted forState:UIControlStateHighlighted];
    }
    if (selected) {
        [self setTitleColor:highlighted forState:UIControlStateSelected];
    }
}

- (void) setNormalTitleColor:(UIColor *)normalColor
               disableColor:(UIColor *)disableColor
{
    if (normalColor) {
        [self setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (disableColor) {
        [self setTitleColor:disableColor forState:UIControlStateDisabled];
    }
}

- (void) setNormalImage:(NSString *)imageNormal
          selectedImage:(NSString *)imageSelected
{
    [self setNormalImage:imageNormal hilighted:imageSelected selectedImage:imageSelected];
}


- (void) setNormalImageEx:(UIImage *)imageNormal
          selectedImageEx:(UIImage *)imageSelected
{
    [self setImage:imageNormal forState:UIControlStateNormal];
    if (imageSelected) {
        [self setImage:imageSelected forState:UIControlStateHighlighted];
    }
    if (imageSelected) {
        [self setImage:imageSelected forState:UIControlStateSelected];
    }
}


- (void) setNormalImage:(NSString *)imageNormal
              hilighted:(NSString *)imageHilight
          selectedImage:(NSString *)imageSelected
{
    if (imageNormal) {
        UIImage *image1 = [UIImage imageNamed:imageNormal];
        [self setImage:image1 forState:UIControlStateNormal];
    }
    
    if (imageHilight) {
        UIImage *image2 = [UIImage imageNamed:imageHilight];
        [self setImage:image2 forState:UIControlStateHighlighted];
    }
    if (imageSelected) {
        UIImage *image3 = [UIImage imageNamed:imageSelected];
        [self setImage:image3 forState:UIControlStateSelected];
    }
}


- (void) setBackgroundImage:(NSString *)imageNormal
                  hilighted:(NSString *)imageHilight
              selectedImage:(NSString *)imageSelected
{
    if (imageNormal) {
        UIImage *image1 = [UIImage imageNamed:imageNormal];
        [self setBackgroundImage:image1 forState:UIControlStateNormal];
    }
    if (imageSelected) {
        UIImage *image2 = [UIImage imageNamed:imageSelected];
        [self setBackgroundImage:image2 forState:UIControlStateSelected];
    }
    if (imageHilight) {
        UIImage *image3 = [UIImage imageNamed:imageHilight];
        [self setBackgroundImage:image3 forState:UIControlStateHighlighted];
    }
}

- (void) setBackgroundStretchImage:(NSString *)imageNormal
                     selectedImage:(NSString *)imageSelected
                      leftCapWidth:(CGFloat)leftCapWidth
                      topCapHeight:(CGFloat)topCapHeight
{
    UIImage *normalImage = [[UIImage imageNamed:imageNormal] stretchableImageWithLeftCapWidth:leftCapWidth
                                                                                 topCapHeight:topCapHeight];
    [self setBackgroundImage:normalImage forState:UIControlStateNormal];

    if (imageSelected) {
        UIImage *selectImage = [[UIImage imageNamed:imageSelected] stretchableImageWithLeftCapWidth:leftCapWidth
                                                                                       topCapHeight:topCapHeight];
        [self setBackgroundImage:selectImage forState:UIControlStateSelected];
        [self setBackgroundImage:selectImage forState:UIControlStateHighlighted];
    }
}

- (void) doExchangeImage
{
    UIImage *normalImage    = [self imageForState:UIControlStateNormal];
    UIImage *selectedImage  = [self imageForState:UIControlStateSelected];
    
    if (normalImage != selectedImage)
    {
        [self setImage:normalImage forState:UIControlStateSelected];
        [self setImage:selectedImage forState:UIControlStateNormal];
    }
}

@end
