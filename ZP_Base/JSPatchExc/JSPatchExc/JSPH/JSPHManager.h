//
//  JSPHManager.h
//  JSPatchExc
//
//  Created by zhangpoor on 16/1/14.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JSPHManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  加载js
 *
 *  @param path js文件全路径，当传入nil时候，则可以停止动态改代码
 */
- (void)loadJS:(NSString *)path;


#pragma mark - <支持函数>
+(UIView *)createImageViewWithImgName:(NSString *)imgName;

@end
