//
//  LSLetterofIntentWideCollectionViewCell.m
//  YDJR
//
//  Created by 李爽 on 2016/11/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSLetterofIntentWideCollectionViewCell.h"

@implementation LSLetterofIntentWideCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self p_setupView];
	}
	return self;
}

-(void)p_setupView
{
	self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 40*hScale, self.width - 32*wScale, 24*hScale)];
	self.nameLabel.font = [UIFont systemFontOfSize:12];
	self.nameLabel.textColor = [UIColor hexString:@"#FF999999"];
	[self addSubview:self.nameLabel];
	
	self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, CGRectGetMaxY(self.nameLabel.frame) + 24*hScale, self.width - 16, 48)];//20
	self.contentLabel.font = [UIFont systemFontOfSize:20];
	self.contentLabel.textColor = [UIColor hexString:@"#FFFC5A5A"];
	self.contentLabel.numberOfLines = 0;
	[self addSubview:self.contentLabel];
	
	//top right bottom line
	//UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, hScale)];
	//topView.backgroundColor = [UIColor hexString:@"#FFE3E3E3"];
	//[self addSubview:topView];
	
	//UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, wScale, self.height)];
	//leftView.backgroundColor = [UIColor hexString:@"#FFE3E3E3"];
	//[self addSubview:leftView];
	
	UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(self.width - wScale, 0, wScale, self.height)];
	rightView.backgroundColor = [UIColor hexString:@"#FFE3E3E3"];
	[self addSubview:rightView];
	
	UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - hScale, self.width, hScale)];
	bottomView.backgroundColor = [UIColor hexString:@"#FFE3E3E3"];
	[self addSubview:bottomView];
}

@end
