//
//  AppDelegate.m
//  Exc001
//
//  Created by zhangpoor on 15/12/23.
//  Copyright © 2015年 zhangpoor. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
   
   
    /*
    long double _lf = 98765432167111222.23234324123;
    
    NSLog(@"df:%.9Lf",_lf);
    NSLog(@"f:%.9f",_lf);
    */
    /*
    NSMutableArray *_ary = [NSMutableArray array];
    
    [_ary insertObject:@"aaa" atIndex:2];
    
    NSLog(@"aaa");
    
    NSString *_str = @"aaa";
    
    
    BOOL _flag = [_str hasPrefix:@"abc"];
    
    NSLog(@"aaaaa");
    
    
    NSArray *_ary = @[];
    
    
    id _obj = _ary[0];
    
    
    NSMutableDictionary *_dic = [NSMutableDictionary dictionary];
    
    [_dic setObject:@"abc" forKey:@"abc"];
    _dic[@"abc"] = @"aaa";
    
    _dic[@"abc"] = nil;
    _dic[nil] = nil;
     */
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
