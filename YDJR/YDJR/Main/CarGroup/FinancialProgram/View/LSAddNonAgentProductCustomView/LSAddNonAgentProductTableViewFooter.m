//
//  LSAddNonAgentProductTableViewFooter.m
//  YDJR
//
//  Created by 李爽 on 2016/11/30.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddNonAgentProductTableViewFooter.h"

@implementation LSAddNonAgentProductTableViewFooter

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		UIView *cuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 912 * wScale, 1 * hScale)];
		cuttingLine.backgroundColor = [UIColor hexString:@"#FFE6E6E6"];
		[self.contentView addSubview:cuttingLine];
		self.L_TitleLable = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 41 * hScale, 200 * wScale, 30 *hScale)];
		self.L_TitleLable.font = [UIFont systemFontOfSize:15];
		self.L_TitleLable.textColor = [UIColor hexString:@"#FFFC5A5A"];
		[self.contentView addSubview:self.L_TitleLable];
		self.L_ContentLable = [[UILabel alloc]initWithFrame:CGRectMake(284 * wScale, 36 * hScale, 360 * wScale, 40 * hScale)];
		self.L_ContentLable.font = [UIFont systemFontOfSize:20];
		self.L_ContentLable.textColor = [UIColor hexString:@"#FFFC5A5A"];
		[self.contentView addSubview:self.L_ContentLable];
	}
	return self;
}


@end
