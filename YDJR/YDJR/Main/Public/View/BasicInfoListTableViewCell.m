//
//  BasicInfoListTableViewCell.m
//  YongDaFinance
//
//  Created by 吕利峰 on 16/8/4.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "BasicInfoListTableViewCell.h"

@implementation BasicInfoListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupView];
    }
    return self;
}
- (void)p_setupView
{
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 0, CGRectGetWidth(self.contentView.frame) - 64 * wScale, CGRectGetHeight(self.contentView.frame))];
    self.titleLable.backgroundColor = [UIColor clearColor];
//    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:self.titleLable];
    
    self.lineImageView = [[UIImageView alloc]init];
    self.lineImageView.frame = CGRectMake(CGRectGetMinX(self.titleLable.frame), CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.titleLable.frame), 1 * hScale);
    self.lineImageView.backgroundColor = [UIColor hexString:@"#FFE6E6E6"];
    [self.contentView addSubview:self.lineImageView];
    self.lineImageView.hidden = YES;
}
- (void)layoutSubviews{
    self.titleLable.frame = CGRectMake(32 * wScale, 0, CGRectGetWidth(self.contentView.frame) - 64 * wScale, CGRectGetHeight(self.contentView.frame));
    self.lineImageView.frame = CGRectMake(CGRectGetMinX(self.titleLable.frame), CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.titleLable.frame), 1 * hScale);
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
