//
//  RevisePassworderPopView.h
//  YDJR
//
//  Created by 吕利峰 on 16/11/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "PopView.h"
@protocol RevisePassworderPopViewDelegate <NSObject>

- (void)sendReviseState:(NSString *)state;

@end
@interface RevisePassworderPopView : PopView
@property (nonatomic,weak)id<RevisePassworderPopViewDelegate>delegate;
#pragma mark 显示修改密码界面
- (void)showView;
@end
