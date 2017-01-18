//
//  ZPAnimationView.m
//  mask_animation
//
//  Created by zhangpoor on 16/10/25.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "ZPAnimationView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ZPAnimationView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self setMask];
    }
    
    return self;
}

- (void)setMask:(CGFloat)d
{//WithUIBezierPath:(UIBezierPath *)bezierPath{
    
    UIBezierPath *_bezierPath = [[UIBezierPath alloc]init];//[UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    
    CGFloat _center = self.bounds.size.width/2.0;
    [_bezierPath moveToPoint:CGPointMake(_center, _center)];
    [_bezierPath addLineToPoint:CGPointMake(_center , 0)];
    [_bezierPath addArcWithCenter:CGPointMake(_center, _center)
                           radius:_center
                       startAngle:-M_PI_2
                         endAngle:-M_PI_2 + (d/360.0)*(2 * M_PI)
                        clockwise:YES];
    [_bezierPath addLineToPoint:CGPointMake(_center, _center)];
    
    /*
    [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50)
                                   radius:50
                               startAngle:0
                                 endAngle:M_PI_2
                                clockwise:YES];
     */
    //蒙版
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [_bezierPath CGPath];
    maskLayer.fillColor = [[UIColor redColor] CGColor];
    //maskLayer.frame = self.frame;
    self.layer.mask = maskLayer;

    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
