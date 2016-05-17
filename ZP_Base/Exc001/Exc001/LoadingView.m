//
//  LoadingView.m
//  Loading 动画（更新版）
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 apple—dp. All rights reserved.
//

#import "LoadingView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00)>> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


typedef NS_ENUM(NSInteger,LoadingViewStyle){
    LoadingViewStyleOne,
    LoadingViewStyleTwo,
} ;

@interface LoadingView()
{

    CGFloat _oY;                    //起始y位置
    CGFloat _oX;                    //起始x位置
    CGFloat _guideWidth;            //小球的宽度
    CGFloat _dX;                    //小球的间隔
    
    int _guideCount;                //小球的个数
    
    LoadingViewStyle    _ldStyle;
    
    NSMutableArray *_guideList;
}


@property(nonatomic) CGFloat maxY;                  //振幅
@property(nonatomic) int  animationCount;
@property(nonatomic) BOOL isStopAnimation;

@end

@implementation LoadingView



+(LoadingView *)creatLoadingView:(CGRect)frame
{

    LoadingView *loadingView    = [[LoadingView alloc] initWithFrame:frame];
    loadingView->_ldStyle       = LoadingViewStyleOne;
    loadingView.isStopAnimation = NO;
    [loadingView createViews];
    
    [loadingView initUI];
    
    return loadingView;
}

+ (LoadingView *) creatMyLoadingView
{
    
    LoadingView *loadingView    = [[LoadingView alloc] init];
    loadingView->_ldStyle       = LoadingViewStyleTwo;
    loadingView.isStopAnimation = NO;
    [loadingView createViews];
    
    [loadingView initUI];
    
    return loadingView;
}


- (void) createViews
{
    _guideCount         = 6;                        //小球的个数
    
    _guideList = [NSMutableArray array];
    
    for (int i = 0; i < _guideCount; i++)
    {
        LoadingView *guide = [[LoadingView alloc] init];
        
        [self addSubview:guide];
        
        [_guideList addObject:guide];
    }
    
    
    switch (_ldStyle) {
        case LoadingViewStyleTwo:
        {
            self.signLab = [[UILabel alloc] init];
            _signLab.frame = CGRectMake(0, 72, self.frame.size.width, 14);
            _signLab.textAlignment = NSTextAlignmentCenter;
            _signLab.textColor = UIColorFromRGB(0x9b9b9b);
            _signLab.font = [UIFont systemFontOfSize:14];
            _signLab.text = @"正在查询中";
            [self addSubview:_signLab];
        }
            break;
            
        default:
            break;
    }
}




- (void) initUI
{
    switch (_ldStyle) {
        case LoadingViewStyleTwo:
        {
            _oY                 = 10;
            _oX                 = 10;
            _maxY               = 10;
            _guideWidth         = 8;                        //小球的宽度
            _dX                 = 6;                        //小球的间隔
        }
            break;
        case LoadingViewStyleOne:
        default:
        {
            _oY                 = 47;                       //高度
            _oX                 = 36;
            _maxY               = 10;                       //振幅
            _guideWidth         = 8;                        //小球的宽度
            _dX                 = 6;                        //小球的间隔
                    }
            break;
    }
    
    

    
    
    
    
}


- (void)startAnimation
{
    if (_guideList) {
        
        //[self initUI];
        
        
        for (int i = 0; i < _guideList.count; i++)
        {
            LoadingView *guide = _guideList[i];
            guide.backgroundColor = UIColorFromRGB(0xff6600);
            guide.frame= CGRectMake(_oX + ( _dX + _guideWidth ) * i, _oY, _guideWidth, _guideWidth);
            guide.maxY = -_maxY;
            guide.animationCount = 0;
            guide.layer.cornerRadius = _guideWidth / 2.0;
            
            
            [self animationAction:i isFirst:YES];
        }
    }
    
}

-(void)animationAction:(int)index isFirst:(BOOL)iF
{
    LoadingView *guide = _guideList[index];
    
    UIViewAnimationOptions _uao = UIViewAnimationOptionCurveLinear;
    switch (guide.animationCount)
    {
        case 0:
        case 2:
        {
            _uao = UIViewAnimationOptionCurveEaseOut;
        }
            break;
        case 1:
        {
            _uao = UIViewAnimationOptionCurveEaseIn;
        }
            break;
        default:
            break;
    }
    
    CGFloat _animTime       = 0.3;
    CGFloat _unitAnimTime   = _animTime ;
    
    [UIView animateWithDuration:guide.animationCount == 1 ? _animTime * 2 : _animTime
                          delay:iF ? index * _unitAnimTime : 0
                        options:_uao
                     animations:
     ^{
         CGRect _rect = guide.frame;
         _rect.origin.y += guide.maxY;
         guide.frame= _rect;
     }
                     completion:
     ^(BOOL finished) {
         
         if (self.isStopAnimation) {
             return ;
         }
         
         
         guide.animationCount++;
         if (guide.animationCount == 1 )
         {
             guide.maxY = _maxY * 2;
         }
         else if (guide.animationCount == 2)
         {
             guide.maxY = -_maxY;
         }
         else if(guide.animationCount == 3)
         {
             guide.maxY = -_maxY;
             guide.animationCount = 0;
             
             if (index == _guideList.count - 1) {
                 for (int i = 0; i < _guideList.count; i++)
                 {
                     
                     [self animationAction:i isFirst:YES];
                 }
             }
             
             return;
         }
         
         
         [self animationAction:index isFirst:NO];
     }];
    
}


- (void)isStopLoading:(BOOL)flag
{
    self.isStopAnimation = flag;
    
    if (!self.isStopAnimation) {
        [self startAnimation];
    }
    
}


@end
