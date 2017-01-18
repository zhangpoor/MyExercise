//
//  ViewController.m
//  funcCoding
//
//  Created by zhangpoor on 16/11/15.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "ViewController.h"


typedef id (^FuncA_callback)(int p1);




@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FuncA_callback fa_001 = ^id(int p1){
      
        //NSString *_str = p1;
        
        //return _str;
        
        return ^NSString *(NSString *p2)
        {
            NSString *_str = [p2 stringByAppendingFormat:@":%d",p1];
            
            return _str;
        };
    };
    
    
    NSString *sss = fa_001(1)(@"abc");
    
    NSLog(@"%@",sss);
    NSLog(@"aaaaa");
}




@end
