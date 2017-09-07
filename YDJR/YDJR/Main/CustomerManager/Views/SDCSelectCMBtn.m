//
//  SDCSelectCMBtn.m
//  YDJR
//
//  Created by sundacheng on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDCSelectCMBtn.h"

#define ConnerLabelW 40/2
#define ConnerLabelH 26/2

#define CornerRadius 5

@implementation SDCSelectCMBtn
{
    UILabel *_connerNumLabel; //数字标签
    UILabel *_titleLabel; //标题
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = CornerRadius;
        [self createUI];
    }
    return self;
}

#pragma mark - UI
- (void)createUI {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 65, 12)];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.center = self.center;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    _connerNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ConnerLabelW, ConnerLabelH)];
    _connerNumLabel.center = CGPointMake(self.bounds.size.width, 0);
    _connerNumLabel.backgroundColor = [UIColor hex:@"#DB0D0D"];
    _connerNumLabel.font = [UIFont systemFontOfSize:10];
    _connerNumLabel.textColor = [UIColor whiteColor];
    _connerNumLabel.textAlignment = NSTextAlignmentCenter;
    _connerNumLabel.layer.masksToBounds = YES;
    _connerNumLabel.layer.cornerRadius = 6;
    [self addSubview:_connerNumLabel];
}

#pragma mark - getter and setter
- (void)setTitleName:(NSString *)titleName {
    _titleName = [titleName copy];
    _titleLabel.text = _titleName;
}

- (void)setNewsNum:(NSUInteger)newsNum {
    _newsNum = newsNum;
    _connerNumLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_newsNum];
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.backgroundColor = [UIColor hex:@"#66A6FF"];
        _titleLabel.textColor = [UIColor hex:@"#FFFFFF"];
    } else {
        _titleLabel.textColor = [UIColor hex:@"#373D49"];
        self.backgroundColor = [UIColor hex:@"#EBEBEB"];
    }
}

@end
