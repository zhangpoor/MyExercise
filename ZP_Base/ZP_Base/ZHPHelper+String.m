//
//  ZHPHelper+String.m
//  ZP_Base
//
//  Created by zhangpoor on 16/1/14.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "ZHPHelper+String.h"

@implementation ZHPHelper (String)

+(NSString *)fomatString:(id)input
{
    NSString *_result = @"";
    
    if (input && input != [NSNull null])
    {
        if ([input isKindOfClass:[NSString class]]) {
            _result = [(NSString *)input copy];
        }
        else if ([input isKindOfClass:[NSNumber class]])
        {
            _result = [(NSNumber *)input stringValue];
        }
    }
    
    return _result;
}

@end
