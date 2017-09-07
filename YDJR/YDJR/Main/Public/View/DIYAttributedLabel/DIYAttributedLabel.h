//
//  DIYAttributedLabel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/14.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DIYAttributedLabelDelegate <NSObject>

@optional
- (void)clickAttributedLabel;

@end

@interface DIYAttributedLabel : UILabel
@property (nonatomic,weak)id<DIYAttributedLabelDelegate>delegate;

/**
 设置显示文本
 
 @param text 标题
 @param index 颜色分割索引
 @param firstColor 标题颜色
 @param secondColor 功能标题颜色
 */
- (void)setText:(NSString *)text index:(NSUInteger)index firstColor:(NSString *)firstColor secondColor:(NSString *)secondColor;

@end
