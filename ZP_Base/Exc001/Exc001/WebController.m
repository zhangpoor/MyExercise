//
//  WebController.m
//  Exc001
//
//  Created by zhangpoor on 16/3/8.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "WebController.h"
#import "Controller001.h"

@interface WebController ()<UIWebViewDelegate>
{
    UIWebView *_wb;
}
@end

@implementation WebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
    _wb = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    
    _wb.delegate = self;
    
    [self.view addSubview:_wb];
    
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(100, 100, 120, 50);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
     */
    
    
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(100, 100, 120, 50);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn addTarget:self action:@selector(btnAction001) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
}

-(void)btnAction
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    NSURLRequest *_r = [NSURLRequest requestWithURL:
                        [NSURL URLWithString:@"http://wap-stg.pingan.com.cn:8010/c3/huodong/xyt/index.html"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
                        
                            //[NSURL URLWithString:@"http://m.pingan.com/chaoshi/daikuan/20001.shtml"]];
    
    [_wb loadRequest:_r];
}





-(void)btnAction001
{
    Controller001 *_web = [[Controller001 alloc]init];
    _web.title = @"Controller001";
    [self.navigationController pushViewController:_web animated:YES];
    //[self presentViewController:_web animated:YES completion:nil ];
    
}



- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}
- (void)webView:(UIWebView *)webView
didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"description:\n%@",error.description);
    NSLog(@"\r\n\r\n");
    NSLog(@"localizedDescription:\n%@",error.localizedDescription);
    NSLog(@"\r\n\r\n");
    NSLog(@"localizedFailureReason:\n%@",error.localizedFailureReason);
}

@end
