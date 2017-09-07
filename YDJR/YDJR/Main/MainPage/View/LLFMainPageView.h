//
//  LLFMainPageView.h
//  YDJR
//
//  Created by 吕利峰 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLFMainPageViewDelegate <NSObject>
- (void)sendButtonIndex:(NSString *)index;
@end
@interface LLFMainPageView : UIView
@property (nonatomic,strong)UILabel *messageLabel;//显示通知消息
@property (nonatomic,strong)UIButton *messageButton;//跳转到消息列表界面
@property (nonatomic,weak)id<LLFMainPageViewDelegate>delegate;//代理
@end
