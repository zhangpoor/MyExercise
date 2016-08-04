//
//  RNManager.h
//  TestReactiveNativeAuto
//
//  Created by zhangpoor on 16/7/21.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "BaseManager.h"
#import "RCTRootView.h"
#import "RCTBridge.h"

@interface RNManager : BaseManager



+ (instancetype)sharedInstance;


+ (UIView *)createViewWithProperties:(NSDictionary *)info moduleName:(NSString *)mName;


@end
