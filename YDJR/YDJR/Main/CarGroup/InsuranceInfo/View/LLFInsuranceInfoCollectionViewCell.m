//
//  LLFInsuranceInfoCollectionViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFInsuranceInfoCollectionViewCell.h"

@interface LLFInsuranceInfoCollectionViewCell ()
@property (nonatomic,strong)UIView *bgItemView;
@end

@implementation LLFInsuranceInfoCollectionViewCell
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
    self.bgItemImageView = [[UIImageView alloc]initWithFrame:CGRectMake(32 * wScale, 24 * hScale, 472 * wScale, 176 * hScale)];
    [self.contentView addSubview:self.bgItemImageView];
    
    self.bgItemView = [[UIView alloc]initWithFrame:self.bgItemImageView.bounds];
    [self.bgItemImageView addSubview:self.bgItemView];
    
    self.insuranceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 42 * hScale, CGRectGetWidth(self.bgItemView.frame) - 32 * wScale, 34 * hScale)];
    self.insuranceTitleLabel.font = [UIFont systemFontOfSize:17.0];
    self.insuranceTitleLabel.numberOfLines = 0;
    [self.bgItemView addSubview:self.insuranceTitleLabel];
    
    _insuranceContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.insuranceTitleLabel.frame), CGRectGetMaxY(self.insuranceTitleLabel.frame), CGRectGetWidth(self.insuranceTitleLabel.frame), 82 * hScale)];
    //    self.insuranceContentLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    _insuranceContentLabel.font = [UIFont systemFontOfSize:17.0];
    _insuranceContentLabel.numberOfLines = 0;
    [self.bgItemView addSubview:_insuranceContentLabel];

    
    
}
- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    self.bgItemImageView.frame = CGRectMake(32 * wScale, 24 * hScale, 472 * wScale, 176 * hScale);
    self.insuranceTitleLabel.frame = CGRectMake(32 * wScale, 42 * hScale, CGRectGetWidth(self.bgItemView.frame) - 32 * wScale, 34 * hScale);
    self.insuranceContentLabel.frame = CGRectMake(CGRectGetMinX(self.insuranceTitleLabel.frame), CGRectGetMaxY(self.insuranceTitleLabel.frame), CGRectGetWidth(self.insuranceTitleLabel.frame), 82 * hScale);
    if (_isSelect) {
        self.bgItemView.backgroundColor = [UIColor hex:@"#99000000"];
//        self.bgItemImageView.image = [UIImage imageNamed:@"btn_normal_baoxian"];
        self.insuranceTitleLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
        self.insuranceContentLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    }else{
//        self.bgItemImageView.image = [UIImage imageNamed:@"btn_pressed_baoxian"];
        self.bgItemView.backgroundColor = [UIColor hex:@"#CCFFFFFF"];
        self.insuranceTitleLabel.textColor = [UIColor hexString:@"#FF333333"];
        self.insuranceContentLabel.textColor = [UIColor hexString:@"#FF4C4C4C"];
    }
}
@end
