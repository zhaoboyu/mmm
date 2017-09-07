//
//  LSFPDetailCollectionViewCell.m
//  YDJR
//
//  Created by 李爽 on 2016/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFPDetailCollectionViewCell.h"
#import "LSTextField.h"

@interface LSFPDetailCollectionViewCell ()
@property (nonatomic,assign,getter=isOpen) BOOL  open;
@end
@implementation LSFPDetailCollectionViewCell

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
    self.conditionTilteLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 32*hScale, self.width - 32*wScale, 24*hScale)];
    self.conditionTilteLabel.text = @"车辆颜色";
    self.conditionTilteLabel.font = [UIFont systemFontOfSize:12];
    self.conditionTilteLabel.textColor = [UIColor hexString:@"#FF999999"];
    [self addSubview:self.conditionTilteLabel];

    self.conditionTextField = [[LSTextField alloc]initWithFrame:CGRectMake(32*wScale, CGRectGetMaxY(self.conditionTilteLabel.frame) + 12*hScale, self.width - 80*wScale, 64*hScale)];
    self.conditionTextField.font = [UIFont systemFontOfSize:14];
    self.conditionTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.conditionTextField.backgroundColor = [UIColor hexString:@"#FFF2F3F7"];
    [self addSubview:self.conditionTextField];
	
	self.conditionButton = [[UIButton alloc]initWithFrame:CGRectMake(32*wScale, CGRectGetMaxY(self.conditionTilteLabel.frame) + 12*hScale, self.width - 80*wScale, 64*hScale)];
	self.conditionButton.titleLabel.font = [UIFont systemFontOfSize:14];
	[self.conditionButton setTitleColor:[UIColor blackColor]];
	self.conditionButton.backgroundColor = [UIColor hexString:@"#FFF2F3F7"];
	self.conditionButton.titleEdgeInsets = UIEdgeInsetsMake(0, -176*wScale, 0, 0);
	self.conditionButton.layer.masksToBounds = YES;
	self.conditionButton.layer.cornerRadius = 4;
	self.conditionButton.layer.borderWidth = 1.0f;
	self.conditionButton.layer.borderColor = [UIColor hexString:@"#FFCCCCCC"].CGColor;
	[self.conditionButton setImage:[UIImage imageNamed:@"icon_normal_xuanze"] forState:UIControlStateNormal];
	self.conditionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 220*wScale, 0, 0);
	self.conditionButton.imageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
	self.conditionButton.hidden = YES;
	[self addSubview:self.conditionButton];
	
    self.moneyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, CGRectGetMaxY(self.conditionTextField.frame) + 28*hScale, self.width - 32*wScale, 24*hScale)];
    self.moneyTitleLabel.font = [UIFont systemFontOfSize:12];
    self.moneyTitleLabel.textColor = [UIColor hexString:@"#FF999999"];
    [self addSubview:self.moneyTitleLabel];
    
    self.moneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, CGRectGetMaxY(self.moneyTitleLabel.frame) + 24*hScale, self.width - 80*wScale, 40*hScale)];
    self.moneyLabel.font = [UIFont systemFontOfSize:20];
    self.moneyLabel.textColor = [UIColor hexString:@"#FF333333"];
    [self addSubview:self.moneyLabel];
    
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
