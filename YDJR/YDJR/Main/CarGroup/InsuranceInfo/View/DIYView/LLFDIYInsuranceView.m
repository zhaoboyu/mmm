//
//  LLFDIYInsuranceView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/12.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFDIYInsuranceView.h"

@implementation LLFDIYInsuranceView
+ (instancetype)initWithFrame:(CGRect)frame
{
    return [[LLFDIYInsuranceView alloc] initWithFrame:frame];
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
    self.bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
//    self.bgImageView.image = [UIImage imageNamed:@"white"];
    [self addSubview:self.bgImageView];
    
    self.yueLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 125 * wScale, self.frame.size.height)];
    self.yueLabel.textColor = [UIColor hexString:@"#FF999999"];
    self.yueLabel.font = [UIFont systemFontOfSize:13.0];
    self.yueLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgImageView addSubview:self.yueLabel];
    
    self.yearLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.yueLabel.frame), 0, 132 * wScale, self.frame.size.height)];
    self.yearLabel.textColor = [UIColor hexString:@"#FF333333"];
    self.yearLabel.font = [UIFont systemFontOfSize:13.0];
    self.yearLabel.textAlignment = NSTextAlignmentRight;
    [self.bgImageView addSubview:self.yearLabel];
    
    self.threeYearLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.yearLabel.frame), 0, 132 * wScale, self.frame.size.height)];
    self.threeYearLabel.textColor = [UIColor hexString:@"#FF333333"];
    self.threeYearLabel.font = [UIFont systemFontOfSize:13.0];
    self.threeYearLabel.textAlignment = NSTextAlignmentRight;
    [self.bgImageView addSubview:self.threeYearLabel];
}
- (void)setIsSum:(BOOL)isSum
{
    _isSum = isSum;
    if (isSum) {
        self.bgImageView.image = [UIImage imageNamed:@"list_zongji"];
        self.yueLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
        self.yearLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
        self.threeYearLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    }else{
        self.bgImageView.image = [UIImage imageNamed:@"list_neirong"];
        
        self.yueLabel.textColor = [UIColor hexString:@"#FF999999"];
        self.yearLabel.textColor = [UIColor hexString:@"#FF333333"];
        self.threeYearLabel.textColor = [UIColor hexString:@"#FF333333"];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
