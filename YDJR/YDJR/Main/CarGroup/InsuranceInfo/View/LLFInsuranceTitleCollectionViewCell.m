//
//  LLFInsuranceTitleCollectionViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFInsuranceTitleCollectionViewCell.h"
@interface LLFInsuranceTitleCollectionViewCell ()
@property (nonatomic,strong)UIView *bgItemView;
@end
@implementation LLFInsuranceTitleCollectionViewCell
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
    
    self.insuranceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 0, CGRectGetWidth(self.bgItemView.frame) - 32 * wScale, CGRectGetHeight(self.bgItemView.frame))];
    self.insuranceTitleLabel.font = [UIFont systemFontOfSize:17.0];
    self.insuranceTitleLabel.numberOfLines = 0;
    [self.bgItemView addSubview:self.insuranceTitleLabel];
    
    
    
    
}
- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    self.bgItemImageView.frame = CGRectMake(32 * wScale, 24 * hScale, 472 * wScale, 176 * hScale);
    self.insuranceTitleLabel.frame = CGRectMake(32 * wScale, 0, CGRectGetWidth(self.bgItemView.frame) - 32 * wScale, CGRectGetHeight(self.bgItemView.frame));
    if (_isSelect) {
        self.bgItemView.backgroundColor = [UIColor hex:@"#99000000"];
//        self.bgItemImageView.image = [UIImage imageNamed:@"btn_normal_baoxian"];
        self.insuranceTitleLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    }else{
        self.bgItemView.backgroundColor = [UIColor hex:@"#CCFFFFFF"];
//        self.bgItemImageView.image = [UIImage imageNamed:@"btn_pressed_baoxian"];
        self.insuranceTitleLabel.textColor = [UIColor hexString:@"#FF333333"];
    }
}
@end
