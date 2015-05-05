//
//  UIView+SCExtend.m
//  SCUtility
//
//  Created by Jarry on 12-11-14.
//  Copyright (c) 2012年 Jarry. All rights reserved.
//

#import "UIView+SCExtend.h"

@implementation UIView (SCExtend)

- (CGFloat) x
{
    return self.frame.origin.x;
}
- (CGFloat) y
{
    return self.frame.origin.y;
}
- (CGFloat) width
{
    return self.frame.size.width;
}
- (CGFloat) height
{
    return self.frame.size.height;
}

- (UIView *) setFrameEX:(CGRect) frame
{
    self.frame = frame;
    return self;
}

- (CGFloat) maxWidth
{
    return self.x + self.width;
}

- (CGFloat) maxHeight
{
    return self.y + self.height;
}

- (UIView *) setFrameX:(CGFloat) x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
    return self;
}
- (UIView *) setFrameY:(CGFloat) y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
    return self;
}
- (UIView *) setFrameWidth:(CGFloat) width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
    return self;
}
- (UIView *) setFrameHeight:(CGFloat) height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
    return self;
}
- (UIView *) setBoundsX:(CGFloat) x
{
    CGRect rect = self.bounds;
    rect.origin.x = x;
    self.bounds = rect;
    return self;
}
- (UIView *) setBoundsY:(CGFloat) y
{
    CGRect rect = self.bounds;
    rect.origin.y = y;
    self.bounds = rect;
    return self;
}
- (UIView *) setBoundsWidth:(CGFloat) width
{
    CGRect rect = self.bounds;
    rect.size.width = width;
    self.bounds = rect;
    return self;
}
- (UIView *) setBoundsHeight:(CGFloat) height
{
    CGRect rect = self.bounds;
    rect.size.height = height;
    self.bounds = rect;
    return self;
}

- (UIView *) setFrameOrigin:(CGPoint) origin
{
    CGRect rect = self.frame;
    rect.origin = origin;
    self.frame = rect;
    return self;
}
- (UIView *) setFrameSize:(CGSize) size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame = rect;
    return self;
}
- (UIView *) setBoundsOrigin:(CGPoint) origin
{
    CGRect rect = self.bounds;
    rect.origin = origin;
    self.bounds = rect;
    return self;
}
- (UIView *) setBoundsSize:(CGSize) size
{
    CGRect rect = self.bounds;
    rect.size = size;
    self.bounds = rect;
    return self;
}

- (UIView *) setExtendHeight:(CGFloat) height
{
    CGRect rect = self.frame;
    rect.origin.y += height;
    rect.size.height -= height;
    self.frame = rect;
    return self;
}
- (UIView *) setExtendWidth:(CGFloat) width
{
    CGRect rect = self.frame;
    rect.origin.x += width;
    rect.size.width -= width;
    self.frame = rect;
    return self;
}

- (UIView *) setShiftVertical:(CGFloat) vertical
{
    CGRect rect = self.frame;
    rect.origin.y += vertical;
    self.frame = rect;
    return self;
}
- (UIView *) setShiftHorizon:(CGFloat) horizon
{
    CGRect rect = self.frame;
    rect.origin.x += horizon;
    self.frame = rect;
    return self;
}
- (UIView *) addFillSubView:(UIView *) subView
{
    [subView setFrame:self.bounds];
    [self addSubview:subView];
    return self;
}


- (UIView *) emptySubviews
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    return self;
}

- (UIImageView *) addBackgroundImage:(NSString *)imageName
{
    UIImage *bgImage = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:bgImage];
    [imageView setFrame:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    [self setFrameSize:imageView.frame.size];
    [self addSubview:imageView];
    [self sendSubviewToBack:imageView];
    
    return imageView;
}

- (UIImageView *) addBackgroundStretchableImage:(NSString *)imageName
                                   leftCapWidth:(CGFloat)leftCapWidth
                                   topCapHeight:(CGFloat)topCapHeight
{
    UIImage *bgImage = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:leftCapWidth
                                                                           topCapHeight:topCapHeight];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:bgImage];
    imageView.backgroundColor = CLEAR_COLOR;
    [self addFillSubView:imageView];
    [self sendSubviewToBack:imageView];
    
    return imageView;
}

- (void) addBackgroundColor:(NSString *)imageName
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
}

- (id) addBottomShadow
{
    self.layer.masksToBounds = NO;
    self.layer.shadowRadius  = 3.0f;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowColor   = [[UIColor blackColor] CGColor];
    self.layer.shadowOffset  = CGSizeZero;
    self.layer.shadowPath    = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
    
    return self;
}

@end
