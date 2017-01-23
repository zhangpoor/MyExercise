//
//  POIController.m
//  BaiduExs
//
//  Created by zhangpoor on 17/1/22.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "POIController.h"
#import <Masonry/Masonry.h>

#import "YZTBaiduMapHelper.h"

#import "My001TableCell.h"

@interface POIController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UIButton *btnLoc;

@property (nonatomic,strong)UITableView *poiTb;
@property (nonatomic,strong)NSArray *poiList;

@end

@implementation POIController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self createUI];
    
}

//-(void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    
//    
//    if ([self.poiTb respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.poiTb setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
//    
//    if ([self.poiTb respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.poiTb setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
//    }
//}

- (void)initData
{
    self.poiList = @[];
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor lightGrayColor];

//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.navigationBar.translucent = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    
    
    self.poiTb                  = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.poiTb.delegate         = self;
    self.poiTb.dataSource       = self;
    self.poiTb.separatorStyle   = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.poiTb];
    
    [_poiTb mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.offset(5);
        make.top.mas_equalTo(_btnLoc.mas_bottom).offset(5);
        make.right.mas_equalTo(self.view.mas_right).offset(-5);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-5);
    }];
}

- (void)locAciton:(UIButton *)target
{
    
    target.enabled = NO;

    
    
    __block YZTBaiduMapHelper *_bdHelper    = [YZTBaiduMapHelper shareMapHelper];
    __weak typeof (target) _weakBtn         = target;
    __weak typeof(self) _weakSelf           = self;
    
    
    [_bdHelper yztBaiduLocate:
     ^(BOOL isSuccess, YZTBaiduLocModel *param, NSString *errorStr) {

         if (isSuccess) {
             
             [_bdHelper yztBizNearByWithLocation:param.location.coordinate
                                       pageIndex:0
                                         keyword:@"麦当劳"
                                        callback:
              ^(BOOL isSuccess, YZTBaiduPOIModel *poiParam, NSString *poiErrorMsg) {
                  if (isSuccess) {
                      _weakSelf.poiList = poiParam.poiInfoList;
                  }
                  else
                  {
                      _weakSelf.poiList = @[];
                  }
                  
                  [_weakSelf.poiTb reloadData];
                  _weakBtn.enabled = YES;
              }];
             
             
         }
         else
         {

             _weakSelf.poiList = @[];
             [_weakSelf.poiTb reloadData];
             _weakBtn.enabled = YES;
             
         }
 
     }];
    
}






#pragma mark- <table delegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.poiList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"TC_My001TableCell";
    My001TableCell *_cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (_cell == nil) {
        _cell = [[My001TableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    YZTBaiduPOIInfoModel *_poi = self.poiList[indexPath.row];
    
    _cell.leftLab.text  = _poi.name;
    _cell.rightLab.text = _poi.address;
    
    
    return _cell;
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

@end
