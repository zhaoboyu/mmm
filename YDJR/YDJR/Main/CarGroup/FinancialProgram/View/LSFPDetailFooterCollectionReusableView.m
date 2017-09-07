//
//  LSFPDetailFooterCollectionReusableView.m
//  YDJR
//
//  Created by 李爽 on 2016/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFPDetailFooterCollectionReusableView.h"

@implementation LSFPDetailFooterCollectionReusableView

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
    self.footerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 32*hScale, self.width - 32*wScale, 24*hScale)];
    self.footerTitleLabel.text = @"表面总支出(元)";
    self.footerTitleLabel.font = [UIFont systemFontOfSize:12];
    self.footerTitleLabel.textColor = [UIColor hexString:@"#FF999999"];
    [self addSubview:self.footerTitleLabel];
    
    self.footerValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, CGRectGetMaxY(self.footerTitleLabel.frame) + 24*hScale, self.width - 32*wScale, 40*hScale)];
    self.footerValueLabel.font = [UIFont systemFontOfSize:20];
    self.footerValueLabel.textColor = [UIColor hexString:@"#FFFC5A5A"];
    [self addSubview:self.footerValueLabel];
}

@end
