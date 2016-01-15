//
//  ViewController.m
//  XiangQi
//
//  Created by zhangpoor on 15/12/31.
//  Copyright © 2015年 zhangpoor. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"

@implementation ViewController
{
    int _flag ;
    MyView *_backgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    NSLog(@"%@",[self checkIDCard:@"310102198411111651"]?@"Y":@"N");
    
    //[self initParam];
    //[self initUI];
}


-(BOOL)checkIDCard:(NSString *)idStr
{
    BOOL _result = NO;
    
    /*
    1.将前面的身份证号码17位数分别乘以不同的系数。
        从第一位到第十七位的系数分别为：7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
    2.将这17位数字和系数相乘的结果相加。
    3.用加出来和除以11，看余数是多少
    4.余数只可能有0 1 2 3 4 5 6 7 8 9 10这11个数字。
        其分别对应的最后一位身份证的号码为1 0 X 9 8 7 6 5 4 3 2。
    */
    
    NSArray *_kAry = @[@7,@9,@10,@5,@8,
                       @4,@2,@1,@6,@3,
                       @7,@9,@10,@5,@8,
                       @4,@2];
    NSArray *_lastStrAry = @[@"1",@"0",@"X",@"9",
                             @"8",@"7",@"6",@"5",
                             @"4",@"3",@"2"];
    
    if (idStr &&
        [idStr isKindOfClass:[NSString class]] &&
        idStr.length == 18)
    {
        int totoalNum = 0;
        int lastNum = 0;
        
        for (int i = 0; i < idStr.length - 1; i++)
        {
            int iNum = [[idStr substringWithRange:NSMakeRange(i, 1)] intValue];
            
            totoalNum += (iNum * [(NSNumber *)_kAry[i] intValue]);
            
        }
        
        lastNum = totoalNum % 11;
        

        NSString *_lStr = _lastStrAry[lastNum];
        
        if ([_lStr isEqualToString:[idStr substringWithRange:NSMakeRange(idStr.length - 1, 1)]])
        {
            _result = YES;
        }
        

        
        
    }
    
    return _result;
}

- (void)initParam
{
    _flag = 1;
}

- (void)initUI
{
    CGRect _rect = {10,10,100,100};
    _backgroundView = [[MyView alloc]initWithFrame:NSRectFromCGRect(_rect)];
    [_backgroundView setBackgroundColor:[NSColor orangeColor]];
    [self.view addSubview:_backgroundView];

    CGRect _rect02 = {50,self.view.bounds.size.height - 60,120,50};
    NSButton *_btn = [[NSButton alloc]initWithFrame:_rect02];
    _btn.target = self;
    _btn.action = @selector(btnAction:);
    [_btn setTitle:@"点 我"];
    
    [self.view addSubview:_btn];
}

-(void)btnAction:(NSButton *)btn
{
    if (_flag == 0) {
        [_backgroundView setBackgroundColor:[NSColor orangeColor]];
    }
    else
    {
        [_backgroundView setBackgroundColor:[NSColor greenColor]];
    }
    _flag = 1 - _flag;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
