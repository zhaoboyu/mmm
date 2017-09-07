//
//  LLFWorkBenchLeftItemView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/5/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFWorkBenchLeftItemView.h"
#import "DetailListCellPopView.h"
@interface LLFWorkBenchLeftItemView ()<DetailListCellPopViewDelegate>
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *selectImageView;
@end

@implementation LLFWorkBenchLeftItemView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArr = [NSMutableArray array];
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor hex:@"#FFFFFFFF"];
    self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:self.titleLabel];
    
    self.selectImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LLF_WorkBend"]];
    self.selectImageView.userInteractionEnabled = YES;
//    self.selectImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.selectImageView];
    
    UIButton *actionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    actionButton.frame = self.bounds;
    [actionButton addTarget:self action:@selector(actionButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:actionButton];
    
    
}
- (void)setTitleArr:(NSMutableArray *)titleArr
{
    if (titleArr && titleArr.count > 0) {
        [_titleArr removeAllObjects];
        for (NSDictionary *dic in titleArr) {
            [_titleArr addObject:[dic objectForKey:@"mechanismName"]];
        }
        NSString *titleStr = [Tool getMechanismName];
        [self setTitleTextStr:titleStr];
        
    }
}
- (void)actionButton:(UIButton *)sender
{
    CGRect originInSuperview = [self.window convertRect:sender.bounds fromView:sender];
    DetailListCellPopView *detailListCellPopView = [[DetailListCellPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds] ListFrame:originInSuperview listArr:self.titleArr isOtherTitle:NO];
    detailListCellPopView.delegate = self;
    [detailListCellPopView showPopView];
}
- (void)sendMessageWithMessage:(NSString *)messge
{
    [self setTitleTextStr:messge];
    for (int i = 0; i < _titleArr.count; i++) {
        if ([messge isEqualToString:_titleArr[i]]) {
            //机构
            [Tool saveMechinsIdWithIndex:i];
            if (_delegate && [_delegate respondsToSelector:@selector(selectMechanismName:)]) {
                [_delegate selectMechanismName:messge];
            }

            break;
        }
    }
    
}
- (void)setTitleTextStr:(NSString *)textStr
{
    self.titleLabel.text = textStr;
    CGFloat titleW = [Tool widthForString:textStr fontSize:15.0 andHight:self.frame.size.height];
    self.titleLabel.frame = CGRectMake(0, 0, titleW, self.frame.size.height);
    //        self.titleLabel.backgroundColor = [UIColor redColor];
    
    self.selectImageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10 * wScale, 39 * hScale, 24 * wScale, 14 * hScale);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
