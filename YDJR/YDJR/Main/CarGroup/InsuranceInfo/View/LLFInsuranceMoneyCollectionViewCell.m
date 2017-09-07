//
//  LLFInsuranceMoneyCollectionViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/11.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFInsuranceMoneyCollectionViewCell.h"

@implementation LLFInsuranceMoneyCollectionViewCell
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
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.bgItemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(32 * wScale, 24 * hScale, 320 * wScale, 176 * hScale)];
    self.bgItemImageView.image = [UIImage imageNamed:@"LLF_InsuranceInfo_btn_normal_huafeiduibi"];
    [self.contentView addSubview:self.bgItemImageView];
    
    self.insuranceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 42 * hScale, CGRectGetWidth(self.bgItemImageView.frame), 34 * hScale)];
    self.insuranceTitleLabel.text = @"花费对比";
    self.insuranceTitleLabel.font = [UIFont systemFontOfSize:17.0];
    self.insuranceTitleLabel.numberOfLines = 0;
    self.insuranceTitleLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    self.insuranceTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgItemImageView addSubview:self.insuranceTitleLabel];
    
    self.insuranceContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.insuranceTitleLabel.frame), CGRectGetMaxY(self.insuranceTitleLabel.frame) + 24 * hScale, CGRectGetWidth(self.insuranceTitleLabel.frame), 34 * hScale)];
    self.insuranceContentLabel.textColor = [UIColor hexString:@"#A6FFFFFF"];
    self.insuranceContentLabel.font = [UIFont systemFontOfSize:17.0];
    self.insuranceContentLabel.text = @"那个更优惠！？";
    self.insuranceContentLabel.textAlignment = NSTextAlignmentCenter;
    //    self.insuranceContentLabel.numberOfLines = 0;
    [self.bgItemImageView addSubview:self.insuranceContentLabel];
    
    
}
@end
