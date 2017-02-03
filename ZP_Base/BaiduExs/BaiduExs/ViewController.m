//
//  ViewController.m
//  BaiduExs
//
//  Created by zhangpoor on 17/1/17.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>


#import "LocController.h"
#import "GeoController.h"
#import "POIController.h"
#import "MyMapController.h"

@interface ViewController ()
{
    CGFloat _btnDY;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _btnDY = 10;
    
    [self createUI];
}


- (void)createUI
{
    UIButton *_btnLoc = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnLoc setBackgroundColor:[UIColor grayColor]];
    [_btnLoc setTitle:@"定 位" forState:UIControlStateNormal];
    [_btnLoc addTarget:self
                action:@selector(locAciton)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnLoc];
    
    [_btnLoc mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.offset(30);
        make.top.offset(100);
        make.size.mas_equalTo(CGSizeMake(140, 40));
    }];
    
    
    UIButton *_btnRGeo = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnRGeo setBackgroundColor:[UIColor grayColor]];
    [_btnRGeo setTitle:@"反地理编码" forState:UIControlStateNormal];
    [_btnRGeo addTarget:self
                action:@selector(rGeoAciton)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnRGeo];
    
    [_btnRGeo mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(_btnLoc);
        make.top.equalTo(_btnLoc.mas_bottom).offset(_btnDY);
        make.size.equalTo(_btnLoc);
    }];
    
    UIButton *_btnPOI = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnPOI setBackgroundColor:[UIColor grayColor]];
    [_btnPOI setTitle:@"周边查询" forState:UIControlStateNormal];
    [_btnPOI addTarget:self
                 action:@selector(poiAciton)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnPOI];
    
    [_btnPOI mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(_btnRGeo);
        make.top.equalTo(_btnRGeo.mas_bottom).offset(_btnDY);
        make.size.equalTo(_btnRGeo);
    }];
    
    UIButton *_btnMap = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnMap setBackgroundColor:[UIColor grayColor]];
    [_btnMap setTitle:@"百度地图" forState:UIControlStateNormal];
    [_btnMap addTarget:self
                action:@selector(mapAciton)
      forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnMap];
    
    [_btnMap mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(_btnPOI);
        make.top.equalTo(_btnPOI.mas_bottom).offset(_btnDY);
        make.size.equalTo(_btnPOI);
    }];
    
    
}



#pragma mark- <Actions>
- (void)locAciton
{
    LocController *_locVC = [[LocController alloc]init];
    
    [self.navigationController pushViewController:_locVC animated:YES];
}

- (void)rGeoAciton
{
    GeoController *_geoVC = [[GeoController alloc]init];
    
    [self.navigationController pushViewController:_geoVC animated:YES];
}

- (void)poiAciton
{
    POIController *_poiVC = [[POIController alloc]init];
    
    [self.navigationController pushViewController:_poiVC animated:YES];
}

- (void)mapAciton
{
    MyMapController *_mapVC = [[MyMapController alloc]init];

    
    
    [self.navigationController pushViewController:_mapVC animated:YES];
}


@end
