//
//  LoadingView.h
//  Loading 动画（更新版）
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 apple—dp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView


@property (nonatomic, retain) UILabel *signLab;

+ (LoadingView *) creatLoadingView:(CGRect)frame;

+ (LoadingView *) creatMyLoadingView;

- (void)isStopLoading:(BOOL)flag;

@end
