//
//  ViewController.m
//  Exc001
//
//  Created by zhangpoor on 15/12/23.
//  Copyright © 2015年 zhangpoor. All rights reserved.
//

#import "ViewController.h"




@interface ViewController ()
{
    ZHPWebView *_webView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    @try {
        
        UILabel *_lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, kScreenSize.width - 40, 60)];
        NSString *_str      = @"1234200000023.1237868";
        NSString *_str02    = [[NSObject alloc]init];
        [self.view addSubview:_lab];
        /*
         CGFloat _f = [_str floatValue];
         _f += 34;
         _lab.text = [NSString stringWithFormat:@"%.2f",_f];
         */
        
        
        NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:_str];
        NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:_str02];
        
        NSDecimalNumber *nT =[n1 decimalNumberByAdding:n2];
        
        NSLog(@"nT:%@",[nT stringValue]);
    }
    @catch (NSException *exception) {
        NSLog(@"bbbbb");
    }
    @finally {
        
    }
    
    NSLog(@"aaaa");
    /*
    id _str = @"310102198411111651";
    
    BOOL _flag = [ZHPHelper checkIDCard:_str];
    
    NSLog(@"aaaaa");
    
    _webView = [[ZHPWebView alloc]initWithFrame:self.view.bounds];
    NSURLRequest *_req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [_webView loadRequest:_req];
    [self.view addSubview:_webView];
    
    
    NSArray *_ary = @[@"1",@"2",@"3",@"4",@"5",
                      @"21",@"22",@"23",@"24",@"25",
                      @"31",@"32",@"33",@"34",@"35",
                      @"41",@"42",@"43",@"44",@"45"];
    
    
    
    [_ary enumerateObjectsUsingBlock:
     ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         NSLog(@"id:%d",(int)idx);
         NSLog(@"obj:%@",obj);
         sleep(0.05);
         
         
         if (*stop) {
             NSLog(@"stop");
         }
     }];
    
    NSLog(@"aaaaaaa");
    */
}



@end
