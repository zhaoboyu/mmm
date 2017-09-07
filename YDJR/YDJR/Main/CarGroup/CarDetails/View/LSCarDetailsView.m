//
//  LSCarDetailsView.m
//  YDJR
//
//  Created by 李爽 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSCarDetailsView.h"
#import "LSCarDetailsViewController.h"
@interface LSCarDetailsView()
@end

@implementation LSCarDetailsView

#pragma mark init
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self p_setupViewWithFrame:frame];
	}
	return self;
}

- (void)p_setupViewWithFrame:(CGRect)frame
{
	self.backgroundColor = [UIColor whiteColor];
	NSArray *buttonTitleArray = [NSArray arrayWithObjects:@"金融方案",@"保险", nil];
	[self setTitleButtonWithTitleArray:buttonTitleArray];
}
//设置标题栏
- (void)setTitleButtonWithTitleArray:(NSArray *)titleArray
{
	self.titleButtonArray = [NSMutableArray array];
	self.lineViewArray = [NSMutableArray array];
	self.topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 328 * wScale, 88*hScale)];
	self.topView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
	self.topView.userInteractionEnabled = YES;
	CGFloat titleWidth = 140 * wScale;
	for (int i = 0; i < 2; i++) {
		NSString *titleStr = [titleArray objectAtIndex:i];
		UIButton *titleButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
		if (i == 0) {
			titleButton.frame = CGRectMake(i * titleWidth, 27 * hScale, titleWidth , 34 * hScale);
		}else{
			titleButton.frame = CGRectMake(i * titleWidth + 56 *wScale, 27 * hScale, titleWidth , 34 * hScale);
		}
		titleButton.backgroundColor = [UIColor clearColor];
		titleButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
		titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		[titleButton setTitleColor:[UIColor hexString:@"#FF999999"] forState:(UIControlStateNormal)];
		[titleButton setTitle:titleStr forState:(UIControlStateNormal)];
		titleButton.tag = 100 + i;
		[titleButton addTarget:self action:@selector(changePage:) forControlEvents:(UIControlEventTouchUpInside)];
		[self.topView addSubview:titleButton];
		[self.titleButtonArray addObject:titleButton];
		
		UIView *tempLineView = [[UIView alloc]init];
		if (i == 0) {
			tempLineView.frame = CGRectMake(i * titleWidth, 85 * hScale, titleWidth, 3 * hScale);
		}else{
			tempLineView.frame = CGRectMake(i * titleWidth + 56 * wScale, 85 * hScale, titleWidth/2, 3 * hScale);
		}
		tempLineView.backgroundColor = [UIColor clearColor];
		[self.topView addSubview:tempLineView];
		[self.lineViewArray addObject:tempLineView];
		
		//默认选中中间的table页
		if (i == 0) {
			[titleButton setTitleColor:[UIColor hexString:@"#FF333333"] forState:(UIControlStateNormal)];
			tempLineView.backgroundColor = [UIColor hexString:@"#FF333333"];
		}
		
	}
	
	self.BackgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
	self.BackgroundScrollView.backgroundColor = [UIColor hexString:@"#FFFFFF"];
	self.BackgroundScrollView.delegate = self;
	self.BackgroundScrollView.pagingEnabled = YES;
	self.BackgroundScrollView.bounces = NO;
	self.BackgroundScrollView.showsHorizontalScrollIndicator = NO;
	self.BackgroundScrollView.showsVerticalScrollIndicator = NO;
	self.BackgroundScrollView.directionalLockEnabled = YES;
	self.BackgroundScrollView.contentSize = CGSizeMake(kWidth * 2, 0);
	self.BackgroundScrollView.contentOffset = CGPointMake(0, 0);
	[self addSubview:self.BackgroundScrollView];
	
	[self bringSubviewToFront:self.topView];
}

- (void)changePage:(UIButton *)sender
{
	if ([_delegate respondsToSelector:@selector(addViewControllerWithIndex:)]) {
		[_delegate addViewControllerWithIndex:sender.tag - 100];
	}
	for (int i = 0; i < 2; i++) {
		UIButton *tempButton = self.titleButtonArray[i];
		UIView *tempLineView = self.lineViewArray[i];
		if (i == sender.tag - 100) {
			[tempButton setTitleColor:[UIColor hexString:@"#FF333333"] forState:(UIControlStateNormal)];
			tempLineView.backgroundColor = [UIColor hexString:@"#FF333333"];
			self.BackgroundScrollView.contentOffset = CGPointMake(self.BackgroundScrollView.frame.size.width * i, 0);
		}else{
			[tempButton setTitleColor:[UIColor hexString:@"#FF999999"] forState:(UIControlStateNormal)];
			tempLineView.backgroundColor = [UIColor clearColor];
		}
	}
}
#pragma mark UIScrollView的代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	if ([_delegate respondsToSelector:@selector(addViewControllerWithIndex:)]) {
		[_delegate addViewControllerWithIndex:(scrollView.contentOffset.x / kWidth)];
	}
	for (int i = 0; i < 2; i++) {
		UIButton *tempButton = self.titleButtonArray[i];
		UIView *tempLineView = self.lineViewArray[i];
		if (i == (scrollView.contentOffset.x / kWidth)) {
			[tempButton setTitleColor:[UIColor hexString:@"#FF333333"] forState:(UIControlStateNormal)];
			tempLineView.backgroundColor = [UIColor hexString:@"#FF333333"];
		}else{
			[tempButton setTitleColor:[UIColor hexString:@"#FF999999"] forState:(UIControlStateNormal)];
			tempLineView.backgroundColor = [UIColor clearColor];
		}
	}
}

@end
