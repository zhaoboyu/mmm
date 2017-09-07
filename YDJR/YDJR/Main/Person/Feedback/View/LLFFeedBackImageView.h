//
//  LLFFeedBackImageView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/1/11.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLFFeedBackImageViewDelegate <NSObject>

- (void)sendButtonState:(NSString *)state view:(UIView *)view;

@end
@interface LLFFeedBackImageView : UIView
@property (nonatomic,weak)id<LLFFeedBackImageViewDelegate>delegate;
@property (nonatomic,strong)UIImageView *contentImageView;
@property (nonatomic,strong)UIButton *colseButton;
@property (nonatomic,assign)BOOL isClose;
@end
