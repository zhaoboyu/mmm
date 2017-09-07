//
//  LLFPersonCenterTableViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 2017/1/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFPersonCenterTableViewCell.h"

@implementation LLFPersonCenterTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_setupView];
    }
    return self;
}
- (void)p_setupView
{
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetHeight(self.contentView.frame) / 2 - 22 * hScale, 44 * wScale, 44 * hScale)];
    [self.contentView addSubview:self.iconImageView];
    
    self.titleNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(23 * wScale + CGRectGetMaxX(self.iconImageView.frame), 0, 200 * wScale, CGRectGetHeight(self.contentView.frame) - 1 * hScale)];
    self.titleNameLabel.textColor = [UIColor hexString:@"#FF333333"];
    self.titleNameLabel.font = [UIFont systemFontOfSize:17.0];
    [self.contentView addSubview:self.titleNameLabel];
    
    self.selsetImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame) - 48 * wScale, CGRectGetHeight(self.contentView.frame) / 2 - 12.5 * hScale, 15 * wScale, 25 * hScale)];
    self.selsetImageView.image = [UIImage imageNamed:@"lightgray"];
    [self.contentView addSubview:self.selsetImageView];
    
    self.messageImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.selsetImageView.frame) - 64 * wScale, CGRectGetHeight(self.contentView.frame) / 2 - 16 * hScale, 48 * wScale, 32 * hScale)];
    self.messageImageView.image = [UIImage imageNamed:@"LLF_Person_messageBG"];
    [self.contentView addSubview:self.messageImageView];
    
    self.messageLabel = [[UILabel alloc]initWithFrame:self.messageImageView.bounds];
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.font = [UIFont systemFontOfSize:12.0];
    self.messageLabel.textColor = [UIColor hex:@"#FFFFFFFF"];
    [self.messageImageView addSubview:self.messageLabel];
    
    self.lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame), 1 * hScale)];
    self.lineImageView.backgroundColor = [UIColor hex:@"#FFD9D9D9"];
    [self.contentView addSubview:self.lineImageView];
    
}
- (void)layoutSubviews
{
    self.iconImageView.frame = CGRectMake(32 * wScale, CGRectGetHeight(self.contentView.frame) / 2 - 22 * hScale, 44 * wScale, 44 * hScale);
    self.titleNameLabel.frame = CGRectMake(23 * wScale + CGRectGetMaxX(self.iconImageView.frame), 0, 200 * wScale, CGRectGetHeight(self.contentView.frame) - 1 * hScale);
    self.selsetImageView.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - 48 * wScale, CGRectGetHeight(self.contentView.frame) / 2 - 12.5 * hScale, 15 * wScale, 25 * hScale);
    self.messageImageView.frame = CGRectMake(CGRectGetMinX(self.selsetImageView.frame) - 64 * wScale, CGRectGetHeight(self.contentView.frame) / 2 - 16 * hScale, 48 * wScale, 32 * hScale);
    self.messageLabel.frame = self.messageImageView.bounds;
    self.lineImageView.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame), 1 * hScale);
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
