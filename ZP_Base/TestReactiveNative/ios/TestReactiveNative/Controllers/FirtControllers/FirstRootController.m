//
//  FirstRootController.m
//  TestReactiveNative
//
//  Created by zhangpoor on 16/7/21.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "FirstRootController.h"

@interface FirstRootController ()

@end

@implementation FirstRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Firt Page";
    /*
    NSURL *jsCodeLocation;
    
    [[RCTBundleURLProvider sharedSettings] setDefaults];
    jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"TestReactNativeProject"
                                                 initialProperties:nil
                                                     launchOptions:launchOptions];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
     */
    
}

- (void)initRN
{

}

@end
