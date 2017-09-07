//
//  LSFPSimplifyHeaderCollectionReusableView.m
//  YDJR
//
//  Created by 李爽 on 2016/10/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFPSimplifyHeaderCollectionReusableView.h"

@implementation LSFPSimplifyHeaderCollectionReusableView

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
	self.morePlanBtn = [[UIButton alloc]initWithFrame:CGRectMake(32*wScale, 24*hScale, 158*wScale, 32*hScale)];
	[self.morePlanBtn setTitle:@"更多方案" forState:UIControlStateNormal];
	[self.morePlanBtn setTitle:@"更多方案" forState:UIControlStateSelected];
	self.morePlanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
	[self.morePlanBtn setImage:[UIImage imageNamed:@"icon_zhankai"] forState:UIControlStateNormal];
	[self.morePlanBtn setImage:[UIImage imageNamed:@"LSbg"] forState:UIControlStateSelected];
	self.morePlanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 140 * wScale, 0, 0);
	self.morePlanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -38 * wScale, 0, 0);
	[self.morePlanBtn setTitleColor:[UIColor hex:@"#FF333333"] forState:UIControlStateNormal];
	[self.morePlanBtn setTitleColor:[UIColor hex:@"#FF999999"] forState:UIControlStateSelected];
	[self addSubview:self.morePlanBtn];
}

@end
