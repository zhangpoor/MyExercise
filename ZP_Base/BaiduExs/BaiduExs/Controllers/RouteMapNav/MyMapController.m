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
    BOOL _abc;
}

@end

@implementation MyMapController

-(BOOL)abc
{
    return _abc;
}

- (void)setAbc:(BOOL)abc
{
    _abc = abc;
}

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

    
    
    
    UIView *_mapView = [[YZTBaiduMapHelper shareMapHelper] getBaiduMapView];
    

    [self.view addSubview:_mapView];
    
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.offset(5);
        make.right.offset(-5);
        make.bottom.offset(-5);
        make.top.offset(70);
    }];

}


- (void)locAciton
{
    __block YZTBaiduMapHelper *_bdHelper    = [YZTBaiduMapHelper shareMapHelper];

    
    
    [_bdHelper yztBaiduLocate:
     ^(BOOL isSuccess, YZTBaiduLocModel *param, NSString *errorStr) {
         
         if (isSuccess) {
             
             
             [_bdHelper mapMoveToLocation:param.location.coordinate];
             
         }
         
         
     }];

}



@end
