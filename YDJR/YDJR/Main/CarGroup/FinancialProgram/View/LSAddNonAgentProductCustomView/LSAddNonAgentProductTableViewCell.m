//
//  LSAddNonAgentProductTableViewCell.m
//  YDJR
//
//  Created by 李爽 on 2016/11/30.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddNonAgentProductTableViewCell.h"

@implementation LSAddNonAgentProductTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.L_DescLable = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 41 * hScale, 140 * wScale, 30 *hScale)];
		self.L_DescLable.font = [UIFont systemFontOfSize:15];
		self.L_DescLable.textColor = [UIColor hexString:@"#FF999999"];
		self.L_DescLable.hidden = YES;
		[self.contentView addSubview:self.L_DescLable];
		self.L_TitleLable = [[UILabel alloc]initWithFrame:CGRectMake(284 * wScale, 41 * hScale, 165 * wScale, 30 *hScale)];
		self.L_TitleLable.font = [UIFont systemFontOfSize:15];
		self.L_TitleLable.textColor = [UIColor hexString:@"#FF666666"];
		[self.contentView addSubview:self.L_TitleLable];
		self.L_ContentLable = [[UILabel alloc]initWithFrame:CGRectMake(530 * wScale, 36 * hScale, 360 * wScale, 40 * hScale)];
		self.L_ContentLable.font = [UIFont systemFontOfSize:20];
		[self.contentView addSubview:self.L_ContentLable];
	}
	return self;
}
@end
