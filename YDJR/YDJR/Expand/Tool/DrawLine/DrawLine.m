//
//  DrawLine.m
//  ync
//
//  Created by sdc on 16/5/25.
//  Copyright © 2016年 ync. All rights reserved.
//

#import "DrawLine.h"

@implementation DrawLine

#pragma mark - 划线
+ (void)addLineWithLineType:(LineType)type andX:(CGFloat)x andY:(CGFloat)y andLength:(CGFloat)length andView:(UIView *)view
{
    UIView *lineView;
    CGFloat pixelAdjustOffset = 0;
    if (((int)(x * [UIScreen mainScreen].scale * 2) + 1) % 2 == 0 ||
        ((int)(y * [UIScreen mainScreen].scale * 2) + 1) % 2 == 0 ) {
        pixelAdjustOffset = OFFSET;
    } else {
        pixelAdjustOffset = 0;
    }
    if (type == LineTypeHorizontal) {
        lineView = [[UIView alloc]initWithFrame:CGRectMake(x, y - pixelAdjustOffset, length, LINE_WIDTH)];
        
        lineView.backgroundColor = ACOLOR_LINE;
    }
    if (type == LineTypeVertical) {
        lineView = [[UIView alloc]initWithFrame:CGRectMake(x - pixelAdjustOffset, y, LINE_WIDTH, length)];
        
        lineView.backgroundColor = ACOLOR_LINE;
    }
    
    [view addSubview:lineView];
}
+ (void)addLineWithLineType:(LineType)type andLength:(CGFloat)length onView:(UIView *)view
{
    UIView *lineView;
    CGFloat pixelAdjustOffset = 0;
    CGFloat y = view.frame.size.height;
    
    
    if (type == LineTypeTop) {
        if (((int)(y * [UIScreen mainScreen].scale * 2) + 1) % 2 == 0) {
            pixelAdjustOffset = OFFSET;
        } else {
            pixelAdjustOffset = 0;
        }
        lineView = [[UIView alloc]initWithFrame:CGRectMake(0, pixelAdjustOffset, length, LINE_WIDTH)];
        
        lineView.backgroundColor = ACOLOR_LINE;
    }
    if (type == LineTypeBottom) {
        if (((int)(y * [UIScreen mainScreen].scale * 2) + 1) % 2 == 0) {
            pixelAdjustOffset = OFFSET;
        } else {
            pixelAdjustOffset = 0;
        }
        lineView = [[UIView alloc]initWithFrame:CGRectMake(0, y - pixelAdjustOffset, length, LINE_WIDTH)];
        
        lineView.backgroundColor = ACOLOR_LINE;
    }
    
    [view addSubview:lineView];
}



@end
