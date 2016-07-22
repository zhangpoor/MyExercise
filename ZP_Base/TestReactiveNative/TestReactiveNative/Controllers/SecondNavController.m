//
//  SecondNavController.m
//  TestReactiveNative
//
//  Created by zhangpoor on 16/7/21.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "SecondNavController.h"
#import "SecondRootController.h"


@interface SecondNavController ()

@end

@implementation SecondNavController

+(SecondNavController *)createNavController
{
    SecondRootController *_root = [[SecondRootController alloc]init];
    SecondNavController *_nav = [[SecondNavController alloc]initWithRootViewController:_root];
    
    return _nav;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



@end
