//
//  My001TableCell.m
//  BaiduExs
//
//  Created by zhangpoor on 17/1/22.
//  Copyright © 2017年 zhangpoor. All rights reserved.
//

#import "My001TableCell.h"
#import <Masonry/Masonry.h>

@implementation My001TableCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    self.leftLab = [[UILabel alloc]init];
    _leftLab.text                = @"暂无信息";
    _leftLab.font                = [UIFont systemFontOfSize:12];
    _leftLab.numberOfLines       = 2;
    _leftLab.textAlignment       = NSTextAlignmentLeft;
    _leftLab.backgroundColor     = [UIColor orangeColor];
    _leftLab.textColor           = [UIColor whiteColor];

    [self.contentView addSubview:_leftLab];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(90);
    }];
    
    
    self.rightLab = [[UILabel alloc]init];
    _rightLab.text                = @"暂无信息";
    _rightLab.font                = [UIFont systemFontOfSize:12];
    _rightLab.numberOfLines       = 2;
    _rightLab.textAlignment       = NSTextAlignmentLeft;
    _rightLab.backgroundColor     = [UIColor greenColor];
    _rightLab.textColor           = [UIColor whiteColor];
    
  
    [self.contentView addSubview:_rightLab];
    
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.left.mas_equalTo(self.leftLab.mas_right).offset(5);
        make.top.equalTo(self.leftLab);
        make.bottom.equalTo(self.leftLab);
        make.right.equalTo(self.contentView);
    }];
}

/*
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
*/
@end
