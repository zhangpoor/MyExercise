//
//  ViewController.m
//  Exc001
//
//  Created by zhangpoor on 15/12/23.
//  Copyright © 2015年 zhangpoor. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "WebController.h"
#import "Controller001.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "LoadingView.h"

#import "RSAManager.h"
#import "ControllerE.h"

/**
 *  业务操作回调函数
 *
 *  @param isSucessed 操作是否成功
 *  @param oParam     操作的输出参数
 *  @param eMsg       操作错误信息    （当操作成功时为nil）
 */
typedef void (^BusinessOperationCallback)(BOOL isSucessed,id outParam,NSString *eMsg);


@interface ViewController ()<UIWebViewDelegate>
{
    ZHPWebView *_webView;
    UILabel *_lab;
    
    UIView *_v;
    
    LoadingView *_loadingView;
    
    UITextField *_tf;
    
    UIWebView *_web;
}



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Main";
    //NSArray *_ary;
    //NSDictionary *_dic;
    //[_ary indexOfObject:<#(nonnull id)#>]
    //[_dic ke];
    
    
    //[self doSomeThing0E5];
    
    [self do009];
}

- (void)doSomeThing001
{
    //id _str = @"310102198411111651";
    
    //BOOL _flag = [ZHPHelper checkIDCard:_str];
    
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
}

- (void)doSomeThing002
{
    @try {
        
        UILabel *_lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, kScreenSize.width - 40, 60)];
        NSString *_str      = @"1234200000023.1237868";
        NSString *_str02    = (NSString *)[[NSObject alloc]init];
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
}

- (void)doSomeThing003
{
    UIView *_v001 = [[UIView alloc]init];
    _v001.backgroundColor = [UIColor redColor];
    [self.view addSubview:_v001];
    
    [_v001 mas_makeConstraints:
     ^(MASConstraintMaker *make)
    {
        make.center.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo(@200);
        
    }];
    
    
}

- (void)doSomeThing004
{
    NSString *_filePath = [[NSBundle mainBundle] pathForResource:@"IMG_0004" ofType:@"JPG" inDirectory:@"abc"];
    
    
    UIImage *_img = [UIImage imageWithContentsOfFile:_filePath];
    
    NSString *_sandPath = NSHomeDirectory();
    
    NSLog(@"aaaa");
    /*
    NSString *sandboxPath = NSHomeDirectory();
    // Once you have the full sandbox path, you can create a path from it，但是不能在sandbox的本文件层上写文件也不能创建目录，而应该是此基础上创建一个新的可写的目录，例如Documents,Library或者temp。
    NSString *documentPath = [sandboxPath
                              stringByAppendingPathComponent:@"Documents"];//将Documents添加到sandbox路径上，具体原因前面分析了！
    
    
    
    
    NSString *FileName=[documentDirectory stringByAppendingPathComponent:fileName];//fileName就是保存文件的文件名
    
    
    [data writeToFile:FileName atomically:YES];//将NSData类型对象data写入文件，文件名为FileName
     */
}

- (void)doSomeThing005
{
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(100, 100, 120, 50);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    UIButton *_btn02 = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn02.frame = CGRectMake(100, 300, 120, 50);
    _btn02.backgroundColor = [UIColor orangeColor];
    [_btn02 addTarget:self action:@selector(btnAction02) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn02];
    
    
    UIView *_line = [[UIView alloc]initWithFrame:CGRectMake(10, 165, kScreenSize.width, 1)];
    _line.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_line];
    
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(30, 160, 350, 26)];
    _lab.backgroundColor = [UIColor orangeColor];
    _lab.text = @"  中文方式看风景啊鳥失联飞机撒 ";
    _lab.layer.anchorPoint = CGPointMake(0, 0);
    _lab.frame = CGRectMake(30, 160, 350, 26);
    [self.view addSubview:_lab];
    
    
    
}

