//
//  LLFCarModelDetailTableViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarModelDetailTableViewCell.h"

@implementation LLFCarModelDetailTableViewCell
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
    self.topYearLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100 * wScale, 36 * hScale)];
    self.topYearLabel.backgroundColor = [UIColor hexString:@"#FF21456E"];
    self.topYearLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    self.topYearLabel.font = [UIFont systemFontOfSize:12.0];
    self.topYearLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.topYearLabel];
    
    self.carModelDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.topYearLabel.frame), CGRectGetMaxY(self.topYearLabel.frame) + 32 * hScale, CGRectGetWidth(self.contentView.frame), 30 * hScale)];
    self.carModelDetailLabel.textColor = [UIColor hexString:@"#FF333333"];
    self.carModelDetailLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:self.carModelDetailLabel];
    
    self.carModelPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.topYearLabel.frame), CGRectGetMaxY(self.self.carModelDetailLabel.frame) + 21 * hScale, CGRectGetWidth(self.carModelDetailLabel.frame), 24 * hScale)];
    self.carModelPriceLabel.textColor = [UIColor hexString:@"#FFFC5A5A"];
    self.carModelPriceLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:self.carModelPriceLabel];
    
    self.carModelGchzjkLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.carModelPriceLabel.frame), CGRectGetMaxY(self.carModelPriceLabel.frame) + 21 * hScale, CGRectGetWidth(self.carModelPriceLabel.frame), CGRectGetHeight(self.carModelPriceLabel.frame))];
//    self.carModelGchzjkLabel.backgroundColor = [UIColor redColor];
    self.carModelGchzjkLabel.textColor = [UIColor hexString:@"#FFFC5A5A"];
    self.carModelGchzjkLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:self.carModelGchzjkLabel];
    
    self.selectImageView = [[UIImageView alloc]init];
    self.selectImageView.image = [UIImage imageNamed:@"icon_normal_arrowlist"];
    [self.contentView addSubview:self.selectImageView];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.topYearLabel.frame), CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame), 1 * hScale)];
    self.lineView.backgroundColor = LLFColorline();
    [self.contentView addSubview:self.lineView];

}
- (void)layoutSubviews
{
    self.topYearLabel.frame = CGRectMake(0, 0, 100 * wScale, 36 * hScale);
    self.carModelDetailLabel.frame = CGRectMake(CGRectGetMinX(self.topYearLabel.frame), CGRectGetMaxY(self.topYearLabel.frame) + 32 * hScale, CGRectGetWidth(self.contentView.frame), 30 * hScale);
    self.carModelPriceLabel.frame = CGRectMake(CGRectGetMinX(self.topYearLabel.frame), CGRectGetMaxY(self.self.carModelDetailLabel.frame) + 21 * hScale, CGRectGetWidth(self.carModelDetailLabel.frame), 24 * hScale);
    self.carModelGchzjkLabel.frame = CGRectMake(CGRectGetMinX(self.carModelPriceLabel.frame), CGRectGetMaxY(self.carModelPriceLabel.frame) + 21 * hScale, CGRectGetWidth(self.carModelPriceLabel.frame), CGRectGetHeight(self.carModelPriceLabel.frame));
    self.selectImageView.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - 70 * wScale, CGRectGetHeight(self.contentView.frame) / 2 - 20 * hScale, 22 * wScale, 40 * hScale);
    
    self.lineView.frame = CGRectMake(CGRectGetMinX(self.topYearLabel.frame), CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame), 1 * hScale);
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
