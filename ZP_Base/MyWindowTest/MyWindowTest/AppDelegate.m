//
//  AppDelegate.m
//  MyWindowTest
//
//  Created by zhangpoor on 2017/11/27.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic,strong)UIWindow *maskWindow;

@end

@implementation AppDelegate

#pragma mark- <getter && setter>
- (UIWindow *)maskWindow
{
    if (!_maskWindow) {
        
        _maskWindow = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        _maskWindow.backgroundColor = [UIColor clearColor];
        _maskWindow.windowLevel =
        10000001 + 1984;
        //(UIWindowLevelAlert + 1984);
        
        UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_maskWindow addGestureRecognizer:_tap];
        
    }
    return _maskWindow;
}

- (void)tapAction:(UITapGestureRecognizer *)aTap
{
    self.maskWindow.hidden = YES;
}


#pragma mark- <App Start>
-           (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSLog(@"zp_win_UIWindowLevelNormal:\t%f",UIWindowLevelNormal);
    NSLog(@"zp_win_UIWindowLevelAlert:\t%f",UIWindowLevelAlert);
    NSLog(@"zp_win_UIWindowLevelStatusBar:\t%f",UIWindowLevelStatusBar);
    
    return YES;
}

#pragma mark- <Function>
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
    
    for (UIView *_v in self.maskWindow.subviews) {
        [_v removeFromSuperview];
    }
    self.maskWindow.hidden = YES;
    /*
    [self.maskWindow resignKeyWindow];
    [self.window makeKeyAndVisible];
     */
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    
    //[self.maskWindow makeKeyAndVisible];
    /*
    //截屏
    UIWindow*screenWindow = application.keyWindow;
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *_imgView = [[UIImageView alloc]initWithFrame:self.maskWindow.bounds];
    _imgView.backgroundColor = [UIColor clearColor];
    _imgView.image = viewImage;
    */
    //高斯模糊视图，会将其下的视图给高斯模糊
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *_v = [[UIVisualEffectView alloc]initWithEffect:beffect];
    _v.frame = self.maskWindow.bounds;
    
    //_v.alpha = 0.97;
    
    
    //[self.maskWindow addSubview:_imgView];
    [self.maskWindow addSubview:_v];
    
     
     
    self.maskWindow.hidden = NO;
    

    
    

    
    
    

    for (int i = 0; i < application.windows.count; i++) {
        UIWindow *_win = application.windows[i];
        NSLog(@"zp_win");
        NSLog(@"zp_win\t%f",_win.windowLevel);
        NSLog(@"zp_win\t%@",_win.keyWindow?@"is key":@"not key");
        NSLog(@"zp_win\t%@",_win);
        NSLog(@"zp_win");
    }
     
   /*   keyWindow
    
        The key window receives keyboard and other non-touch related events. Only one window at a time may be the key window.
        keyWindow是指定的用来接收键盘以及非触摸类的消息，而且程序中每一个时刻只能有一个window是keyWindow
    */
}









- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    //self.maskWindow.hidden = NO;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    
    //self.maskWindow.hidden = YES;
}




- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
