//
//  DIYAttributedLabel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/3/14.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "DIYAttributedLabel.h"

@interface DIYAttributedLabel ()
@property (nonatomic,strong)UIButton *attributedButton;
@end

@implementation DIYAttributedLabel
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
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    
    self.attributedButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.attributedButton addTarget:self action:@selector(attributedButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.attributedButton];
    
    
}

/**
 设置显示文本

 @param text 标题
 @param index 颜色分割索引
 @param firstColor 标题颜色
 @param secondColor 功能标题颜色
 */
- (void)setText:(NSString *)text index:(NSUInteger)index firstColor:(NSString *)firstColor secondColor:(NSString *)secondColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor hex:firstColor] range:NSMakeRange(0,index)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor hex:secondColor] range:NSMakeRange(index,text.length - index)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, index)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(index, text.length - index)];
    self.attributedText = str;
    NSString *titleStr = [text substringToIndex:index];
    CGFloat titleStrW = [Tool widthForString:titleStr fontSize:13.0 andHight:self.frame.size.height];
    self.attributedButton.frame = CGRectMake(titleStrW, 0, self.frame.size.width - titleStrW, self.frame.size.height);

    
}
/**
 富文本点击响应事件

 @param sender 响应控件
 */
- (void)attributedButtonAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickAttributedLabel)]) {
        [_delegate clickAttributedLabel];
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
