//
//  POIController.m
//  BaiduExs
//
//  Created by zhangpoor on 17/1/22.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "POIController.h"
#import <Masonry/Masonry.h>

@interface POIController ()


@property (nonatomic,strong)UIButton *btnLoc;

@end

@implementation POIController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _btnLoc = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnLoc setBackgroundColor:[UIColor grayColor]];
    [_btnLoc setTitle:@"定位并反地理编码" forState:UIControlStateNormal];
    [_btnLoc addTarget:self
                action:@selector(locAciton:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnLoc];
    
    [_btnLoc mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.offset(30);
        make.top.offset(80);
        make.size.mas_equalTo(CGSizeMake(140, 40));
    }];
    /*
    _infoLab                     = [[UITextView alloc]init];
    _infoLab.text                = @"暂无信息";
    _infoLab.backgroundColor     = [UIColor grayColor];
    _infoLab.textColor           = [UIColor yellowColor];
    _infoLab.showsVerticalScrollIndicator = YES;
    _infoLab.showsHorizontalScrollIndicator = NO;
    _infoLab.textAlignment       = NSTextAlignmentLeft;
    [self.view addSubview:_infoLab];
    
    [_infoLab mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(self.btnLoc);
        make.top.equalTo(self.btnLoc.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(350, 300));
    }];
     */
}

- (void)locAciton:(UIButton *)target
{
    /*
    target.enabled = NO;
    self.infoLab.text = @"开始定位~";
    
    
    __block YZTBaiduMapHelper *_bdHelper = [YZTBaiduMapHelper shareMapHelper];
    
    __weak typeof (target) _weakBtn = target;
    __weak typeof(self) _weakSelf = self;
    [_bdHelper yztBaiduLocate:
     ^(BOOL isSuccess, YZTBaiduLocModel *param, NSString *errorStr) {
         __block NSString *_str = _weakSelf.infoLab.text;
         if (isSuccess) {
             
             _str = [_str stringByAppendingFormat:@"\nlat:%lf,\nlng:%lf",
                     param.location.coordinate.latitude,param.location.coordinate.longitude];
             _weakSelf.infoLab.text = _str;
     
             [_bdHelper yztBadiduReverseGeoCodeWithPoint:param.location.coordinate//_loc//
                                                callback:
              ^(BOOL isSuccess, YZTBaiduGeoModel *geoParam, NSString *geoErrorMsg) {
                  if (isSuccess) {
                      _str = [_str stringByAppendingFormat:@"\n%@",geoParam.address];
                  }
                  else
                  {
                      _str = [_str stringByAppendingFormat:@"\nl%@",errorStr];
                      
                  }
                  
                  _weakSelf.infoLab.text = _str;
                  _weakBtn.enabled = YES;
              }];
             //}
             
             
             
         }
         else
         {
             _str = [_str stringByAppendingFormat:@"\nl%@",errorStr];
             _weakSelf.infoLab.text = _str;
             _weakBtn.enabled = YES;
         }
         
         
         
         
     }];
     */
}

@end
