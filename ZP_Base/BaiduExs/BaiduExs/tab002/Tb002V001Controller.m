//
//  Tb002V001Controller.m
//  BaiduExs
//
//  Created by zhangpoor on 17/2/15.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "Tb002V001Controller.h"

#import <Masonry/Masonry.h>

@interface Tb002V001Controller ()

@end

@implementation Tb002V001Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}


- (void)createUI
{
  
    
    UIView *_v1         = [[UIView alloc]init];
    _v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:_v1];
    
    UIView *_v2         = [[UIView alloc]init];
    _v2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_v2];
    
    UIView *_v3         = [[UIView alloc]init];
    _v3.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_v3];
    
    
    
    UIView *_v11         = [[UIView alloc]init];
    _v11.backgroundColor = [UIColor redColor];
    [self.view addSubview:_v11];
    
    UIView *_v22         = [[UIView alloc]init];
    _v22.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_v22];
    /*
    UIView *_v33         = [[UIView alloc]init];
    _v33.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_v33];
    */
    
    [_v1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(80);
    }];
    
    [_v2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_v1);
        make.left.equalTo(_v1.mas_right).offset(5);
    }];
    
    [_v3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_v1);
        make.left.equalTo(_v2.mas_right).offset(5);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    
    [_v11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(_v1);
        make.top.equalTo(_v1.mas_bottom).offset(5);
        make.bottom.equalTo(self.view).offset(-80);
    }];
    
    [_v22 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_v11);
        make.left.equalTo(_v11.mas_right).offset(5);
        make.right.equalTo(_v3);
    }];
    /*
    [_v33 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_v11);
        make.left.equalTo(_v22.mas_right).offset(5);
        make.right.equalTo(_v3);
    }];
     */
    
    
    
}


@end
