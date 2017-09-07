//
//  LLFChangTypeListTableViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 2017/6/22.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFChangTypeListTableViewCell.h"
@interface LLFChangTypeListTableViewCell ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *selectedImage;
@property (nonatomic,strong)UIView *line;

@end
@implementation LLFChangTypeListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
           [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(29*wScale, 0, CGRectGetWidth(self.contentView.frame) - (29+54)*wScale, CGRectGetHeight(self.contentView.frame))];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor hexString:@"#999999"];
    [self.contentView addSubview:_titleLabel];
    
    self.selectedImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.contentView.frame) - 47 * wScale, (CGRectGetHeight(self.contentView.frame) - 30*hScale)/2, 18*wScale, 30*hScale)];
    self.selectedImage.image = [UIImage imageNamed:@"LLF_SelectNewCarType_select"];
    [self.contentView addSubview:_selectedImage];
    self.line = [[UIView alloc]initWithFrame:CGRectMake(29*wScale, CGRectGetHeight(self.contentView.frame)-1*wScale, CGRectGetWidth(self.contentView.frame) - 29*wScale, 1*wScale)];
    self.line.backgroundColor = [UIColor hexString:@"#d9d9d9"];
    [self.contentView addSubview:_line];
}
- (void)cell:(NSString *)title
{
    self.titleLabel.text = title;
    self.titleLabel.textColor=[UIColor hexString:@"#333333"];
}
- (void)layoutSubviews
{
    self.titleLabel.frame = CGRectMake(29*wScale, 0, CGRectGetWidth(self.contentView.frame) - (29+54)*wScale, CGRectGetHeight(self.contentView.frame));
    self.selectedImage.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - 47 * wScale, (CGRectGetHeight(self.contentView.frame) - 30*hScale)/2, 18*wScale, 30*hScale);
    self.line.frame = CGRectMake(29*wScale, CGRectGetHeight(self.contentView.frame)-1*wScale, CGRectGetWidth(self.contentView.frame) - 29*wScale, 1*wScale);
}
@end
