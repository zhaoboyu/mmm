//
//  LSBankCardInfoTableViewCell.m
//  YDJR
//
//  Created by 李爽 on 2017/4/6.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LSBankCardInfoTableViewCell.h"
#import "LLFDafenqiBusinessModel.h"

@implementation LSBankCardInfoTableViewCell

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

	//黑色条
	UIView *blackStcikView = [[UIView alloc]initWithFrame:CGRectMake(40 * wScale, 60 * hScale, 6 * wScale, 30 * hScale)];
	blackStcikView.backgroundColor = [UIColor hexString:@"#FF333333"];
	[self addSubview:blackStcikView];
	
	//大标题
	self.L_TitleLable = [[UILabel alloc]initWithFrame:CGRectMake(56 * wScale, 58 * hScale, 300 * wScale, 34 * hScale)];
	self.L_TitleLable.font = [UIFont systemFontOfSize:15];
	self.L_TitleLable.textColor = [UIColor hexString:@"#FF333333"];
	[self addSubview:self.L_TitleLable];
	
}

-(void)layoutSubviews
{
	for (UIView *view in self.controlArray) {
		[view removeFromSuperview];
	}
	[super layoutSubviews];
	//内容
	for (int i = 0; i < self.daFenQiApplyInfoTitleArr.count; i++) {

		NSString *subTitleString = self.daFenQiApplyInfoTitleArr[i];
		//计算文本文字size
		CGSize subTitleSize = [subTitleString sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]}];
		//获取宽高
		CGSize subTitleStrSize = CGSizeMake(ceilf(subTitleSize.width), ceilf(subTitleSize.height));
		
		NSString *contentString = self.daFenQiApplyInfContentArr[i];
		//计算文本文字size
		CGSize contentSize = [contentString sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0f]}];
		//获取宽高
		CGSize contentStrSize = CGSizeMake(ceilf(contentSize.width), ceilf(contentSize.height));
		
		CGFloat subTitleX,subTitleY;
		subTitleX=(i%2)*679*wScale+56*wScale;
		subTitleY=58*(i/2)*hScale+114*hScale;
		
		self.L_subTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(subTitleX, subTitleY, subTitleStrSize.width, 28 * hScale)];
		self.L_subTitleLable.font = [UIFont systemFontOfSize:14];
		self.L_subTitleLable.textColor = [UIColor hexString:@"#FFA7A7A7"];
		self.L_subTitleLable.text = self.daFenQiApplyInfoTitleArr[i];
		
		self.L_ContentLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.L_subTitleLable.frame), subTitleY, contentStrSize.width, 28 * hScale)];
		self.L_ContentLable.font = [UIFont systemFontOfSize:14];
		self.L_ContentLable.textColor = [UIColor hexString:@"#FF333333"];
		self.L_ContentLable.text = self.daFenQiApplyInfContentArr[i];
		
		[self addSubview:self.L_subTitleLable];
		[self addSubview:self.L_ContentLable];
		[self.controlArray addObject:self.L_subTitleLable];
		[self.controlArray addObject:self.L_ContentLable];
	}
	self.bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(40 * wScale, self.frame.size.height - hScale, 1390 * wScale, hScale)];
	self.bottomLineView.backgroundColor = [UIColor hexString:@"#FFD9D9D9"];
	[self addSubview:self.bottomLineView];
	[self.controlArray addObject:self.bottomLineView];
}

#pragma mark - get
- (NSMutableArray*)controlArray
{
	if (!_controlArray) {
		_controlArray = [NSMutableArray array];
	}
	return _controlArray;
}
@end
