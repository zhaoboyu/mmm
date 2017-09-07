//
//  LSAddNonAgentProductCustomView.m
//  YDJR
//
//  Created by 李爽 on 2016/11/30.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddNonAgentProductCustomView.h"
#import "LSTextField.h"

@implementation LSAddNonAgentProductCustomView

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		self.L_TitleLable = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 32 * hScale, 196 * wScale, 24 *hScale)];
		self.L_TitleLable.font = [UIFont systemFontOfSize:12];
		self.L_TitleLable.textColor = [UIColor hexString:@"#FF999999"];
		
		self.contentTextField = [[LSTextField alloc]initWithFrame:CGRectMake(32 *wScale, CGRectGetMaxY(self.L_TitleLable.frame) + 12 *hScale, 368 * wScale, 64 * hScale)];
		self.contentTextField.font = [UIFont systemFontOfSize:14];
		self.contentTextField.backgroundColor = [UIColor hexString:@"#FFF3F4F8"];
		
		self.periodsButton = [[UIButton alloc]initWithFrame:CGRectMake(32 *wScale, CGRectGetMaxY(self.L_TitleLable.frame) + 12 *hScale, 368 * wScale, 64 * hScale)];
		self.periodsButton.titleLabel.font = [UIFont systemFontOfSize:14];
		self.periodsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		self.periodsButton.titleEdgeInsets = UIEdgeInsetsMake(0, - 10*wScale, 0, 0);
		[self.periodsButton setTitleColor:[UIColor blackColor]];
		[self.periodsButton setImage:[UIImage imageNamed:@"icon_normal_xuanze"] forState:UIControlStateNormal];
		self.periodsButton.imageEdgeInsets = UIEdgeInsetsMake(0, 308 * wScale, 0, 0);
		self.periodsButton.imageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
		self.periodsButton.backgroundColor = [UIColor hexString:@"#FFF3F4F8"];
		
		self.checkButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contentTextField.frame) + 12 *hScale, self.contentTextField.frame.origin.y, 64 * wScale, self.contentTextField.height)];
		[self.checkButton addTarget:self action:@selector(deselectCheckButton:) forControlEvents:UIControlEventTouchUpInside];
		[self.checkButton setImage:[UIImage imageNamed:@"icon_normal_xuanze-1"] forState:UIControlStateNormal];
		[self.checkButton setImage:[UIImage imageNamed:@"icon_pressed_xuanze"] forState:UIControlStateSelected];
		self.checkButton.hidden = YES;
		[self addSubview:self.L_TitleLable];
		[self addSubview:self.contentTextField];
		[self addSubview:self.periodsButton];
		[self addSubview:self.checkButton];
	}
	return self;
}

-(void)deselectCheckButton:(UIButton *)sender
{
	sender.selected = !sender.selected;
}

@end
