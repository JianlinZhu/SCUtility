//
//  NSObject+Block.h
//  SCUtility (GCD)
//
//  Created by Jarry on 6/28/14.
//  Copyright (c) 2014 Jarry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SCBlock)

- (void) performBlock:(voidBlock) block;
- (void) performBlock:(voidBlock) block afterDelay:(NSTimeInterval) delay;

@end
