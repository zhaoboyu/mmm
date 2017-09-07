//
//  LSFPSimplifyFooterCollectionReusableView.m
//  YDJR
//
//  Created by 李爽 on 2016/10/31.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFPSimplifyFooterCollectionReusableView.h"

@implementation LSFPSimplifyFooterCollectionReusableView

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
    self.packUpBtn = [[UIButton alloc]initWithFrame:CGRectMake(32 * wScale, 24*hScale, 98 * wScale, 32*hScale)];
    [self.packUpBtn setTitle:@"收起" forState:UIControlStateNormal];
    self.packUpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.packUpBtn setTitleColor:[UIColor hex:@"#FF333333"]];
	[self.packUpBtn setImage:[UIImage imageNamed:@"icon_shouqi"] forState:UIControlStateNormal];
	self.packUpBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 80 * wScale, 0, 0);
	self.packUpBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -38 * wScale, 0, 0);
    [self addSubview:self.packUpBtn];
}

@end
