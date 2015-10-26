//
//  UIView+SCExtend.h
//  SCUtility
//
//  Created by Jarry on 12-11-14.
//  Copyright (c) 2012年 Jarry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SCExtend)

- (CGFloat) x;
- (CGFloat) y;
- (CGFloat) width;
- (CGFloat) height;
- (CGFloat) maxWidth;
- (CGFloat) maxHeight;

- (UIView *) setFrameEX:(CGRect) frame;
- (UIView *) setFrameX:(CGFloat) x;
- (UIView *) setFrameY:(CGFloat) y;
- (UIView *) setFrameWidth:(CGFloat) width;
- (UIView *) setFrameHeight:(CGFloat) height;
- (UIView *) setBoundsX:(CGFloat) x;
- (UIView *) setBoundsY:(CGFloat) y;
- (UIView *) setBoundsWidth:(CGFloat) width;
- (UIView *) setBoundsHeight:(CGFloat) height;
- (UIView *) setFrameOrigin:(CGPoint) origin;
- (UIView *) setFrameSize:(CGSize) size;
- (UIView *) setBoundsOrigin:(CGPoint) origin;
- (UIView *) setBoundsSize:(CGSize) size;

- (UIView *) setExtendHeight:(CGFloat) height;
- (UIView *) setExtendWidth:(CGFloat) width;

- (UIView *) setShiftVertical:(CGFloat) vertical;
- (UIView *) setShiftHorizon:(CGFloat) horizon;

- (UIView *) addFillSubView:(UIView *) subView;

- (UIView *) emptySubviews;

/**
 *  UIView添加背景图片，view大小为图片大小
 */
- (UIImageView *) addBackgroundImage:(NSString *)imageName;
/**
 *  UIView添加背景图片，图片拉伸为view大小
 */
- (UIImageView *) addBackgroundStretchableImage:(NSString *)imageName
                                   leftCapWidth:(CGFloat)leftCapWidth
                                   topCapHeight:(CGFloat)topCapHeight;
/**
 *  UIView添加背景图片，图片平铺
 */
- (void) addBackgroundColor:(NSString *)imageName;

- (id) addBottomShadow;

/*
 Description - Returns a UIImage object of a "screenshot" of the view.
 */
- (UIImage *)screenshot;

- (UIImage *)screenshotWithOffset:(CGFloat)deltaY;

/*!
 *	@brief	create a snapshop of current view
 *
 *	@return	the snapshop image
 */
- (UIImage *)snapShopImage;

@end
