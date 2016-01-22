//
//  ZHPHelper.m
//  ZP_Base
//
//  Created by zhangpoor on 16/1/14.
//  Copyright © 2016年 zhangpoor. All rights reserved.
//

#import "ZHPHelper.h"

@implementation ZHPHelper



+(BOOL)checkIDCard:(NSString *)idStr
{
    
    
    NSString *regex = @"^(\\d{15})|((\\d{17})(\\d|[xX]))$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    NSString *areaRegex = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSPredicate *areaPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",areaRegex];
    
    NSString *birthDayRegex = @"(((0[13578])|(1[02]))((0[1-9])|([12][0-9])|(3[01])))|(((0[469])|11)((0[1-9])|([12][0-9])|30))|(02((0[1-9])|(1[0-9])|(2[0-8])))";
    NSPredicate *birthDayPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",birthDayRegex];
    
    if(idStr.length == 15)
    {
        if([identityCardPredicate evaluateWithObject:idStr])
        {
            if([areaPredicate evaluateWithObject:[idStr substringWithRange:NSMakeRange(0, 6)]])
            {
                if([birthDayPredicate evaluateWithObject:[idStr substringWithRange:NSMakeRange(8, 4)]])
                {
                    return YES;
                }
                else
                {
                    return NO;
                }
            }
            else
            {
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    else if(idStr.length == 18)
    {
        if([identityCardPredicate evaluateWithObject:idStr])
        {
            if([birthDayPredicate evaluateWithObject:[idStr substringWithRange:NSMakeRange(10, 4)]])
            {
                /*
                 1.将前面的身份证号码17位数分别乘以不同的系数。
                 从第一位到第十七位的系数分别为：7 9 10 5 8 4 2 1 6 3 7 9 10 5 8 4 2
                 2.将这17位数字和系数相乘的结果相加。
                 3.用加出来和除以11，看余数是多少
                 4.余数只可能有0 1 2 3 4 5 6 7 8 9 10这11个数字。
                 其分别对应的最后一位身份证的号码为1 0 X 9 8 7 6 5 4 3 2。
                 */
                NSArray *_kAry = @[@7,@9,@10,@5,@8,
                                   @4,@2,@1,@6,@3,
                                   @7,@9,@10,@5,@8,
                                   @4,@2];
                
                NSArray *_lastStrAry = @[@"1",@"0",@"X",@"9",
                                         @"8",@"7",@"6",@"5",
                                         @"4",@"3",@"2"];
                
                if (idStr && [idStr isKindOfClass:[NSString class]])
                {
                    int totoalNum = 0;
                    int lastNum = 0;
                    
                    for (int i = 0; i < idStr.length - 1; i++)
                    {
                        int iNum = [[idStr substringWithRange:NSMakeRange(i, 1)] intValue];
                        totoalNum += (iNum * [(NSNumber *)_kAry[i] intValue]);
                    }
                    
                    lastNum = totoalNum % 11;
                    
                    NSString *_lStr = _lastStrAry[lastNum];
                    
                    if ([_lStr isEqualToString:[idStr substringWithRange:NSMakeRange(idStr.length - 1, 1)]])
                    {
                        return YES;
                    }
                    else
                    {
                        return NO;
                    }
                }
                else
                {
                    return NO;
                }
            }
            else
            {
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}


@end
