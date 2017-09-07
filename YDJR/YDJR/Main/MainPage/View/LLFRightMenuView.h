//
//  LLFRightMenuView.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/3.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "PopView.h"

@protocol LLFRightMenuViewDelegate <NSObject>

- (void)sendButtonState:(NSString *)state;

@end

@interface LLFRightMenuView : PopView
@property (nonatomic,assign)NSInteger messageNum;
@property (nonatomic,weak)id<LLFRightMenuViewDelegate>delegate;
- (instancetype)initWithFrame:(CGRect)frame messageNum:(NSInteger)messageNum;
#pragma mark 显示侧边栏
- (void)showRightmenuView;
@end
