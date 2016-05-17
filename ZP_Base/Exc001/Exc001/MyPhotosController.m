//
//  MyPhotosController.m
//  Exc001
//
//  Created by zhangpoor on 16/3/31.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "MyPhotosController.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface MyPhotosController ()
{
    ALAssetsLibrary     *_assetsLibrary;
    NSDictionary      *_imgDic;
}
@end

@implementation MyPhotosController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initParam
{
    _imgDic = [NSMutableDictionary dictionary];
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                  usingBlock:
     ^(ALAssetsGroup *group, BOOL *stop) {
        if (group && [group numberOfAssets] > 0) {
            
            NSLog(@"");
            
            dispatch_async(dispatch_get_main_queue(), ^{

                
                /*
                [self.groupArray addObject:group];
                if ([group valueForProperty:ALAssetsGroupPropertyName] != nil)
                {
                    [_groupName addObject:[group valueForProperty:ALAssetsGroupPropertyName]];
                }
                [_groupCount addObject:];
                
                UIImage *coverImage = [UIImage imageWithCGImage:[group posterImage]];
                
                NSString *_
                
                if(coverImage)
                {
                    [_imgDic setValue:coverImage forKey:[NSString stringWithFormat:@"%ld",(long)[group numberOfAssets]]];
                }
                */
            });
        }
    }
                                failureBlock:
     ^(NSError *error) {
        NSLog(@"Group not found!\n");
    }];
    
}



@end
