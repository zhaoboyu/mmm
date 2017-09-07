//
//  TipAlertPopView.m
//  CTTX
//
//  Created by 吕利峰 on 16/7/21.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "TipAlertPopView.h"
@interface TipAlertPopView ()
@property (nonatomic,assign)CGFloat cellHight;//标题高度
@property (nonatomic,strong)NSMutableArray *titleArr;
@property (nonatomic,strong)UIView *cellBackGroudView;
@property (nonatomic,copy)NSString *titleColor;
@property (nonatomic,assign)CGFloat celBackGroudHight;
@property (nonatomic,strong)UIView *tipView;
@property (nonatomic,strong)NSMutableArray *cellArr;
@end

@implementation TipAlertPopView

- (instancetype)initWithTitleArr:(NSMutableArray *)titleArr titleColor:(NSString *)titleColor
{
    //    NSInteger titleNum = [titleArr count];
    //    CGRect popFrame = CGRectMake(0, kHeight - (cellHight * titleNum), kWidth, cellHight * titleNum);
    CGRect popFrame = CGRectMake(0, 0, kWidth, kHeight);
    self = [super initWithFrame:popFrame];
    if (self) {
        self.backgroundColor = [UIColor hexString:@"#4D000000"];
        _cellHight = 56;
        _titleArr = titleArr;
        _titleColor = titleColor;
        [self p_setupView];
    }
    return self;
}
- (void)p_setupView
{
    self.cellArr = [NSMutableArray array];
    NSInteger titleNum = [self.titleArr count];
    CGFloat titleWithCancleHight = 15;
    CGFloat lineHight = 0.5;
    _celBackGroudHight = _cellHight * (titleNum + 1) + titleWithCancleHight + (lineHight * titleNum) + lineHight;
    self.cellBackGroudView = [[UIView alloc] init];
    self.cellBackGroudView.frame = CGRectMake(0, kHeight, kWidth, _celBackGroudHight);
    self.cellBackGroudView.backgroundColor = [UIColor hexString:@"#FFF5F2F2"];
    [self addSubview:self.cellBackGroudView];
    
    for (int i = 0; i < titleNum; i++) {
        NSString *title = self.titleArr[i];
        UIButton *cellButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        cellButton.frame = CGRectMake(0, _cellHight * i + lineHight * i, kWidth, _cellHight);
        cellButton.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
        cellButton.tag = 150 + i;
//        [cellButton setTitle:title forState:(UIControlStateNormal)];
//        [cellButton setTitleColor:[UIColor colorWithHexString:_titleColor] forState:(UIControlStateNormal)];
//        cellButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [cellButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.cellBackGroudView addSubview:cellButton];
        
        UILabel *cellTitleLabel = [[UILabel alloc]initWithFrame:cellButton.bounds];
        cellTitleLabel.text = title;
        cellTitleLabel.textColor = [UIColor hexString:_titleColor];
        cellTitleLabel.backgroundColor = [UIColor clearColor];
        cellTitleLabel.font = [UIFont systemFontOfSize:16.0];
        cellTitleLabel.textAlignment = NSTextAlignmentCenter;
        [cellButton addSubview:cellTitleLabel];
        [self.cellArr addObject:cellTitleLabel];
        
        UIImageView *lineImageView = [[UIImageView alloc]init];
        lineImageView.frame = CGRectMake(0, CGRectGetMaxY(cellButton.frame), kWidth, lineHight);
        lineImageView.image = [UIImage imageNamed:@"line_H_item"];
        [self.cellBackGroudView addSubview:lineImageView];
        
    }
    UIImageView *lineImageView = [[UIImageView alloc]init];
    lineImageView.frame = CGRectMake(0, _celBackGroudHight - _cellHight - lineHight , kWidth, lineHight);
    lineImageView.image = [UIImage imageNamed:@"line_H_item"];
    [self.cellBackGroudView addSubview:lineImageView];
    //取消按钮
    UIButton *cancleButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    cancleButton.frame = CGRectMake(0, CGRectGetMaxY(lineImageView.frame), kWidth, _cellHight);
    cancleButton.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
    [cancleButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancleButton setTitleColor:[UIColor hexString:@"#FF333333"] forState:(UIControlStateNormal)];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.cellBackGroudView addSubview:cancleButton];
    
}
- (void)cellButtonAction:(UIButton *)sender
{
    if (_delegate && ([_delegate respondsToSelector:@selector(actionButtonWithIndex:)])) {
        [_delegate actionButtonWithIndex:sender.tag - 150];
    }
    [self hidePopView];
}
- (void)cancleButtonAction:(UIButton *)sender
{
    [self hidePopView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidePopView];
}
//出现
- (void)showPopView
{
    [self addPopViewToWinder];
    [UIView animateWithDuration:0.2 animations:^{
        self.cellBackGroudView.frame = CGRectMake(0, kHeight - _celBackGroudHight, kWidth, _celBackGroudHight);
        if (_tipView) {
            self.tipView.frame = CGRectMake(0, CGRectGetMinY(self.cellBackGroudView.frame) - 0.5 - 36, kWidth, 36.5);
        }
    } completion:^(BOOL finished) {
        
    }];
}
//取消
- (void)hidePopView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.cellBackGroudView.frame = CGRectMake(0, kHeight, kWidth, _celBackGroudHight);
        if (_tipView) {
            self.tipView.frame = CGRectMake(0, CGRectGetMinY(self.cellBackGroudView.frame) - 0.5 - 36, kWidth, 36.5);
        }
    } completion:^(BOOL finished) {
        [self removePopViewFromWinder];
    }];
}
/**
 *  添加自定义视图
 *
 *  @param tipTitle 自定义视图
 */
- (void)setTipTitle:(NSString *)tipTitle
{
    UIView *tipView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(self.cellBackGroudView.frame) - 0.5 - 36, kWidth, 36.5)];
    tipView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
    [self addSubview:tipView];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(30 * wScale, 0, kWidth - 30 * wScale, CGRectGetHeight(tipView.frame))];
    tipLabel.text = tipTitle;
    tipLabel.textColor = [UIColor hexString:@"#FFA6A6A6"];
    tipLabel.font = [UIFont systemFontOfSize:13.0];
    tipLabel.backgroundColor = [UIColor clearColor];
    [tipView addSubview:tipLabel];
    
    UIImageView *lineImageView = [[UIImageView alloc]init];
    lineImageView.frame = CGRectMake(0, CGRectGetHeight(tipView.frame) - 0.5, kWidth, 0.5);
    lineImageView.image = [UIImage imageNamed:@"line_H_item"];
    [tipView addSubview:lineImageView];
    _tipView = tipView;
    
}
/**
 *  改变cell标题位置
 *
 *  @param frame cell标题位置
 */
- (void)setCellTitleLabelWithframe:(CGRect)frame
{
    
    for (UILabel *cellLabel in self.cellArr) {
        cellLabel.textAlignment = NSTextAlignmentLeft;
        cellLabel.frame = frame;
    }
}
@end
