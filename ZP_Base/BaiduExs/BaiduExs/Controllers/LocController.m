//
//  LocController.m
//  BaiduExs
//
//  Created by zhangpoor on 17/1/20.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "LocController.h"
#import <Masonry/Masonry.h>

#import "YZTBaiduMapHelper.h"

@interface LocController ()

@property (nonatomic,strong)UILabel *locInfoLab;
@property (nonatomic,strong)UIButton *btnLoc;


@end

@implementation LocController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"定 位";
    [self createUI];
    
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _btnLoc = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnLoc setBackgroundColor:[UIColor grayColor]];
    [_btnLoc setTitle:@"定 位" forState:UIControlStateNormal];
    [_btnLoc addTarget:self
                action:@selector(locAciton:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnLoc];
    
    [_btnLoc mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.offset(30);
        make.top.offset(150);
        make.size.mas_equalTo(CGSizeMake(140, 40));
    }];
    
    _locInfoLab                     = [[UILabel alloc]init];
    _locInfoLab.text                = @"暂无信息";
    _locInfoLab.backgroundColor     = [UIColor grayColor];
    _locInfoLab.textColor           = [UIColor yellowColor];
    _locInfoLab.numberOfLines       = 0;
    _locInfoLab.textAlignment       = NSTextAlignmentLeft;
    [self.view addSubview:_locInfoLab];
    
    [_locInfoLab mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(self.btnLoc);
        make.top.equalTo(self.btnLoc.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(350, 200));
    }];
}

- (void)locAciton:(UIButton *)target
{
    target.enabled = NO;
    
    self.locInfoLab.text = @"开始定位~";
    
    __weak typeof(self) _weakSelf = self;
    [[YZTBaiduMapHelper shareMapHelper] yztBaiduLocate:
     ^(BOOL isSuccess, YZTBaiduLocModel *param, NSString *errorStr) {
         NSString *_str = errorStr;
         if (isSuccess) {
             
             _str = [NSString stringWithFormat:@"lat:%lf,\nlng:%lf",
                     param.location.coordinate.latitude,param.location.coordinate.longitude];
      
         }
         
         _weakSelf.locInfoLab.text = _str;
         
         
         target.enabled = YES;
     }];
}

@end
