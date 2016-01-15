//
//  MyView.m
//  XiangQi
//
//  Created by zhangpoor on 15/12/31.
//  Copyright © 2015年 zhangpoor. All rights reserved.
//

#import "MyView.h"

@implementation MyView
{
    NSColor *_bgColor;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    if (_bgColor) {
        [_bgColor set];
        NSRectFill(dirtyRect);
    }
    

}


-(void)setBackgroundColor:(NSColor *)col
{
    if (col) {
        _bgColor = [col copy];
    }
    
    
    [self setNeedsDisplay:YES];
}

@end
