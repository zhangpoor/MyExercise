//
//  POIController.h
//  BaiduExs
//
//  Created by zhangpoor on 17/1/22.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YZTBaiduMapHelper.h"
#import "MyMapController.h"


@class YZTBaiduPOIInfoModel;

@protocol POIDelegate <NSObject>

@optional
-(void)cellClick:(YZTBaiduPOIInfoModel *)poiInfo;

@end



@interface POIController : UIViewController

@property(nonatomic,strong)YZTBaiduLocModel *locModel;
@property(nonatomic,weak)id<POIDelegate> delegate;

@end
