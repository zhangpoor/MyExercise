//
//  RSAManager.m
//  Exc001
//
//  Created by zhangpoor on 16/5/6.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "RSAManager.h"

@implementation RSAManager

+(NSData *)getStrDecodebase64:(NSString *)bstr
{
    return base64_decode(bstr);
}


static NSData *base64_decode(NSString *str){
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}



@end
