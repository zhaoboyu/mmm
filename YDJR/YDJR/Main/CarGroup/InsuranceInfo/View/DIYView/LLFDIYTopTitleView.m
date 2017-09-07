//
//  LLFDIYTopTitleView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/12.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFDIYTopTitleView.h"

@implementation LLFDIYTopTitleView
+ (instancetype)initWithFrame:(CGRect)frame
{
    return [[LLFDIYTopTitleView alloc] initWithFrame:frame];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}
- (void)setupView
{
    UILabel *yueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 116 * wScale, self.frame.size.height)];
    yueLabel.text = @"月份";
    yueLabel.textColor = [UIColor hexString:@"#FF999999"];
    yueLabel.font = [UIFont systemFontOfSize:13.0];
    yueLabel.textAlignment = NSTextAlignmentCenter;
    yueLabel.layer.borderWidth = 0.5;
    yueLabel.layer.borderColor = LLFColorline().CGColor;
    [self addSubview:yueLabel];
    
    UILabel *yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yueLabel.frame), 0, 167 * wScale, self.frame.size.height)];
    yearLabel.text = @"一年年买";
    yearLabel.textColor = [UIColor hexString:@"#FF999999"];
    yearLabel.font = [UIFont systemFontOfSize:13.0];
    yearLabel.textAlignment = NSTextAlignmentCenter;
    yearLabel.layer.borderWidth = 0.5;
    yearLabel.layer.borderColor = LLFColorline().CGColor;
    [self addSubview:yearLabel];
    
    UILabel *threeYearLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(yearLabel.frame), 0, 167 * wScale, self.frame.size.height)];
    threeYearLabel.text = @"三年联保";
    threeYearLabel.textColor = [UIColor hexString:@"#FF999999"];
    threeYearLabel.font = [UIFont systemFontOfSize:13.0];
    threeYearLabel.textAlignment = NSTextAlignmentCenter;
    threeYearLabel.layer.borderWidth = 0.5;
    threeYearLabel.layer.borderColor = LLFColorline().CGColor;
    [self addSubview:threeYearLabel];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
