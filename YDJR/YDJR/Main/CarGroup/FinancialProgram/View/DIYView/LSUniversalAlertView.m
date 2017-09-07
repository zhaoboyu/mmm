//
//  LSUniversalAlertView.m
//  YDJR
//
//  Created by 李爽 on 2016/11/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSUniversalAlertView.h"

@implementation LSUniversalAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //backGroundView.layer.masksToBounds = YES;
    //backGroundView.layer.cornerRadius = 4.0f;
    backGroundView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
    self.backGroundView = backGroundView;
    
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 214*wScale, 98*hScale)];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:16];
	closeButton.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    [closeButton setTitleColor:[UIColor hexString:@"#FF666666"] forState:UIControlStateNormal];
    self.closeButton = closeButton;
    [backGroundView addSubview:closeButton];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 140*wScale, 31*hScale, 280*wScale, 36*hScale)];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor hexString:@"#FF333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel = titleLabel;
    [backGroundView addSubview:titleLabel];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(backGroundView.frame.size.width - 238*wScale, 0, 214*wScale, 98*hScale)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton setTitleColor:[UIColor hex:@"#FF333333"] forState:UIControlStateNormal];
    self.rightButton = rightButton;
    [backGroundView addSubview:rightButton];
    
    UIView *cuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 97*hScale, self.width, hScale)];
    cuttingLine.backgroundColor = [UIColor hexString:@"#FFD9D9D9"];
    self.cuttingLine = cuttingLine;
    [backGroundView addSubview:cuttingLine];
    [self addSubview:backGroundView];
}

@end
