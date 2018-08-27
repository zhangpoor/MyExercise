//
//  ViewController.m
//  AnimationTest
//
//  Created by zhangpoor on 2018/8/8.
//  Copyright © 2018年 zhangpoor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGFloat _oy;
    CGFloat _ox;
    CGFloat _sw;
    CGFloat _sh;
    CGFloat _dx;
    CGFloat _minHS;
    
    CGFloat _sinCY;
    CGFloat _sinDY;
    CGFloat _sinCurrentY;
    CGFloat _sinAnimationSpeed;
    BOOL _sinAnimationFlag;
    
    int _barCount;
    int _cycle;
    long _animationCount;
    double _dD;
}

@property (nonatomic,strong)NSMutableArray *vList;
@property (nonatomic,strong)NSMutableArray *vList002;
@property (nonatomic,strong)NSTimer *t;
@property (nonatomic,strong)CAShapeLayer *sLyer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initParam];
    [self initUI];
    

    [self views002Animation1];
    self.sLyer = [CAShapeLayer new];
    self.sLyer.fillColor = [UIColor orangeColor].CGColor;
    self.sLyer.strokeColor = [UIColor orangeColor].CGColor;
    [self.view.layer addSublayer:self.sLyer];

}



- (void)initParam
{
    _oy = 150;
    _ox = 30;
    _sw = 6;
    _sh = 120;
    _dx = _sw + 4;
    _minHS = 0.1;
    _cycle =  6;
    _barCount = 27;
    _animationCount = 0;
    _dD = M_PI / _cycle;
    
    _sinCY = 610;
    _sinCurrentY = _sinCY;
    _sinDY = 60;
    _sinAnimationFlag = true;
    _sinAnimationSpeed = 15;
    
    self.vList = [NSMutableArray array];
    self.vList002 = [NSMutableArray array];
    
    //__weak typeof(&*self)_weakself = self;
    self.t = [NSTimer scheduledTimerWithTimeInterval:0.02
                                              target:self
                                            selector:@selector(timerAction:)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)initUI
{
    for (int i = 0; i < _barCount; i++) {
        UIView *_v = [UIView new];
        _v.backgroundColor = [UIColor orangeColor];
        _v.frame = CGRectMake(_ox + i * _dx, _oy, _sw, _sh);
        _v.layer.cornerRadius = _sw / 2;
        [self.vList addObject:_v];
        [self.view addSubview:_v];
        
        
        UIView *_v1 = [UIView new];
        _v1.backgroundColor = [UIColor greenColor];
        _v1.frame = CGRectMake(_ox + i * _dx, _oy * 1.2 + _sh , _sw, _sh);
        _v1.layer.cornerRadius = _sw / 2;
        [self.vList002 addObject:_v1];
        [self.view addSubview:_v1];
    }
}


- (void)timerAction:(NSTimer *)aTimer
{
    [self viewsAnimation];
    [self sinAnimation];
}


- (void)viewsAnimation
{
    _animationCount++;
    _animationCount = _animationCount % _cycle;
    for (int i = 0; i < _vList.count; i++) {
        UIView *_v = _vList[i];
        int _j = i % _cycle;
        int _r = (_j + _animationCount) % _cycle;
        
        double _s = fabs(cos(_r * _dD)) * 0.4 + 0.3 ;
        CGRect _f = _v.frame;
        _f.origin.y = _oy - 0.5 *_sh * _s;
        _f.size.height = _sh * _s ;
        _v.frame = _f;
        
    }
}

- (void)views002Animation1
{
    __weak typeof(&*self)_weakself = self;
    
    int _midleId = (_barCount - 1) /2;
    CGFloat _mHS = _minHS;
    
    for (int i = 0; i < self.vList002.count; i++) {
        UIView *_v = self.vList002[i];
        [UIView animateWithDuration:0.5
                              delay:(0.5 /_barCount)   * ( abs(i - _midleId)  )
             usingSpringWithDamping:0.9    //弹性小  0～1
              initialSpringVelocity:0      //最光滑
                            options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState
                         animations:
         ^{
             
             
             CGRect _f = _v.frame;
             _f.origin.y += _f.size.height * (1 - _mHS)/2;
             _f.size.height *= _mHS;
             _v.frame = _f;
             
         
         
         }
                         completion:
         ^(BOOL finished) {
             [_weakself views002Animation2:i];
         }];
    }
    
}

- (void)views002Animation2:(int)index
{
    __weak typeof(&*self)_weakself = self;
    CGFloat _mHS = _minHS;
        UIView *_v = self.vList002[index];
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.9    //弹性小  0～1
              initialSpringVelocity:0      //最光滑
                            options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState
                         animations:
         ^{
             
             
             CGRect _f = _v.frame;
             _f.origin.y = _oy * 1.2 + _sh;
             _f.size.height /= _mHS;
             _v.frame = _f;
             
             
             
         }
                         completion:
         ^(BOOL finished) {
             [UIView animateWithDuration:0.5
                                   delay:0
                  usingSpringWithDamping:0.9    //弹性小  0～1
                   initialSpringVelocity:0      //最光滑
                                 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionBeginFromCurrentState
                              animations:
              ^{
                  
                  
                  CGRect _f = _v.frame;
                  _f.origin.y += _f.size.height * (1 - _mHS)/2;
                  _f.size.height *= _mHS;
                  _v.frame = _f;
                  
                  
                  
              }
                              completion:
              ^(BOOL finished) {
                  [_weakself views002Animation2:index];
              }];
         }];

    
}




- (void)sinAnimation
{
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    if (_sinAnimationFlag) {
        _sinCurrentY -= _sinAnimationSpeed;
    }
    else{
        _sinCurrentY += _sinAnimationSpeed;
    }
    CGFloat _dy =  _sinCurrentY - _sinCY;
    if (fabs( _sinCurrentY - _sinCY ) > _sinCY - _sinDY)  {
        _sinAnimationFlag = !_sinAnimationFlag;
    }
    

    
    [path moveToPoint:CGPointMake(10, _sinCY)];
    //[path addQuadCurveToPoint:CGPointMake(270, _sinCY) controlPoint:CGPointMake(190, _sinCurrentY)];
    [path addCurveToPoint:CGPointMake(370, _sinCY)
            controlPoint1:CGPointMake(130, _sinCY - _dy)
            controlPoint2:CGPointMake(250, _sinCY + _dy)];
    [path moveToPoint:CGPointMake(10, _sinCY)];
    [path addCurveToPoint:CGPointMake(370, _sinCY)
            controlPoint1:CGPointMake(130, _sinCY + _dy)
            controlPoint2:CGPointMake(250, _sinCY - _dy)];
    /*
     [path addCurveToPoint:CGPointMake(370, 310)
     controlPoint1:CGPointMake(130, 110)
     controlPoint2:CGPointMake(250, 110)];
     */
    [path stroke];
    
    self.sLyer.path = path.CGPath;
    
}
@end
