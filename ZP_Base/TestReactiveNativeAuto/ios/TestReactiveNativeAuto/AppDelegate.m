/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"
#import "MainTabBarController.h"



#import "RNManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  [RNManager sharedInstance];
  
  
  self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
  self.window.backgroundColor = [UIColor grayColor];
  [self.window makeKeyAndVisible];
  
  
  MainTabBarController *_rootController = [[MainTabBarController alloc]init];
  
  
  self.window.rootViewController = _rootController;
  return YES;
}

@end
