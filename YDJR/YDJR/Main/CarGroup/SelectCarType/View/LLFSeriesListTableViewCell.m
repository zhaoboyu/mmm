//
//  LLFSeriesListTableViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFSeriesListTableViewCell.h"

@implementation LLFSeriesListTableViewCell
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
    self.seriesNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 0, CGRectGetWidth(self.contentView.frame) - 32 * wScale, CGRectGetHeight(self.contentView.frame) - 1 * hScale)];
    self.seriesNameLabel.textColor = [UIColor hexString:@"#FF333333"];
    self.seriesNameLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:self.seriesNameLabel];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.seriesNameLabel.frame), CGRectGetWidth(self.contentView.frame), 1 * hScale)];
    self.lineView.backgroundColor = LLFColorline();
    [self.contentView addSubview:self.lineView];
}
- (void)layoutSubviews
{
    self.seriesNameLabel.frame = CGRectMake(32 * wScale, 0, CGRectGetWidth(self.contentView.frame) - 32 * wScale, CGRectGetHeight(self.contentView.frame) - 1 * hScale);
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.seriesNameLabel.frame), CGRectGetWidth(self.contentView.frame), 1 * hScale);
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
