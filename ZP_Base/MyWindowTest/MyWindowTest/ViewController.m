//
//  ViewController.m
//  MyWindowTest
//
//  Created by zhangpoor on 2017/11/27.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSString *_s = @"abc";
    
    Byte *_bbb = [_s cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSString *_ss = [[NSString alloc] initWithBytes:_bbb length:_s.length encoding:(NSUTF8StringEncoding)];
    
    
    NSLog(@"_ss:%@",_ss);
    
    NSLog(@"aaa");
    
    
    
    
    
    Byte _bList[1];
    _bList[0] = 0x0f;
    NSData *_data = [NSData dataWithBytes:_bList length:1];
    
    Byte *_bL = [_data bytes];
    
    NSString *_str = [NSString stringWithFormat:@"%02x",_bL[0]];
    NSString *_str2 = [NSString stringWithFormat:@"%d",_bL[0]];
    
    
    NSLog(@"data:%x\nstr:%@\nstr2:%@",_bL[0],_str,_str2);
    NSLog(@"aaaa");
    
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIImage *_img = [UIImage imageNamed:@"pic"];
    UIImageView *_bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _bgView.image = _img;
    [self.view addSubview:_bgView];
    
    
    UITextField *_tf = [[UITextField alloc]initWithFrame:CGRectMake(80, 120, 200, 50)];
    _tf.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tf];
    
    
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:_tap];
    
}

- (void)tapAction:(UITapGestureRecognizer *)aTap
{
    [self.view endEditing:YES];
}

@end
