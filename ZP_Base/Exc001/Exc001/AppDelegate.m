//
//  AppDelegate.m
//  Exc001
//
//  Created by zhangpoor on 15/12/23.
//  Copyright © 2015年 zhangpoor. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHP_Headers.h"

@interface AppDelegate ()
{
    NSHashTable *_WHTalbe;
}


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    NSString *_str = @"\"";
    
     [_str UTF8String];
    
    //NSDictionary *_dic = @{};
    
    
    //id _abc = _dic[@"abc"];
    
    //NSLog(@"aaaa");
    
    /*
    NSDictionary *_dic = nil;
    
    
    NSInteger _num = [_dic[@"abc"] integerValue];
    
    
    NSTimeInterval _a1 = [[NSDate date] timeIntervalSince1970];
    
    
    sleep(5);
    NSTimeInterval _a2 = [[NSDate date] timeIntervalSince1970];
    
    
    NSTimeInterval _r = _a2 - _a1;
    */
    //NSLog(@"aaa");
    
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
    
    //NSString *_str = [AppDelegate getChannelBizNo:@"aaaaads"];
    /*
    NSString *_v = [ZHPHelper appVersion];
    NSString *_bv = [ZHPHelper buildVersion];
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    
    _WHTalbe = [NSHashTable weakObjectsHashTable];
    
    
    NSObject *_obj = [[NSObject alloc] init];
    [_WHTalbe addObject:_obj];
    
    _obj = nil;
    
    [_WHTalbe removeObject:_obj];
    
    */
    
    return YES;
}


+(NSString *)getChannelBizNo:(NSString *)clientNo
{
    
    NSMutableString *sb     = [[NSMutableString alloc]initWithString:@""];
    
    
    //String time = String.valueOf(new Date().getTime());
    //String randomStr = String.valueOf(Math.abs(new Random().nextLong()));
    //sb.append(clientNo).append(time).append("0").append(time).append(randomStr);
    
    /* 时间戳 和 随机数 的格式还有长度，自己调整下 */
    long long _timeStamp    =  (long long)([[NSDate date] timeIntervalSince1970] * 1000);
    NSString *time = [NSString stringWithFormat:@"%lld",_timeStamp];
    
    long _randomNumber = mrand48(); //(long)arc4random() ;
    NSString *randomStr = [NSString stringWithFormat:@"%ld",_randomNumber];
    
    [sb appendString:clientNo];
    [sb appendString:time];
    [sb appendString:@"0"];
    [sb appendString:time];
    [sb appendString:randomStr];
    

    if (sb.length > 64) {
        [sb substringToIndex:64];
    }
    
    return sb;
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
