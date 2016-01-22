//
//  JSPHManager.m
//  JSPatchExc
//
//  Created by zhangpoor on 16/1/14.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "JSPHManager.h"
#import "JPEngine.h"



@implementation JSPHManager


+ (instancetype)sharedInstance {
    
    static JSPHManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient               = [[JSPHManager alloc] init];
        [JPEngine startEngine];
    });
    
    return _sharedClient;
}


- (void)loadJS:(NSString *)path
{
    
    NSString *script = @"";
    if (![[ZHPHelper fomatString:path] isEqualToString:@""]) {
        script = [NSString stringWithContentsOfFile:path
                                           encoding:
                  NSUTF8StringEncoding
                                              error:nil];
    }
    

    [JPEngine evaluateScript:[ZHPHelper fomatString:script]];
}


+(UIView *)createImageViewWithImgName:(NSString *)imgName
{
    UIImageView *_imgView =
        [[UIImageView alloc]initWithImage:[UIImage imageNamed:[ZHPHelper fomatString:imgName]]];
    
    return _imgView;
}

@end
