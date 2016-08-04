//
//  SecondRootController.m
//  TestReactiveNative
//
//  Created by zhangpoor on 16/7/21.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "SecondRootController.h"
#import "RNManager.h"

@interface SecondRootController ()

@end

@implementation SecondRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Second Page";
  
  
    [self initUI];
  
}

- (void)initUI
{
    self.view = [RNManager createViewWithProperties:nil moduleName:@"mView"];
}

@end
