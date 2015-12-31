//
//  ZHPWebView.m
//  ZP_Base
//
//  Created by zhangpoor on 15/12/29.
//  Copyright © 2015年 zhangpoor. All rights reserved.
//

#import "ZHPWebView.h"

@implementation ZHPWebView

#pragma mark - 初始化
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    
    return self;
}


#pragma mark - webview回调
- (BOOL)            webView:(UIWebView *)webView
 shouldStartLoadWithRequest:(NSURLRequest *)request
             navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"\r\nshouldStartLoadWithRequest:\r\n");
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"\r\nwebViewDidStartLoad:\r\n");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"\r\nwebViewDidFinishLoad:\r\n");
}
- (void)webView:(UIWebView *)webView
didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"\r\ndidFailLoadWithError:\r\n%@\r\n",error.description);
}

@end
