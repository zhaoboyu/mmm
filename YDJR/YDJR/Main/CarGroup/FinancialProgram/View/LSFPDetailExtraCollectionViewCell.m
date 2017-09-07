//
//  LSFPDetailExtraCollectionViewCell.m
//  YDJR
//
//  Created by 李爽 on 2016/10/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFPDetailExtraCollectionViewCell.h"
#import "LSTextField.h"
@implementation LSFPDetailExtraCollectionViewCell
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
    self.moneyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 96*hScale, self.width - 32*wScale, 24*hScale)];
    self.moneyTitleLabel.font = [UIFont systemFontOfSize:12];
    self.moneyTitleLabel.textColor = [UIColor hexString:@"#FF999999"];
    [self addSubview:self.moneyTitleLabel];
    
    self.moneyTextField = [[LSTextField alloc]initWithFrame:CGRectMake(32*wScale, CGRectGetMaxY(self.moneyTitleLabel.frame) + 24*hScale, self.width - 80*wScale, 64*hScale)];
    self.moneyTextField.font = [UIFont systemFontOfSize:14];
    self.moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.moneyTextField.backgroundColor = [UIColor hexString:@"#FFF2F3F7"];
    [self addSubview:self.moneyTextField];
    
    //top right bottom line
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, hScale)];
    topView.backgroundColor = [UIColor hexString:@"#FFE3E3E3"];
    [self addSubview:topView];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(self.width - wScale, 0, wScale, self.height)];
    rightView.backgroundColor = [UIColor hexString:@"#FFE3E3E3"];
    [self addSubview:rightView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - hScale, self.width, hScale)];
    bottomView.backgroundColor = [UIColor hexString:@"#FFE3E3E3"];
    [self addSubview:bottomView];
}

@end