int iii = 0;
-(void)btnAction
{
    /*
    CGRect _rect = _v.frame;
    _rect.size.height   += 10;
    _rect.size.width    += 10;
    
    _v.frame = _rect;
    
    
    if (iii != 0) {
        return;
    }
    iii++;
    [self anima:YES];
    */
    
    /*
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    switch (author) {
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:
        {
            NSLog(@"没有授权");
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
        
        }
            break;
        case kCLAuthorizationStatusAuthorized:
        {
            
        }
            break;
        default:
            break;
    }

    
    typedef enum {
        kCLAuthorizationStatusNotDetermined = 0, // 用户尚未做出选择这个应用程序的问候
        kCLAuthorizationStatusRestricted,        // 此应用程序没有被授权访问的照片数据。可能是家长控制权限
        kCLAuthorizationStatusDenied,            // 用户已经明确否认了这一照片数据的应用程序访问
        kCLAuthorizationStatusAuthorized         // 用户已经授权应用访问照片数据} CLAuthorizationStatus;
    }
    */
    /*
    Controller001 *_web = [[Controller001 alloc]init];
    _web.title = @"Controller001";
    [self.navigationController pushViewController:_web animated:YES];
    
    
    WebController *_web = [[WebController alloc]init];
    _web.title = @"Web";
    [self.navigationController pushViewController:_web animated:YES];
    //[self presentViewController:_web animated:YES completion:nil ];
    
     */
}

-(void)btnAction02
{
    NSString *_str = _lab.text;
    
    _lab.text = [_str stringByAppendingString:@"a"];
}

-(void)anima:(BOOL)flag
{
    __block BOOL _flag = flag;
    [UIView animateWithDuration:3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         if (_flag) {
                             

                             _lab.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(50, 50), 0.5f, 0.5f);

                         }
                         else
                         {
                             _lab.transform = CGAffineTransformScale(CGAffineTransformMakeTranslation(0, 0), 1.0f, 1.0f);
                         }
                                              }
                     completion:^(BOOL finished) {
                         [self anima:!_flag];
                     }];
}



- (void)doSomeThing006
{
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(100, 100, 120, 50);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    _v = [[UIView alloc]initWithFrame: CGRectMake(100, 300, 120, 50)];
    _v.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_v];
    

    [_v addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"aaaaa");
}


-(void)doSomeThing007
{
   
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(50, 150, 120, 50);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn addTarget:self action:@selector(btnAction007) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    _tf = [[UITextField alloc]initWithFrame:CGRectMake(50, 250, 200, 50)];
    _tf.backgroundColor = [UIColor whiteColor];
    _tf.textColor = [UIColor blackColor];
    _tf.text = @"123";
    [self.view addSubview:_tf];
}

-(void)btnAction007
{
    NSString *_rStr = @"((^[1-9]{1}[0-9]*)|(^[0]{1}))(([.]{1}[0-9]{1,2}$)|)";
    NSPredicate *predicatePass = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", _rStr];
    
    
    BOOL isMatch = [predicatePass evaluateWithObject:_tf.text];
    NSLog(@"%@",isMatch?@"y":@"n");
    /*
    Controller001 *_c001 = [[Controller001 alloc]init];
    
    [self.navigationController pushViewController:_c001 animated:YES];
    
    
    if (_loadingView) {
        [_loadingView removeFromSuperview];
        _loadingView = nil;
    }
    */
}


-(CGFloat)dosomething008
{
    UILabel *_lab01 = [[UILabel alloc]init];
    
    _lab01.frame = CGRectMake(100, 100, 300, 9999999);
    
    
    _lab01.font = [UIFont systemFontOfSize:16];
    
    _lab01.backgroundColor = [UIColor yellowColor];
    
    _lab01.numberOfLines = 0;
    
    _lab01.text = @"aaaadfdsfsdfdsfdsfaaaadfdsfsdfdsfdsfaaaadfdsfsdfdsfdsfaaaadfdsfsdfdsfdsfaaaadfdsfsdfdsfdsfaaaadfdsfsdfdsfdsf";
    
    
    [_lab01 sizeToFit];
    
    
    [self.view addSubview:_lab01];
    
    return _lab01.frame.size.height;
    
}


- (void)doSomeThing0E5
{
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(100, 100, 120, 50);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn addTarget:self action:@selector(btnActionE) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

- (void)btnActionE
{
    
    ControllerE *_c = [[ControllerE alloc]init];
    _c.title = @"mC";
    
    UINavigationController *_nav = [[UINavigationController alloc]initWithRootViewController:_c];
    [self presentViewController:_nav animated:YES completion:nil];
}


- (void)do009
{
    _web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_web];
    
    _web.delegate = self;
    
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com.cn"]]];
    
    
    
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(100, 100, 120, 50);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn addTarget:self action:@selector(btnActionA) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}
- (void)btnActionA
{
    
    NSMutableString *js = [NSMutableString stringWithString:@""];
    
    [js appendString:@"abc++;"];
    [js appendString:@"alert(abc);"];
    
    [_web stringByEvaluatingJavaScriptFromString:js];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSMutableString *js = [NSMutableString stringWithString:@""];
    
    [js appendString:@"var abc = 1;"];
    [js appendString:@"alert(abc);"];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
}
@end
