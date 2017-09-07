//
//  LLFCarModelTableViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarModelTableViewCell.h"

@implementation LLFCarModelTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupView];
    }
    return self;
}
- (void)p_setupView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.carImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 48 * hScale, 356 * wScale, 220 * hScale)];
    [self.contentView addSubview:self.carImageView];
    
    self.carNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carImageView.frame) + 36 * wScale, 0, CGRectGetWidth(self.contentView.frame) - 392 * wScale, 220 * hScale)];
    self.carNameLabel.textColor = [UIColor hexString:@"#FF333333"];
    self.carNameLabel.font = [UIFont systemFontOfSize:18.0];
    self.carNameLabel.numberOfLines = 0;
//    self.carNameLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.carNameLabel];
    
    self.carPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.carNameLabel.frame), CGRectGetMaxY(self.carNameLabel.frame), CGRectGetWidth(self.carNameLabel.frame), 34 * hScale)];
    self.carPriceLabel.textColor = [UIColor hexString:@"#FFFC5A5A"];
    self.carPriceLabel.font = [UIFont systemFontOfSize:15.0];
//    self.carPriceLabel.numberOfLines = 0;
//    [self.contentView addSubview:self.carPriceLabel];
    
    self.selectImageView = [[UIImageView alloc]init];
    self.selectImageView.image = [UIImage imageNamed:@"icon_normal_arrowlist"];
    [self.contentView addSubview:self.selectImageView];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.carImageView.frame), CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame), 1 * hScale)];
    self.lineView.backgroundColor = LLFColorline();
    [self.contentView addSubview:self.lineView];
}
- (void)layoutSubviews
{
    self.carNameLabel.frame = CGRectMake(CGRectGetMaxX(self.carImageView.frame) + 36 * wScale, CGRectGetMinY(self.carImageView.frame), CGRectGetWidth(self.contentView.frame) - 392 * wScale, CGRectGetHeight(self.carImageView.frame));
    
//    self.carPriceLabel.frame = CGRectMake(CGRectGetMinX(self.carNameLabel.frame), CGRectGetMaxY(self.carNameLabel.frame), CGRectGetWidth(self.carNameLabel.frame), 34 * hScale);
    
    self.selectImageView.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - 70 * wScale, CGRectGetHeight(self.contentView.frame) / 2 - 20 * hScale, 22 * wScale, 40 * hScale);
    
    self.lineView.frame = CGRectMake(CGRectGetMinX(self.carImageView.frame), CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame), 1 * hScale);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
