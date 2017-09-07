//
//  LSAddNonAgentProductResultTableViewCell.m
//  YDJR
//
//  Created by 李爽 on 2016/12/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddNonAgentProductResultTableViewCell.h"

@implementation LSAddNonAgentProductResultTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.L_TitleLable = [[UILabel alloc]initWithFrame:CGRectMake(64 * wScale, 41 * hScale, 190 * wScale, 30 *hScale)];
		self.L_TitleLable.font = [UIFont systemFontOfSize:15];
		self.L_TitleLable.textColor = [UIColor hexString:@"#FF666666"];
		[self.contentView addSubview:self.L_TitleLable];
		
		self.L_subTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(336 * wScale, 41 * hScale, 240 * wScale, 30 *hScale)];
		self.L_subTitleLable.font = [UIFont systemFontOfSize:15];
		self.L_subTitleLable.textColor = [UIColor hexString:@"#FF666666"];
		[self.contentView addSubview:self.L_subTitleLable];
		
		self.L_ContentLable = [[UILabel alloc]initWithFrame:CGRectMake(1272 * wScale, 36 * hScale, 360 * wScale, 30 * hScale)];
		self.L_ContentLable.font = [UIFont systemFontOfSize:15];
		[self.contentView addSubview:self.L_ContentLable];
		
		UIImageView *dottedLineImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(64 * wScale, 111 * hScale, 1568 * wScale, 1 * hScale)];
		dottedLineImageView.image = [UIImage imageNamed:@"LSline_cell_xuxian"];
		[self.contentView addSubview:dottedLineImageView];
	}
	return self;
}

@end
