//
//  YZTBaiduRounteMapMananger.m
//  BaiduExs
//
//  Created by zhangpoor on 17/1/23.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "YZTBaiduMapMananger.h"





@implementation YZTBaiduMapMananger





#pragma mark -- BMKMapViewDelegate
/*
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *view = [[BMKPolylineView alloc] initWithOverlay:overlay];
        // 设置属性
        
        //view.strokeColor = [UIColor yzt_colorWithHexString:@"#44c17f"];
        view.layer.borderWidth = 0.5;
        //view.layer.borderColor = [UIColor yzt_colorWithHexString:@"23a660"].CGColor;
        view.lineWidth = 10;
        return view;
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    //取消上一次选中图标
    view.image = [UIImage imageNamed:@"insurance_Point"];
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    
    //设置选中图标
    
    view.image = [UIImage imageNamed:@"insurance_endPoint"];
    
    self.endAnnotation = [[BMKPointAnnotation alloc] init];
    self.endAnnotation.coordinate = [view.annotation coordinate];
    self.endAnnotation.title = [view.annotation title];
    [self yzt_reLocationAndReseletedLine];
 
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        if (annotation == self.startAnnotation) {
            BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
            newAnnotationView.image = [UIImage imageNamed:@"insurance_startPoint"];
            return newAnnotationView;
        }else {
            BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
            newAnnotationView.image = annotation == self.endAnnotation ? [UIImage imageNamed:@"insurance_endPoint"] : [UIImage imageNamed:@"insurance_Point"];
            UIView *popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 70)];
            UIImageView *backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 260, 60)];
            backView.image = [UIImage imageNamed:@"insurance_paopao"];
            [popView addSubview:backView];
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.text = annotation.title;
            titleLabel.numberOfLines = 2;
            titleLabel.font = YZTFont(14);
            titleLabel.textColor = [UIColor whiteColor];
            [popView addSubview:titleLabel];
            
            UIView *btnView = [[UIView alloc] init];
            btnView.layer.cornerRadius = 15;
            btnView.layer.masksToBounds = YES;
            btnView.backgroundColor = RGB(255, 65, 65);
            [popView addSubview:btnView];
            
            [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(popView.mas_right).offset(-10);
                make.top.equalTo(popView.mas_top).offset(12);
                make.size.mas_equalTo(CGSizeMake(80, 30));
            }];
            
            UILabel *directLabel = [[UILabel alloc] init];
            directLabel.text = @"导航";
            directLabel.textColor = [UIColor whiteColor];
            directLabel.font = YZTFont(14);
            [btnView addSubview:directLabel];
            
            [directLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(btnView.mas_left).offset(12);
                make.centerY.equalTo(btnView.mas_centerY);
            }];
            
            UIImageView *directImgView = [[UIImageView alloc] init];
            directImgView.image = [UIImage imageNamed:@"insurance_path"];
            [btnView addSubview:directImgView];
            
            [directImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btnView.mas_right).offset(-12);
                make.centerY.equalTo(btnView.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(17, 16.5));
            }];
            
            UIButton *directButton = [UIButton buttonWithType:UIButtonTypeCustom];
            directButton.backgroundColor = [UIColor clearColor];
            [popView addSubview:directButton];
            [directButton addTarget:self action:@selector(OpenMapClientAction) forControlEvents:UIControlEventTouchUpInside];
            
            [directButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(popView.mas_right);
                make.top.equalTo(popView.mas_top);
                make.size.mas_equalTo(CGSizeMake(80, 54));
            }];
            
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(popView.mas_left).offset(10);
                make.right.equalTo(directButton.mas_left).offset(-10);
                make.centerY.equalTo(directButton.mas_centerY);
            }];
            
            BMKActionPaopaoView *paopaoView = [[BMKActionPaopaoView alloc] initWithCustomView:popView];
            
            newAnnotationView.paopaoView = nil;
            newAnnotationView.paopaoView = paopaoView;
            
            return newAnnotationView;
            
        }
    }
    return nil;
}
*/



@end
