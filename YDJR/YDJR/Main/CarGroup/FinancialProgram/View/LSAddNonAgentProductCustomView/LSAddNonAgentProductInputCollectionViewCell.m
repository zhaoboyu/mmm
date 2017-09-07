//
//  LSAddNonAgentProductInputCollectionViewCell.m
//  YDJR
//
//  Created by 李爽 on 2016/12/21.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddNonAgentProductInputCollectionViewCell.h"
#import "LSTextField.h"

@implementation LSAddNonAgentProductInputCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self p_setupView];
	}
	return self;
}

#pragma mark - p_setupView
-(void)p_setupView
{
	self.L_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 32 * hScale, self.frame.size.width, 24 * hScale)];
	self.L_titleLabel.font = [UIFont systemFontOfSize:12];
	self.L_titleLabel.textColor = [UIColor hexString:@"#FF999999"];
	[self addSubview:self.L_titleLabel];
	
	self.L_contentTextField = [[LSTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.L_titleLabel.frame) + 10 * hScale, self.frame.size.width - 52 * wScale, 64 * hScale)];
	self.L_contentTextField.placeholder = @"请输入";
	self.L_contentTextField.font = [UIFont systemFontOfSize:17];
	self.L_contentTextField.textColor = [UIColor hexString:@"#FF000000"];
	[self addSubview:self.L_contentTextField];
	
	self.selectBoxButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.L_contentTextField.frame), 75 * hScale, 46 * wScale, 46 * hScale)];
	[self.selectBoxButton setBackgroundImage:[UIImage imageNamed:@"icon_normal_xuanze-2"] forState:UIControlStateNormal];
	[self.selectBoxButton setBackgroundImage:[UIImage imageNamed:@"icon_pressed_xuanze-1"] forState:UIControlStateSelected];
	self.selectBoxButton.hidden = YES;
	[self addSubview:self.selectBoxButton];
	
	self.loanYearButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.L_titleLabel.frame) + 10 * hScale, self.frame.size.width - 52 * wScale, 64 * hScale)];
	self.loanYearButton.imageEdgeInsets = UIEdgeInsetsMake(0, 372 * wScale, 0,  -6 * wScale);
	[self.loanYearButton setImage:[UIImage imageNamed:@"icon_normal_xiala"] forState:UIControlStateNormal];
	[self.loanYearButton setImage:[UIImage imageNamed:@"icon_pressed_xiala"] forState:UIControlStateSelected];
	//[self.loanYearButton setTitle:@"期数" forState:UIControlStateNormal];
	self.loanYearButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	self.loanYearButton.titleEdgeInsets = UIEdgeInsetsMake(0, - 26 * wScale, 0, 0);
	[self.loanYearButton setTitleColor:[UIColor hexString:@"#FF000000"]];
	self.loanYearButton.backgroundColor = [UIColor whiteColor];
	self.loanYearButton.hidden = YES;
	[self addSubview:self.loanYearButton];
	
	UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.L_contentTextField.frame) + 1 *hScale, self.frame.size.width, 1 * hScale)];
	bottomView.backgroundColor = [UIColor hexString:@"#FFD9D9D9"];
	[self addSubview:bottomView];
}

@end
