//
//  LSInfoInputPopCollectionViewCell.m
//  YDJR
//
//  Created by 李爽 on 2016/10/17.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSInfoInputPopCollectionViewCell.h"

@implementation LSInfoInputPopCollectionViewCell
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
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 24 * hScale, 420*wScale, 24*hScale)];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    self.nameLabel.textColor = [UIColor hexString:@"#FF999999"];
    [self addSubview:self.nameLabel];
    
    self.chooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(32*wScale, 66*hScale, 420*wScale, 54*hScale)];
    self.chooseBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.chooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.chooseBtn.titleEdgeInsets = UIEdgeInsetsMake(0, - 25 * wScale, 0, 0);
    [self.chooseBtn setTitleColor:[UIColor hexString:@"#FF999999"] forState:UIControlStateNormal];
    //[self.chooseBtn setTitleColor:[UIColor hexString:@"#FF333333"] forState:UIControlStateSelected];
    [self.chooseBtn setImage:[UIImage imageNamed:@"icon_normal_xiala"] forState:UIControlStateNormal];
    self.chooseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 516 *wScale, 0, - 66 * wScale);
    [self addSubview:self.chooseBtn];

	UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(32*wScale, 129 * hScale, 522 * wScale, hScale)];
	bottomView.backgroundColor = [UIColor hexString:@"#FFD9D9D9"];
	[self addSubview:bottomView];
}

@end
