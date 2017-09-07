//
//  LSLeftMenuTableViewCell.m
//  YDJR
//
//  Created by 李爽 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSLeftMenuTableViewCell.h"

@implementation LSLeftMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(32*wScale, 24*hScale, 432*wScale, 216*hScale)];
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 4;
    self.bgView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
    
    //标题
    self.programTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(24*wScale, 0, self.bgView.width - 88*wScale, 104*hScale)];
    self.programTitleLabel.text = @"BMW厂方-售后回租产品";
    self.programTitleLabel.numberOfLines = 0;
    self.programTitleLabel.font = [UIFont systemFontOfSize:17];
    self.programTitleLabel.textColor = [UIColor hexString:@"#FF333333"];
    [self.bgView addSubview:self.programTitleLabel];
    
    //实际购车成本(元) 标题
    self.costOfCarLabel = [[UILabel alloc]initWithFrame:CGRectMake(24*wScale, CGRectGetMaxY(self.programTitleLabel.frame), 192*wScale, 24*hScale)];
    self.costOfCarLabel.text = @"实际购车成本(元)";
    self.costOfCarLabel.font = [UIFont systemFontOfSize:12];
    self.costOfCarLabel.textColor = [UIColor hexString:@"#FF999999"];
    [self.bgView addSubview:self.costOfCarLabel];
    
    //购车成本
    self.costAmountLabel = [[UILabel alloc]initWithFrame:CGRectMake(24*wScale, CGRectGetMaxY(self.costOfCarLabel.frame) + 16*hScale, self.bgView.width - 24*wScale, 36*hScale)];
    //self.costAmountLabel.text = @"268,802.00";
    self.costAmountLabel.font = [UIFont systemFontOfSize:18];
    self.costAmountLabel.textColor = [UIColor hexString:@"#FFFC5A5A"];
    [self.bgView addSubview:self.costAmountLabel];
    
    [self addSubview:self.bgView];
}


@end
