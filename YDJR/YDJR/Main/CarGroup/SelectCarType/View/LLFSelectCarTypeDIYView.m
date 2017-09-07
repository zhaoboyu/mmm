//
//  LLFSelectCarTypeDIYView.m
//  YDJR
//
//  Created by 吕利峰 on 16/12/1.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFSelectCarTypeDIYView.h"

@interface LLFSelectCarTypeDIYView ()
@property (nonatomic,strong)UILabel *leftTitleLabel;//进口
@property (nonatomic,strong)UIView *leftLineView;

@property (nonatomic,strong)UILabel *rightTitleLabel;//国产
@property (nonatomic,strong)UIView *rightLineView;

@end

@implementation LLFSelectCarTypeDIYView

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
    self.leftTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (self.frame.size.width - 1) / 2, self.frame.size.height - 0.5)];
    self.leftTitleLabel.text = @"进口";
    self.leftTitleLabel.textColor = [UIColor hex:@"#FFFC5A5A"];
    self.leftTitleLabel.font = [UIFont systemFontOfSize:13.0];
    self.leftTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.leftTitleLabel.userInteractionEnabled = YES;
    [self addSubview:self.leftTitleLabel];
    
    CGFloat lineWidth = [Tool widthForString:self.leftTitleLabel.text fontSize:13.0 andHight:24 * hScale];
    self.leftLineView = [[UIView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.leftTitleLabel.frame) - lineWidth) / 2, CGRectGetHeight(self.leftTitleLabel.frame) - 24 * hScale, lineWidth, 2 * hScale)];
    self.leftLineView.backgroundColor = [UIColor hex:@"#FFFC5A5A"];
    [self.leftTitleLabel addSubview:self.leftLineView];
    
    UIButton *leftButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    leftButton.frame = self.leftTitleLabel.bounds;
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftTitleLabel addSubview:leftButton];
    
    UIView *midLineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftTitleLabel.frame), self.frame.size.height / 2 - 15 * hScale, 2 * wScale, 30 * hScale)];
    midLineView.backgroundColor = [UIColor hex:@"#FFD5D6D9"];
    [self addSubview:midLineView];
    
    
    self.rightTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midLineView.frame), 0, CGRectGetWidth(self.leftTitleLabel.frame), CGRectGetHeight(self.leftTitleLabel.frame))];
    self.rightTitleLabel.text = @"国产";
    self.rightTitleLabel.textColor = [UIColor hex:@"#FF666666"];
    self.rightTitleLabel.font = [UIFont systemFontOfSize:13.0];
    self.rightTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.rightTitleLabel.userInteractionEnabled = YES;
    [self addSubview:self.rightTitleLabel];
    
    self.rightLineView = [[UIView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.rightTitleLabel.frame) - lineWidth) / 2, CGRectGetHeight(self.rightTitleLabel.frame) - 24 * hScale, lineWidth, 2 * hScale)];
    self.rightLineView.backgroundColor = [UIColor hex:@"#FFFC5A5A"];
    self.rightLineView.hidden = YES;
    [self.rightTitleLabel addSubview:self.rightLineView];
    
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    rightButton.frame = self.rightTitleLabel.bounds;
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightTitleLabel addSubview:rightButton];
    
    UIView *bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.5)];
    bottomLineView.backgroundColor = LLFColorline();
    [self addSubview:bottomLineView];
}

/**
 进口
 */
- (void)leftButtonAction:(UIButton *)sender
{
    self.leftTitleLabel.textColor = [UIColor hex:@"#FFFC5A5A"];
    self.leftLineView.backgroundColor = [UIColor hex:@"#FFFC5A5A"];
    self.leftLineView.hidden = NO;
    self.rightTitleLabel.textColor = [UIColor hex:@"#FF666666"];
    self.rightLineView.hidden = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(selectIndexWithCarType:)]) {
        [self.delegate selectIndexWithCarType:@"1"];
    }
}
/**
 国产
 */
- (void)rightButtonAction:(UIButton *)sender
{
    self.leftTitleLabel.textColor = [UIColor hex:@"#FF666666"];
    self.leftLineView.hidden = YES;
    self.rightTitleLabel.textColor = [UIColor hex:@"#FFFC5A5A"];
    self.rightLineView.backgroundColor = [UIColor hex:@"#FFFC5A5A"];
    self.rightLineView.hidden = NO;
    if (_delegate && [_delegate respondsToSelector:@selector(selectIndexWithCarType:)]) {
        [self.delegate selectIndexWithCarType:@"0"];
    }
}
@end
