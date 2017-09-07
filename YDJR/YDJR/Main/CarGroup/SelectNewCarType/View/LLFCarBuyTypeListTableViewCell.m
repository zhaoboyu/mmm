//
//  LLFCarBuyTypeListTableViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 2016/12/20.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarBuyTypeListTableViewCell.h"
#import "UIImage+CreateImageWithColor.h"
@implementation LLFCarBuyTypeListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupView];
    }
    return self;
}
- (void)p_setupView
{
    self.backgroundColor = [UIColor hex:@"#D9FFFFFF"];
//    self.contentView.backgroundColor = [UIColor hex:@"#D9FFFFFF"];
    self.carBuyTypeNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 0, CGRectGetWidth(self.contentView.frame) - 32 * wScale, CGRectGetHeight(self.contentView.frame) - 1 * hScale)];
    self.carBuyTypeNameLabel.textColor = [UIColor hexString:@"#FF999999"];
    self.carBuyTypeNameLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:self.carBuyTypeNameLabel];
    
    self.lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(self.carBuyTypeNameLabel.frame), CGRectGetWidth(self.contentView.frame) - 64 * wScale, 1 * hScale)];
    self.lineImageView.image = [UIImage imageNamed:@"LLF_SelectNewCarType_line_cell_H"];
    [self.contentView addSubview:self.lineImageView];
    
    self.leftLineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(8 * wScale, 36 * hScale, 4 * wScale, 26 * hScale)];
    self.leftLineImageView.backgroundColor = [UIColor clearColor];
    self.leftLineImageView.image = [UIImage imageNamed:@"#D9FFFFFF"];
    [self.contentView addSubview:self.leftLineImageView];
//    self.leftLineImageView.hidden = YES;
}
- (void)layoutSubviews
{
    self.carBuyTypeNameLabel.frame = CGRectMake(32 * wScale, 0, CGRectGetWidth(self.contentView.frame) - 32 * wScale, CGRectGetHeight(self.contentView.frame) - 1 * hScale);
    self.lineImageView.frame = CGRectMake(32 * wScale, CGRectGetMaxY(self.carBuyTypeNameLabel.frame), CGRectGetWidth(self.contentView.frame) - 64 * wScale, 1 * hScale);
    self.leftLineImageView.frame = CGRectMake(8 * wScale, 36 * hScale, 4 * wScale, 26 * hScale);
}
//设置选中字体颜色
- (void)labelTextColorWithColor:(NSString *)color
{
    self.carBuyTypeNameLabel.highlightedTextColor = [UIColor hex:color];
    self.leftLineImageView.highlightedImage = [UIImage createImageWithColor:@"#FF000000"];
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
