//
//  RNManager.m
//  TestReactiveNativeAuto
//
//  Created by zhangpoor on 16/7/21.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "RNManager.h"
#import "RCTBundleURLProvider.h"


@interface RNManager()<RCTBridgeDelegate>

@property(nonatomic,strong)NSURL *jsCodeLocation;

@end


@implementation RNManager


+ (instancetype)sharedInstance {
  
  static RNManager *_sharedClient = nil;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    _sharedClient               = [[RNManager alloc] init];
    [_sharedClient startService];
  });
  
  return _sharedClient;
}

-(void)startService
{
  [[RCTBundleURLProvider sharedSettings] setDefaults];
  self.jsCodeLocation =
  [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"JS_IOS/MainInterface" fallbackResource:nil];
}

+ (UIView *)createViewWithProperties:(NSDictionary *)info
{
  RCTBridge *_rctBridge= [[RCTBridge alloc] initWithDelegate:[RNManager sharedInstance]
                                               launchOptions:nil];
  
  RCTRootView *rootView = [[RCTRootView alloc]initWithBridge:_rctBridge
                                                  moduleName:@"mView"
                                           initialProperties:info];
  
  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
  
  return rootView;
}



#pragma mark -<RCTBirdge Delegate>
- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return self.jsCodeLocation;
}

/*
- (NSURL *)fallbackSourceURLForBridge:(RCTBridge *)bridge
{
  
}


- (NSArray *)extraModulesForBridge:(RCTBridge *)bridge;
{

}

- (void)loadSourceForBridge:(RCTBridge *)bridge
                  withBlock:(RCTSourceLoadBlock)loadCallback
{

}
*/
@end
