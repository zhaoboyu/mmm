//
//  LSMasterTableViewCell.m
//  YDJR
//
//  Created by 李爽 on 2016/11/14.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSMasterTableViewCell.h"

@implementation LSMasterTableViewCell

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
	self.pictuerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(32*wScale, 24*hScale, 472*wScale, 216*hScale)];
	//self.pictuerImageView.userInteractionEnabled = YES;
	
	self.bgView = [[UIView alloc]initWithFrame:CGRectMake(32*wScale, 24*hScale, 472*wScale, 216*hScale)];
	self.bgView.backgroundColor = [UIColor hexString:@"#CCFFFFFF"];
	
	//标题
	self.programTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(24*wScale, 0, self.bgView.width - 88*wScale, 104*hScale)];
	//self.programTitleLabel.text = @"BMW厂方-售后回租产品";
	self.programTitleLabel.numberOfLines = 0;
	self.programTitleLabel.font = [UIFont systemFontOfSize:17];
	self.programTitleLabel.textColor = [UIColor hexString:@"#FF333333"];
	[self.bgView addSubview:self.programTitleLabel];
	
	//实际购车成本(元) 标题
	self.costOfCarLabel = [[UILabel alloc]initWithFrame:CGRectMake(24*wScale, CGRectGetMaxY(self.programTitleLabel.frame), 192*wScale, 24*hScale)];
	self.costOfCarLabel.text = @"实际购车成本(元)";
	self.costOfCarLabel.font = [UIFont systemFontOfSize:10];
	self.costOfCarLabel.textColor = [UIColor colorWithColor:[UIColor hexString:@"#FF333333"] alpha:0.65];
	[self.bgView addSubview:self.costOfCarLabel];
	
	//购车成本
	self.costAmountLabel = [[UILabel alloc]initWithFrame:CGRectMake(24*wScale, CGRectGetMaxY(self.costOfCarLabel.frame) + 16*hScale, self.bgView.width - 24*wScale, 36*hScale)];
	//self.costAmountLabel.text = @"268,802.00";
	self.costAmountLabel.font = [UIFont systemFontOfSize:17];
	self.costAmountLabel.textColor = [UIColor colorWithColor:[UIColor hexString:@"#FF333333"] alpha:0.65];
	[self.bgView addSubview:self.costAmountLabel];
	
	[self addSubview:self.pictuerImageView];
	[self addSubview:self.bgView];
}

@end
