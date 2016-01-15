//
//  AppDelegate.m
//  XiangQi
//
//  Created by zhangpoor on 15/12/31.
//  Copyright © 2015年 zhangpoor. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    /*
    NSString *_str= @"";
    
    
    BOOL _f = [_str boolValue];
    
    
    NSLog(@"");
    */
    id _aaa = [[NSObject alloc]init];
    NSString *_str = _aaa;
    

    
    NSRange _r = NSMakeRange(-1, 0);
    int _count = 0;
    
    do{
        
        _str = [_str substringFromIndex:_r.location + 1];
        _r = [_str rangeOfString:@"."];
        if (_r.length > 0) {
            _count++;
        }
        
    }while(_r.length > 0 &&
           (_r.location + 1) < _str.length );
    
    
    NSLog(@"count:%d",_count);
    
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
