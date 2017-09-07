//
//  TipAlertPopView.h
//  CTTX
//
//  Created by 吕利峰 on 16/7/21.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "PopView.h"
@protocol TipAlertPopViewDelegate <NSObject>
@optional
- (void)actionButtonWithIndex:(NSInteger)index;

@end
@interface TipAlertPopView : PopView

@property (nonatomic,copy)NSString *tipTitle;//自定义标题

/**
 *  弹出视图的初始化方法
 *
 *  @param titleArr   弹出视图中cell的标题数组
 *  @param titleColor 弹出视图中cell的标题的颜色
 *
 *  @return 该弹出视图
 */
- (instancetype)initWithTitleArr:(NSMutableArray *)titleArr titleColor:(NSString *)titleColor;
@property (nonatomic,weak)id<TipAlertPopViewDelegate>delegate;
/**
 *  出现
 */
- (void)showPopView;
/**
 *  取消
 */
- (void)hidePopView;

/**
 *  改变cell标题位置
 *
 *  @param frame cell标题位置
 */
- (void)setCellTitleLabelWithframe:(CGRect)frame;

@end
