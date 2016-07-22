//
//  ControllerE.m
//  Exc001
//
//  Created by zhangpoor on 16/7/4.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "ControllerE.h"

@interface ControllerE ()

@end

@implementation ControllerE

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(100, 100, 120, 50);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn addTarget:self action:@selector(btnActionE) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (void)btnActionE
{
    ControllerE *_c = [[ControllerE alloc]init];
    _c.title = @"eC";
    UINavigationController *_nav = [[UINavigationController alloc]initWithRootViewController:_c];
    [self presentViewController:_nav animated:YES completion:nil];
}


@end
