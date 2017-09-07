//
//  LLFPersonCenterPopView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/1/4.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "PopView.h"
@protocol LLFPersonCenterPopViewDelegate <NSObject>

- (void)logout;
- (void)uploadMessage;
@end
@interface LLFPersonCenterPopView : PopView
@property (nonatomic,weak)id<LLFPersonCenterPopViewDelegate>delegate;
/**
 消息数量
 */
@property (nonatomic,copy)NSString *messageCount;

/**
 消息数组
 */
@property (nonatomic,strong)NSArray *messageArr;

/**
 显示
 */
- (void)showViewWithView:(UIView *)view;

/**
 隐藏
 */
- (void)hideView;

/**
 刷新数据
 */
- (void)loadNewMessage;
@end
