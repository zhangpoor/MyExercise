//
//  NSMutableArray+ZHP.m
//  ZP_Base
//
//  Created by zhangpoor on 15/12/25.
//  Copyright © 2015年 zhangpoor. All rights reserved.
//

#import "NSMutableArray+ZHP.h"

@implementation NSMutableArray (ZHP)

-(void)addObjectSafely:(id)anObject
{
    if (anObject) {
        [self addObject:anObject];
    }
}

@end
