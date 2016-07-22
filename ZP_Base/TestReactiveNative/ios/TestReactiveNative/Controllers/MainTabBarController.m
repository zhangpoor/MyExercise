//
//  MainTabBarController.m
//  TestReactiveNative
//
//  Created by zhangpoor on 16/7/21.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "MainTabBarController.h"
#import "FirstNavController.h"
#import "SecondNavController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initSubControllers];
}

- (void)initSubControllers
{
    FirstNavController *_fVc    = [FirstNavController createNavController];
    SecondNavController *_sVc   = [SecondNavController createNavController];
    
    
    self.viewControllers = @[_fVc,_sVc];
    self.selectedIndex = 0;
}

@end
