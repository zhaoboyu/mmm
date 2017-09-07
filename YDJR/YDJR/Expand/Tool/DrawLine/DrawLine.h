//
//  DrawLine.h
//  ync
//
//  Created by sdc on 16/5/25.
//  Copyright © 2016年 ync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define OFFSET        ((1 / [UIScreen mainScreen].scale) / 2)    //线坐标偏移量
#define LINE_WIDTH    (1 / [UIScreen mainScreen].scale)    //线的宽度

/**线的颜色*/
#define ACOLOR_LINE [UIColor colorWithRed:0.783922 green:0.780392 blue:0.8 alpha:1]

/**
 *  画线的种类
 */
typedef NS_ENUM(NSInteger, LineType) {
    /**
     *  水平线
     */
    LineTypeHorizontal,
    /**
     *  垂直线
     */
    LineTypeVertical,
    
    /**
     *  顶端线
     */
    LineTypeTop,
    /**
     *  底端线
     */
    LineTypeBottom
};


@interface DrawLine : NSObject

/**
 *  画横线和竖线
 *
 *  @param type   线的种类，横线和竖线
 *  @param x      横坐标
 *  @param y      纵坐标
 *  @param length 线的长度
 *  @param view   父视图
 */
+ (void)addLineWithLineType:(LineType)type andX:(CGFloat)x andY:(CGFloat)y andLength:(CGFloat)length andView:(UIView *)view;

/**
 *  画水平的顶端和底端线
 *
 *  @param type   线的种类，顶端水平线和底端水平线
 *  @param length 长度
 *  @param view   父视图
 */
+ (void)addLineWithLineType:(LineType)type andLength:(CGFloat)length onView:(UIView *)view;

@end
