//
//  LSFPDetailHeaderCollectionReusableView.m
//  YDJR
//
//  Created by 李爽 on 2016/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFPDetailHeaderCollectionReusableView.h"

@implementation LSFPDetailHeaderCollectionReusableView

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
    self.backgroundColor = [UIColor hexString:@"#FFF3F3F3"];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 24*hScale, self.width, 128*hScale)];
    bgView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
    [self addSubview:bgView];
    
    self.headerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 49 * hScale, bgView.width - 164*wScale, 30*hScale)];
    self.headerTitleLabel.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
    self.headerTitleLabel.font = [UIFont systemFontOfSize:15];
    self.headerTitleLabel.textColor = [UIColor hexString:@"#FF666666"];
    [bgView addSubview:self.headerTitleLabel];
    
    self.additionalBtn = [[UIButton alloc]initWithFrame:CGRectMake(bgView.width - 208*wScale, 32 * hScale, 176*wScale, 64*hScale)];
    self.additionalBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.additionalBtn setTitleColor:[UIColor hexString:@"#FFFFFFFF"]];
	[self.additionalBtn setBackgroundColor:[UIColor hexString:@"#FF333333"]];
    self.additionalBtn.hidden = YES;
    [bgView addSubview:self.additionalBtn];
    
	//UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(32*wScale, 86*hScale, 130*wScale, hScale)];
	//bottomLine.backgroundColor = [UIColor hexString:@"#666666"];
	//[bgView addSubview:bottomLine];
	
    UIView *cuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 127*hScale, kWidth, hScale)];
    cuttingLine.backgroundColor = [UIColor hex:@"#FFE3E3E3"];
    [bgView addSubview:cuttingLine];
}

@end
