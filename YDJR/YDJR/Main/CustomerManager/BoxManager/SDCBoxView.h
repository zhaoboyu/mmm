//
//  SDCBoxView.h
//  YDJR
//
//  Created by sundacheng on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  线的类型
 */
typedef NS_ENUM(NSUInteger, LineStyle) {
    /**
     *  上左下
     */
    LineStyleTopLeftBottom,
    /**
     *  左
     */
    LineStyleLeft
};

@interface SDCBoxView : UIView

/**
 *  数据字典
 */
@property (nonatomic, copy) NSDictionary *infoDict;

/**
 *  申请按钮
 */
@property (nonatomic, strong) UIButton *button;

/**
 *  申请回调
 */
@property (nonatomic, copy) void (^applyTyple)(void);

/**
 *  初始化
 *
 *  @param frame     frame
 *  @param lineStyle 线的种类
 *  @param isFirst   是否是第一个按钮
 *
 *  @return view
 */
- (instancetype) initWithFrame:(CGRect)frame andLineStyle:(LineStyle)lineStyle isFirst:(BOOL)isFirst;

@end
