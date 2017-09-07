//
//  MessageCell.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/10/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}


-(void)setupView{
    //self.backgroundColor=[UIColor yellowColor];
    
    self.titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(40 * wScale, 40 * hScale, 400 * wScale, 36 * hScale)];
    self.titleLabel.textAlignment=NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor hex:@"#FF373D49"];
    self.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [self.contentView addSubview:_titleLabel];

    self.contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame), 19 * hScale + CGRectGetMaxY(self.titleLabel.frame), kWidth - CGRectGetMinX(self.titleLabel.frame), 30 * hScale)];
    self.contentLabel.textAlignment=NSTextAlignmentLeft;
    self.contentLabel.numberOfLines=0;
    self.contentLabel.textColor = [UIColor hex:@"#FFA7A7A7"];
    self.contentLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:_contentLabel];
    
    self.selectImageView = [[UIImageView alloc]init];
    self.selectImageView.image = [UIImage imageNamed:@"icon_normal_arrowlist"];
    [self.contentView addSubview:self.selectImageView];
    
    self.line=[[UIView alloc] init];
    self.line.backgroundColor=LLFColorline();
    [self addSubview:self.line];
}
- (void)layoutSubviews
{
    self.selectImageView.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - 100 * wScale, CGRectGetHeight(self.contentView.frame) / 2 - 17 * hScale, 19 * wScale, 34 * hScale);
    self.line.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame), 1 * hScale);
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
