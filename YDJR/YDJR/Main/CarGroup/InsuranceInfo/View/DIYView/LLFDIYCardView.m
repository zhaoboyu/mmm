//
//  LLFDIYCardView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/11.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFDIYCardView.h"
@interface LLFDIYCardView ()
@property (nonatomic,weak)id<LLFDIYCardViewDelegate>delegate;
@property (nonatomic,strong)UILabel *sumTitleLabel;
@property (nonatomic,strong)UILabel *allMoneyLabel;
@property (nonatomic,strong)UILabel *myMoneyLabel;
@property (nonatomic,copy)NSString *sumTitle;
@end
@implementation LLFDIYCardView
+ (instancetype)initWithFrame:(CGRect)frame sumTitle:(NSString *)sumTitle allMoney:(float)allMoney  myMoney:(float)myMoney delegate:(id<LLFDIYCardViewDelegate>)delegate
{
    return [[LLFDIYCardView alloc] initWithFrame:frame sumTitle:sumTitle allMoney:allMoney myMoney:myMoney delegate:delegate];
}
- (instancetype)initWithFrame:(CGRect)frame sumTitle:(NSString *)sumTitle allMoney:(float)allMoney  myMoney:(float)myMoney delegate:(id<LLFDIYCardViewDelegate>)delegate
{
    if (self = [super initWithFrame:frame]) {
        self.sumTitle = sumTitle;
        _allMoney = allMoney;
        self.delegate = delegate;
        _myMoney = myMoney;
        [self setupView];
    }
    return self;
}
- (void)setupView
{
    self.backgroundColor = [UIColor hexString:@"#F5F5F5"];
    
    self.bgImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:self.bgImageView];
    
    self.sumTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 36 * hScale, self.frame.size.width - 32 * wScale, 34 * hScale)];
    self.sumTitleLabel.text = self.sumTitle;
    self.sumTitleLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    self.sumTitleLabel.font = [UIFont systemFontOfSize:17.0];
    [self addSubview:self.sumTitleLabel];
    
    UILabel *allMoneyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.sumTitleLabel.frame), CGRectGetMaxY(self.sumTitleLabel.frame) + 36 * hScale, CGRectGetWidth(self.sumTitleLabel.frame), 24 * hScale)];
    allMoneyTitleLabel.text = @"总花费(元)";
    allMoneyTitleLabel.textColor = [UIColor hexString:@"#A6FFFFFF"];
    allMoneyTitleLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:allMoneyTitleLabel];
    
    self.allMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.sumTitleLabel.frame), CGRectGetMaxY(allMoneyTitleLabel.frame) + 6 * hScale, CGRectGetWidth(self.sumTitleLabel.frame), 34 * hScale)];
    self.allMoneyLabel.text = [[NSString stringWithFormat:@"%.2f",self.allMoney] cut];
    self.allMoneyLabel.textColor = [UIColor hexString:@"#A6FFFFFF"];
    self.allMoneyLabel.font = [UIFont systemFontOfSize:17.0];
    [self addSubview:self.allMoneyLabel];
    
    UILabel *myMoneyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.sumTitleLabel.frame), CGRectGetMaxY(self.allMoneyLabel.frame) + 24 * hScale, CGRectGetWidth(self.sumTitleLabel.frame), 24 * hScale)];
    myMoneyTitleLabel.text = @"自付修理费用(元)";
    myMoneyTitleLabel.textColor = [UIColor hexString:@"#A6FFFFFF"];
    myMoneyTitleLabel.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:myMoneyTitleLabel];
    
    self.myMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.sumTitleLabel.frame), CGRectGetMaxY(myMoneyTitleLabel.frame) + 6 * hScale, CGRectGetWidth(self.sumTitleLabel.frame), 34 * hScale)];
    self.myMoneyLabel.text = [[NSString stringWithFormat:@"%.2f",self.myMoney] cut];
    self.myMoneyLabel.textColor = [UIColor hexString:@"#A6FFFFFF"];
    self.myMoneyLabel.font = [UIFont systemFontOfSize:17.0];
    [self addSubview:self.myMoneyLabel];
}
- (void)setAllMoney:(float)allMoney
{
    _allMoney = allMoney;
    self.allMoneyLabel.text = [[NSString stringWithFormat:@"%.2f",_allMoney] cut];
}
- (void)setMyMoney:(float)myMoney
{
    _myMoney = myMoney;
    self.myMoneyLabel.text = [[NSString stringWithFormat:@"%.2f",_myMoney] cut];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
