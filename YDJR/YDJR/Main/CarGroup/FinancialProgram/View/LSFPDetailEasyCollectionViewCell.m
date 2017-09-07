//
//  LSFPDetailEasyCollectionViewCell.m
//  YDJR
//
//  Created by 李爽 on 2016/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFPDetailEasyCollectionViewCell.h"

@implementation LSFPDetailEasyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

-(void)p_setupView
{
    self.moneyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 96*hScale, self.width - 32*wScale, 24*hScale)];
    self.moneyTitleLabel.font = [UIFont systemFontOfSize:12];
    self.moneyTitleLabel.textColor = [UIColor hexString:@"#FF999999"];
    [self addSubview:self.moneyTitleLabel];
    
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, CGRectGetMaxY(self.moneyTitleLabel.frame) + 24*hScale, self.width - 32*wScale, 40*hScale)];
    self.moneyLabel.text = @"10,000";
    self.moneyLabel.font = [UIFont systemFontOfSize:20];
    self.moneyLabel.textColor = [UIColor hexString:@"#FFFC5A5A"];
    [self addSubview:self.moneyLabel];
    
    //top right bottom line
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, hScale)];
    topView.backgroundColor = [UIColor hexString:@"#FFE3E3E3"];
    [self addSubview:topView];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(self.width - wScale, 0, wScale, self.height)];
    rightView.backgroundColor = [UIColor hexString:@"#FFE3E3E3"];
    [self addSubview:rightView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - hScale, self.width, hScale)];
    bottomView.backgroundColor = [UIColor hexString:@"#FFE3E3E3"];
    [self addSubview:bottomView];
}

@end
