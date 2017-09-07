//
//  PopView.m
//  CTTX
//
//  Created by 吕利峰 on 16/4/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "PopView.h"
#import "AppDelegate.h"

@interface PopView ()
{
    BOOL _isShow;
}
@property (nonatomic,strong)AppDelegate *appDelegate;
@end

@implementation PopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isShow = NO;
        self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return self;
}
//添加到winder上
- (void)addPopViewToWinder
{
    if (!_isShow) {
        _isShow = YES;
        [self.appDelegate.window addSubview:self];
    }
}
//从winder上移除
- (void)removePopViewFromWinder
{
    if (_isShow) {
        _isShow = NO;
        [self removeFromSuperview];
    }
}

@end
