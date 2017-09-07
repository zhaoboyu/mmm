//
//  LLFInsuranceInfoCollectionReusableView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFInsuranceInfoCollectionReusableView.h"

@implementation LLFInsuranceInfoCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViewWithFrame:frame];
    }
    return self;
}
- (void)setupViewWithFrame:(CGRect)frame
{
    self.topLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 32 * hScale, frame.size.width - 32 * wScale, 30 * hScale)];
    self.topLabel.textColor = [UIColor hexString:@"#FF666666"];
    self.topLabel.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:self.topLabel];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.topLabel.frame), CGRectGetMaxY(self.topLabel.frame) + 6 * hScale, 100 * wScale, 2 * hScale)];
    self.lineView.backgroundColor = LLFColorline();
    [self addSubview:self.lineView];
}
@end
