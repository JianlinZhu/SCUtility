//
//  NSObject+Block.m
//  SCUtility
//
//  Created by Jarry on 6/28/14.
//  Copyright (c) 2014 Jarry. All rights reserved.
//

#import "NSObject+SCBlock.h"

@implementation NSObject (SCBlock)

-(void) callBlock:(voidBlock)block
{
    if (block) {
        block();
    }
}

- (void) performBlock:(voidBlock)aBlock
{
    GCD_MAIN(aBlock);
}

- (void) performBlock:(voidBlock)aBlock afterDelay:(NSTimeInterval)delay
{
    GCD_DELAY(aBlock, delay);
}

@end
