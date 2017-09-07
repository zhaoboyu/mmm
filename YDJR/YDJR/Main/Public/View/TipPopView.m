//
//  TipPopView.m
//  CTTX
//
//  Created by 吕利峰 on 16/5/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "TipPopView.h"

@implementation TipPopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hexString:@"#4D000000"];
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.tipImageView = [[UIImageView alloc]init];
    self.tipImageView.frame = CGRectMake(89 * wScale, 378 * hScale, 572 * wScale, 572 * wScale * (378 / 572.0));
    [self addSubview:self.tipImageView];
    
    self.closeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.closeButton.frame = CGRectMake(331 * wScale, kHeight -184 * hScale, 88 * wScale, 88 * wScale);
    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"icon_normal_close_china jidongcheliangxingshizheng"] forState:(UIControlStateNormal)];
    [self.closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.closeButton];
                                         
}
- (void)closeButtonAction:(UIButton *)sender
{
    [self removePopViewFromWinder];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"取消");
    [self removePopViewFromWinder];
}
@end
