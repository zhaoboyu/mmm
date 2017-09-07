//
//  LLFRightMenuTableViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFRightMenuTableViewCell.h"

@implementation LLFRightMenuTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupView];
    }
    return self;
}
- (void)p_setupView
{
//    self.contentView.backgroundColor = [UIColor redColor];
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(36 * wScale, 36 * hScale, 40 * wScale, 40 * wScale)];

    [self.contentView addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame) + 32 * wScale, 40 * hScale, 135 * wScale, 32 * hScale)];
//    self.titleLabel.backgroundColor = [UIColor blueColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.titleLabel.textColor = [UIColor hexString:@"#FF666666"];
    [self.contentView addSubview:self.titleLabel];
    
    self.tipMessageImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 16 * wScale, 44 * hScale, 36 * wScale, 24 * hScale)];
    self.tipMessageImageView.image = [UIImage imageNamed:@"bg_xiaoxixiaobiao"];
    [self.contentView addSubview:self.tipMessageImageView];
    
    self.tipMessageNumLabel = [[UILabel alloc]initWithFrame:self.tipMessageImageView.bounds];
    self.tipMessageNumLabel.textAlignment = NSTextAlignmentCenter;
    self.tipMessageNumLabel.font = [UIFont systemFontOfSize:12.0];
    self.tipMessageNumLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    [self.tipMessageImageView addSubview:self.tipMessageNumLabel];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame), 1 * hScale)];
    self.lineView.backgroundColor = LLFColorline();
    [self.contentView addSubview:self.lineView];
}
- (void)layoutSubviews
{
    self.lineView.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame), 1 * hScale);
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
