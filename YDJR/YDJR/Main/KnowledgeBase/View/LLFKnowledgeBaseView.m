//
//  LLFKnowledgeBaseView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/17.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFKnowledgeBaseView.h"

@implementation LLFKnowledgeBaseView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.backgroundColor = [UIColor hexString:@"#FFF0F1F5"];
    
    UIImageView *nullImageView = [[UIImageView alloc]initWithFrame:CGRectMake(910 * wScale, 561 * hScale, 228 * wScale, 202 * hScale)];
    nullImageView.image = [UIImage imageNamed:@"icon_wushuju"];
    [self addSubview:nullImageView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nullImageView.frame) + 48 * hScale, kWidth, 36 * hScale)];
    titleLabel.text = @"暂无数据，敬请期待";
    titleLabel.textColor = [UIColor hexString:@"#FFABADB3"];
    titleLabel.font = [UIFont systemFontOfSize:18.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
 
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
