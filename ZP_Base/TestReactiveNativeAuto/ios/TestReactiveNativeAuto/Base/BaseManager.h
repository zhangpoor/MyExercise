//
//  BaseManager.h
//  TestReactiveNativeAuto
//
//  Created by zhangpoor on 16/7/21.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  业务操作回调函数
 *
 *  @param isSucessed 操作是否成功
 *  @param oParam     操作的输出参数
 *  @param eMsg       操作错误信息    （当操作成功时为nil）
 */
typedef void (^BusinessOperationCallback)(BOOL isSucessed,id outParam,NSString *eMsg);


@interface BaseManager : NSObject

@end
