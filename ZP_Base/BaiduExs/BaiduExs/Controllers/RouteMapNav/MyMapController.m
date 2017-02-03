//
//  MapController.m
//  BaiduExs
//
//  Created by zhangpoor on 17/1/23.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "MyMapController.h"
#import <Masonry/Masonry.h>

#import "YZTBaiduMapHelper.h"


@interface MyMapController ()
{
    YZTBaiduLocModel *_locParam;
}


@end

@implementation MyMapController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[YZTBaiduMapHelper shareMapHelper] mapWillAppear];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[YZTBaiduMapHelper shareMapHelper] mapWillDisappear];
    
}


- (void)dealloc {
    [[YZTBaiduMapHelper shareMapHelper] clearMap];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    
    [self createUI];
    
}



- (void)initData
{

}

- (void)createUI
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    
    UIButton *_btnLoc = [UIButton buttonWithType:UIButtonTypeSystem];
    _btnLoc.frame = CGRectMake(0, 0, 100, 40);
    [_btnLoc setBackgroundColor:[UIColor grayColor]];
    [_btnLoc setTitle:@"到当前位置" forState:UIControlStateNormal];
    [_btnLoc addTarget:self
                action:@selector(locAciton)
      forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btnLoc];

    
    
    UIButton *_zoomAdd  = [UIButton buttonWithType:UIButtonTypeSystem];
    _zoomAdd.tag        = 101;
    [_zoomAdd setBackgroundColor:[UIColor grayColor]];
    [_zoomAdd setTitle:@"放大" forState:UIControlStateNormal];
    [_zoomAdd addTarget:self
                action:@selector(zoomAciton:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zoomAdd];
    [_zoomAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.top.offset(70);
        
        CGSize _s = {60,40};
        
        make.size.mas_equalTo(_s);
    }];
    
    UIButton *_zoomDri  = [UIButton buttonWithType:UIButtonTypeSystem];
    _zoomDri.tag        = 102;
    [_zoomDri setBackgroundColor:[UIColor grayColor]];
    [_zoomDri setTitle:@"缩小" forState:UIControlStateNormal];
    [_zoomDri addTarget:self
                 action:@selector(zoomAciton:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zoomDri];
    [_zoomDri mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_zoomAdd.mas_right).offset(5);
        make.top.equalTo(_zoomAdd);
        make.size.equalTo(_zoomAdd);
    }];
    
    UIButton *_nearBy  = [UIButton buttonWithType:UIButtonTypeSystem];
    [_nearBy setBackgroundColor:[UIColor grayColor]];
    [_nearBy setTitle:@"麦当劳" forState:UIControlStateNormal];
    [_nearBy addTarget:self
                action:@selector(nearByAciton)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zoomDri];
    [_nearBy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_zoomAdd.mas_right).offset(5);
        make.top.equalTo(_zoomAdd);
        make.size.equalTo(_zoomAdd);
    }];
    
    
    UIView *_mapView = [[YZTBaiduMapHelper shareMapHelper] getBaiduMapViewithZoomLv:5];
    

    [self.view addSubview:_mapView];
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.offset(5);
        make.right.offset(-5);
        make.bottom.offset(-5);
        make.top.mas_equalTo(_zoomAdd.mas_bottom).offset(5);
    }];

}


- (void)locAciton
{
    __block YZTBaiduMapHelper *_bdHelper    = [YZTBaiduMapHelper shareMapHelper];
    [_bdHelper showUserCompletion:^(BOOL isSuccess, YZTBaiduLocModel *param, NSString *eMsg) {
        
        if (isSuccess) {
            _locParam = param;
        }
        
    } ];

}

- (void)zoomAciton:(UIButton *)sender
{
    switch (sender.tag) {
        case 101:
        {
            [[YZTBaiduMapHelper shareMapHelper] mapZoomAction:1];
        }
            break;
        case 102:
        {
            [[YZTBaiduMapHelper shareMapHelper] mapZoomAction:-1];
        }
            break;
        default:
            break;
    }
    
}

- (void)nearByAciton
{
    
    __block YZTBaiduMapHelper *_bdHelper    = [YZTBaiduMapHelper shareMapHelper];
    
    if (_locParam) {
        
        [_bdHelper showUserCompletion:^(BOOL isSuccess, YZTBaiduLocModel *param, NSString *eMsg) {
            
            if (isSuccess) {
                
                _locParam = param;
                
                
                
            }
            
        } ];
    }
    else
    {
    
    }
}


@end
