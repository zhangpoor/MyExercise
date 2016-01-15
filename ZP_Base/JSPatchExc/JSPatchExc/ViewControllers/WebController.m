//
//  WebController.m
//  JSPatchExc
//
//  Created by zhangpoor on 16/1/15.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "WebController.h"
#import <WebKit/WebKit.h>
#import <ZHP_Headers.h>

@interface WebController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)WKWebView *webView02;


@end

@implementation WebController


+ (WebController *)createWebVC:(NSString *)url
{
    WebController *_webVC = [[WebController alloc]init];
    
    _webVC.webView02 = [[WKWebView alloc]initWithFrame:kScreenBounds];

    [_webVC.view addSubview:_webVC.webView02];
    
    
    NSURLRequest *_req =
    [NSURLRequest requestWithURL:
     [NSURL URLWithString:[ZHPHelper fomatString:url]]];
    if (_req) {
        [_webVC.webView02 loadRequest:_req];
    }
     
    /*
    _webVC.webView          = [[UIWebView  alloc]initWithFrame:kScreenBounds];
    _webVC.webView.delegate = _webVC;
    [_webVC.view addSubview:_webVC.webView];
    
    
    NSURLRequest *_req =
            [NSURLRequest requestWithURL:
                    [NSURL URLWithString:[ZHPHelper fomatString:url]]];
    if (_req) {
        [_webVC.webView loadRequest:_req];
    }
    */
    return _webVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"web.url:%@",webView.request.URL);
}

@end
