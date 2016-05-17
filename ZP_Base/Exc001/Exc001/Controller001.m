//
//  Controller001.m
//  Exc001
//
//  Created by zhangpoor on 16/3/16.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "Controller001.h"
#import "LoadingView.h"
#import "Controller002.h"



@interface Controller001 ()

@property(nonatomic,strong)UILabel *lab001;
@property(nonatomic,strong)UILabel *lab002;

@property(nonatomic,strong)UIView *animaView001;

@property(nonatomic,strong)UILabel *lab011;
@property(nonatomic,strong)UILabel *lab012;
@property(nonatomic,strong)UIView *animaView002;


@property(nonatomic,strong)NSTimer  *aTimer;

@property(nonatomic,strong)LoadingView *loadingView;

@end

@implementation Controller001

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI003];
    
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_loadingView isStopLoading:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_loadingView) {
        //[_loadingView removeFromSuperview];
        [_loadingView isStopLoading:YES];
        //_loadingView = nil;
    }
}

-(void)initUI003
{
    _loadingView = [LoadingView  creatMyLoadingView];
    
    _loadingView.frame = CGRectMake(50, 150, 250, 200);
    _loadingView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_loadingView];
    
    
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(100, 400, 120, 50);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
}

-(void)initUI002
{
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(100, 100, 120, 50);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    
    NSString *_word001 = @"aaaaaaaaaaaaaaa";
    NSString *_word002 = @"bbbbbbbbbbbbbbb";
    
    
    self.lab001 = [[UILabel alloc] init];
    self.lab001.frame = CGRectMake(0, 0, 0, 30);
    self.lab001.numberOfLines = 1;
    self.lab001.textColor = [UIColor blackColor];
    self.lab001.text = _word001;
    [self.lab001 sizeToFit];
    
    self.lab002 = [[UILabel alloc] init];
    self.lab002.frame = CGRectMake(0, 0, 0, 30);
    self.lab002.numberOfLines = 1;
    self.lab002.textColor = [UIColor blackColor];
    self.lab002.text = _word002;
    [self.lab002 sizeToFit];
    
    
    [self.view addSubview:self.lab001];
    [self.view addSubview:self.lab002];
}

-(void)initUI
{
    UIButton *_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(100, 100, 120, 50);
    _btn.backgroundColor = [UIColor orangeColor];
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    
    
    self.animaView001 = [[UIView alloc]initWithFrame:CGRectMake(500, 300, 0, 30)];
    self.animaView002 = [[UIView alloc]initWithFrame:CGRectMake(500, 300, 0, 30)];
    
    
    NSString *_word001 = @"aaaaaaaaaaaaaaa";
    NSString *_word002 = @"bbbbbbbbbbbbbbb";
    
    
    self.lab001 = [[UILabel alloc] init];
    self.lab001.frame = CGRectMake(0, 0, 0, 30);
    self.lab001.numberOfLines = 1;
    self.lab001.textColor = [UIColor blackColor];
    self.lab001.text = _word001;
    [self.lab001 sizeToFit];
    
    self.lab002 = [[UILabel alloc] init];
    self.lab002.frame = CGRectMake(0, 0, 0, 30);
    self.lab002.numberOfLines = 1;
    self.lab002.textColor = [UIColor blackColor];
    self.lab002.text = _word002;
    [self.lab002 sizeToFit];
    
    [self.animaView001 addSubview:self.lab001];
    [self.animaView001 addSubview:self.lab002];
    
    self.lab011 = [[UILabel alloc] init];
    self.lab011.frame = self.lab001.frame;
    self.lab011.numberOfLines = 1;
    self.lab011.textColor = [UIColor blackColor];
    self.lab011.text =_word001;
    [self.lab011 sizeToFit];
    
    self.lab012 = [[UILabel alloc] init];
    self.lab012.frame = self.lab001.frame;
    self.lab012.numberOfLines = 1;
    self.lab012.textColor = [UIColor blackColor];
    self.lab012.text = _word002;
    [self.lab012 sizeToFit];
    
    
    
    
    
    [self.animaView002 addSubview:self.lab001];
    [self.animaView002 addSubview:self.lab002];
    
    
    [self.view addSubview:self.animaView001];
    [self.view addSubview:self.animaView002];
    
    
    
    CGFloat _w =
        self.lab001.frame.size.width > self.view.frame.size.width ?
                (self.lab001.frame.size.width + self.lab002.frame.size.width + 10) :
                            ( self.view.frame.size.width + self.lab002.frame.size.width);
    
    
    self.animaView001.frame = CGRectMake(500, 300, _w, 30);
    self.animaView002.frame = self.animaView001.frame;
    
}

