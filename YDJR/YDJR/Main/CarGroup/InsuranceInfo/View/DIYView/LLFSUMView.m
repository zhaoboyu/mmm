//
//  LLFSUMView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/11.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFSUMView.h"

@interface LLFSUMView ()
@property (nonatomic,weak)id<LLFSUMViewDelegate>delegate;
@property (nonatomic,strong)UILabel *sumTitleLabel;

@property (nonatomic,copy)NSString *sumTitle;
@property (nonatomic,assign)float souce;
@property (nonatomic,assign)BOOL isSum;
@property (nonatomic,assign)float lestValue;
@end

@implementation LLFSUMView
+ (instancetype)initWithFrame:(CGRect)frame sumTitle:(NSString *)sumTitle souce:(float)souce delegate:(id<LLFSUMViewDelegate>)delegate isSum:(BOOL)isSum lestValue:(float)lestValue
{
    return [[LLFSUMView alloc] initWithFrame:frame sumTitle:sumTitle souce:souce delegate:delegate isSum:isSum lestValue:lestValue];
}
- (instancetype)initWithFrame:(CGRect)frame sumTitle:(NSString *)sumTitle souce:(float)souce delegate:(id<LLFSUMViewDelegate>)delegate isSum:(BOOL)isSum lestValue:(float)lestValue
{
    if (self = [super initWithFrame:frame]) {
        self.sumTitle = sumTitle;
        self.souce = souce;
        self.delegate = delegate;
        self.isSum = isSum;
        self.lestValue = lestValue;
        [self setupView];
    }
    return self;
}
- (void)setupView
{
    
    if (self.isSum) {
        self.sumTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 48 * hScale, self.frame.size.width - 32 * wScale, 24 * hScale)];
        self.sumTitleLabel.text = self.sumTitle;
        self.sumTitleLabel.textColor = [UIColor hexString:@"#FF999999"];
        self.sumTitleLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.sumTitleLabel];
        
        UIButton *leftButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        leftButton.frame = CGRectMake(CGRectGetMinX(self.sumTitleLabel.frame), CGRectGetMaxY(self.sumTitleLabel.frame) + 24 * hScale, 44 * wScale, 44 * hScale);
        [leftButton setBackgroundImage:[UIImage imageNamed:@"LLF_InsuranceInfo_icon_normal_jianshao"] forState:(UIControlStateNormal)];
        [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:leftButton];
        
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftButton.frame), CGRectGetMinY(leftButton.frame), 95 * wScale, 44 * hScale)];
//        bgImageView.image = [UIImage imageNamed:@"field_pingjunnianpengzhuangcishu"];
        [self addSubview:bgImageView];
        
        self.souceLabel = [[UILabel alloc]initWithFrame:bgImageView.bounds];
        self.souceLabel.text = [NSString stringWithFormat:@"%.0f",self.souce];
        self.souceLabel.textColor = [UIColor hexString:@"#FF333333"];
        self.souceLabel.font = [UIFont systemFontOfSize:18.0];
        self.souceLabel.textAlignment = NSTextAlignmentCenter;
        [bgImageView addSubview:self.souceLabel];
        
        UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        rightButton.frame = CGRectMake(CGRectGetMaxX(bgImageView.frame), CGRectGetMinY(leftButton.frame), CGRectGetWidth(leftButton.frame), CGRectGetHeight(leftButton.frame));
        [rightButton setBackgroundImage:[UIImage imageNamed:@"LLF_InsuranceInfo_icon_normal_zengjia"] forState:(UIControlStateNormal)];
        [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:rightButton];
        
    }else{
        self.sumTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 48 * hScale, self.frame.size.width, 24 * hScale)];
        self.sumTitleLabel.text = self.sumTitle;
        self.sumTitleLabel.textColor = [UIColor hexString:@"#FF999999"];
        self.sumTitleLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.sumTitleLabel];
        
        self.souceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.sumTitleLabel.frame), CGRectGetMaxY(self.sumTitleLabel.frame) + 24 * hScale, self.frame.size.width, 44 * hScale)];
        NSString *souceStr = [[NSString stringWithFormat:@"%.2f",self.souce] cut];
        self.souceLabel.text = souceStr;
        self.souceLabel.textColor = [UIColor hexString:@"#FF333333"];
        self.souceLabel.font = [UIFont systemFontOfSize:20.0];
        [self addSubview:self.souceLabel];
    }
}
- (void)leftButtonAction:(UIButton *)sender
{
    if (self.souce > self.lestValue) {
        self.souce -=1;
        self.souceLabel.text = [NSString stringWithFormat:@"%.0f",self.souce];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(sendSouceButtonstate:view:)]) {
        [_delegate sendSouceButtonstate:self.souce view:self];
    }
    
}
- (void)rightButtonAction:(UIButton *)sender
{
    self.souce +=1;
    self.souceLabel.text = [NSString stringWithFormat:@"%.0f",self.souce];
    if (_delegate && [_delegate respondsToSelector:@selector(sendSouceButtonstate:view:)]) {
        [_delegate sendSouceButtonstate:self.souce view:self];
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
