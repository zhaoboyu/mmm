//
//  LLFWorkBenchView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/5/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFWorkBenchView.h"

@interface LLFWorkBenchView ()<LLFCheckAgencyListViewDelegate>

@end

@implementation LLFWorkBenchView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hex:@"#FFF2F2F2"];
        [self p_setupView];
    }
    return self;
}
- (void)p_setupView
{
    self.userInfoView = [[LLFWorkBenchUserInfoView alloc]initWithFrame:CGRectMake(32 * wScale, 32 * hScale, 640 * wScale, 648 * hScale)];
    [self addSubview:self.userInfoView];
    
    self.agencyListView = [[LLFCheckAgencyListView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userInfoView.frame) + 32 * wScale, 32 * hScale, 1312 * wScale, CGRectGetHeight(self.userInfoView.frame))];
    self.agencyListView.delegate = self;
    [self addSubview:self.agencyListView];
    
    self.productTypePieChartView = [[LLFProductTypePieChartView alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(self.userInfoView.frame) + 23 * hScale, 640 * wScale, 536 * hScale)];
    [self addSubview:self.productTypePieChartView];
    
    self.productTypeLineChartView = [[LLFProductTypeDIYLineChartView alloc]initWithFrame:CGRectMake(32 * wScale + CGRectGetMaxX(self.productTypePieChartView.frame), CGRectGetMaxY(self.userInfoView.frame) + 23 * hScale, 1310 * wScale, 536 * hScale)];
    [self addSubview:self.productTypeLineChartView];
    
}

#pragma mark 代理
- (void)clickButtonWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickButtonWithWorkBenchModel:)]) {
        [_delegate clickButtonWithWorkBenchModel:workBenchModel];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