-(void)btnAction
{
    /*
    //[self dismissViewControllerAnimated:YES completion:nil];
    UIViewController *_vcF = [self.navigationController.viewControllers firstObject];
    
    UIViewController *_vcl = [self.navigationController.viewControllers lastObject];
    
    UIViewController *_vcT = [self.navigationController topViewController];
    
    NSLog(@"aaaa");
     */
    
    //[self startAnimation001:self.animaView001];
    ///[self startAni];
    [_loadingView isStopLoading:YES];
    
    [self performSelector:@selector(show) withObject:nil afterDelay:1];
}

-(void)show
{
    Controller002 *_vc002 = [[Controller002 alloc]init];
    _vc002.title = @"red";
    _vc002.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:_vc002 animated:YES];
}

- (void)startAni
{
    if (self.aTimer && self.aTimer.isValid) {
        [self.aTimer invalidate];
    }
    
    self.aTimer = [NSTimer timerWithTimeInterval:0.05
                                          target:self
                                        selector:@selector(doTimer:)
                                        userInfo:nil
                                         repeats:YES];
    [self.aTimer fire];
}

- (void)doTimer:(NSTimer *)t
{
    
}

-(void)startAnimation001:(UIView *)tView
{
    CGFloat _sw = self.view.frame.size.width;
    CGFloat _w  = self.animaView001.frame.size.width;
    CGRect _rect = tView.frame;
    CGRect _rect01 = self.lab001.frame;
    CGRect _rect02 = self.lab002.frame;
    
    
    
    
    
    
    /*
    _rect.origin.x = _sw;
    self.lab001.frame = _rect;
    
    
    _rect = self.lab001.frame;
    
    
    
    
    if (_rect.size.width > _sw) {
        _rect02.origin.x = CGRectGetMaxX(_rect);
    }
    else
    {
        _rect02.origin.x = 2 * _sw;
    }
    
    self.lab002.frame = _rect02;
    self.lab002.text = @"abdsfsafdsfsdfsf";
    [self.lab002 sizeToFit];
    _rect02 = self.lab002.frame;
    
    
    
    
    [UIView animateWithDuration:3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:
     ^{
                         _rect.origin.x = _rect.origin.x - _w - _sw;
                         _rect02.origin.x = _rect02.origin.x - _w - _sw;
                         
                         self.lab001.frame = _rect;
                         self.lab002.frame = _rect02;
                     }
                     completion:
     ^(BOOL finished) {
                         [self startAnimation002];
                     }];
    

    
    */
    
}

-(void)startAnimation002
{
    __block CGRect _rect    = self.lab002.frame;
    CGFloat _sw     = self.view.frame.size.width;
    CGFloat _w      = _rect.size.width;
    
    
    if (_rect.size.width > _sw) {
        _rect.origin.x = CGRectGetMaxX(_rect);
    }
    else
    {
        _rect.origin.x = 2 * _sw;
    }
    
    self.lab001.frame = _rect;
    
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:
     ^{
         
         
         self.lab001;
         
         
         self.lab002.frame = _rect;
     }
                     completion:
     ^(BOOL finished) {
         
         
         
         [self startAnimation003];
     }];
}

-(void)startAnimation003
{
    
    
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:
     ^{
         CGRect _rect = self.lab002.frame;
         
         _rect.origin.x = -_rect.size.width;
         
         
         self.lab002.frame = _rect;
         
         
         
         self.lab001;
         
     }
                     completion:
     ^(BOOL finished) {
         
         
         UILabel *_lab = self.lab002;
         self.lab002 = self.lab001;
         self.lab001 = _lab;
         
         
         [self startAnimation003];
     }];
}

@end
