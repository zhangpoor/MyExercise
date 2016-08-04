//
//  FirstRootController.m
//  TestReactiveNative
//
//  Created by zhangpoor on 16/7/21.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "FirstRootController.h"
#import "RNManager.h"

@interface FirstRootController ()



@end

@implementation FirstRootController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
    
  self.title = @"Firt Page";
  
  [self initUI];
  

}

- (void)initUI
{
  self.view = [RNManager createViewWithProperties:nil moduleName:@"TestRedux"];
  

}

@end
