//
//  FirstNavController.m
//  TestReactiveNative
//
//  Created by zhangpoor on 16/7/21.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "FirstNavController.h"
#import "FirstRootController.h"


@interface FirstNavController ()

@end

@implementation FirstNavController


+(FirstNavController *)createNavController
{
    FirstRootController *_root = [[FirstRootController alloc]init];
    FirstNavController *_nav = [[FirstNavController alloc]initWithRootViewController:_root];
    
    return _nav;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
}







@end
