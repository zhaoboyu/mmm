//
//  LLFCarDetailInfoTableViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 2016/12/21.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarDetailInfoTableViewCell.h"

@implementation LLFCarDetailInfoTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupView];
    }
    return self;
}
- (void)p_setupView
{
    self.titleNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame) / 2, CGRectGetHeight(self.contentView.frame) - 1 * hScale)];
    self.titleNameLabel.textColor = [UIColor hexString:@"#FF666666"];
    self.titleNameLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:self.titleNameLabel];
    
    self.titleDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleNameLabel.frame), 0, CGRectGetWidth(self.contentView.frame) / 2, CGRectGetHeight(self.contentView.frame) - 1 * hScale)];
    self.titleDetailLabel.textColor = [UIColor hexString:@"#FF000000"];
    self.titleDetailLabel.font = [UIFont systemFontOfSize:15.0];
    self.titleDetailLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.titleDetailLabel];
    
    self.lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleNameLabel.frame), CGRectGetWidth(self.contentView.frame), 1 * hScale)];
    self.lineImageView.image = [UIImage imageNamed:@"LLF_SelectNewCarType_line_cell_H"];
    [self.contentView addSubview:self.lineImageView];
    
}
- (void)layoutSubviews
{
    self.titleNameLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame) / 2, CGRectGetHeight(self.contentView.frame) - 1 * hScale);
    self.titleDetailLabel.frame = CGRectMake(CGRectGetMaxX(self.titleNameLabel.frame), 0, CGRectGetWidth(self.contentView.frame) / 2, CGRectGetHeight(self.contentView.frame) - 1 * hScale);
    self.lineImageView.frame = CGRectMake(0, CGRectGetMaxY(self.titleNameLabel.frame), CGRectGetWidth(self.contentView.frame), 1 * hScale);
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
