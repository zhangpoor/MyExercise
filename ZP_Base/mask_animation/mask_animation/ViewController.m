//
//  ViewController.m
//  mask_animation
//
//  Created by zhangpoor on 16/10/25.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "ViewController.h"
#import "ZPAnimationView.h"

@interface ViewController ()
{
    ZPAnimationView *_zpV;
    CGFloat _d ;
    NSTimer *_timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect _rect = CGRectMake(100, 100, 100, 100);
    
    UIView *_v = [[UIView alloc]initWithFrame:_rect];
    _v.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_v];
    
    
    _zpV = [[ZPAnimationView alloc]initWithFrame:_rect];
    _zpV.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_zpV];
    
    _d = 0;
    
    _timer = [NSTimer timerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(doAction:)
                                   userInfo:nil
                                    repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    [_timer fire];
    
    
    
}


- (void)doAction:(NSTimer *)t;
{
    NSLog(@"doAction:%f",_d);
    if (_d > 360) {
        [t invalidate];
        _timer = nil;
        return;
    }

    
    [_zpV setMask:_d++];
    [_zpV setNeedsDisplay];
}


@end
