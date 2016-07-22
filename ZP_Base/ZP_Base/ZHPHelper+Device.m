//
//  ZHPHelper+Device.m
//  ZP_Base
//
//  Created by zhangpoor on 16/6/21.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "ZHPHelper+Device.h"

@implementation ZHPHelper (Device)

+ (NSString *)appVersion
{
    NSDictionary * productInfo = [[NSBundle mainBundle] infoDictionary];
    return [productInfo objectForKey:@"CFBundleShortVersionString"];
}
+ (NSString *)buildVersion
{
    NSDictionary * productInfo = [[NSBundle mainBundle] infoDictionary];
    return [productInfo objectForKey:@"CFBundleVersion"];
}

@end
