//
//  SDCCustomInfoBox.m
//  YDJR
//
//  Created by sundacheng on 16/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDCCustomInfoBox.h"
#import "SDCCustomerContactModel.h"

@implementation SDCCustomInfoBox

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initUI];
    }
    return self;
}
#pragma mark - ui
- (void)initUI {
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    [self addSubview:buttomLine];
    buttomLine.backgroundColor = [UIColor hex:@"#D9D9D9"];
    
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(self.width - 0.5, 0, 0.5, self.height)];
    [self addSubview:rightLine];
    rightLine.backgroundColor = [UIColor hex:@"#D9D9D9"];
    
    self.userInteractionEnabled = YES;
    
    //标题
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [self addSubview:_titleLb];
    _titleLb.left = 16;
    _titleLb.centerY = 30;
    _titleLb.textColor = [UIColor hex:@"#999999"];
    _titleLb.font = [UIFont systemFontOfSize:12];
    
    
    //输入框
    _inputLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width - 20, self.height - CGRectGetMaxY(_titleLb.frame))];
    _inputLabel.numberOfLines = 0;
//    _inputLabel.backgroundColor = [UIColor redColor];
    _inputLabel.userInteractionEnabled = YES;
    [self addSubview:_inputLabel];
    _inputLabel.left = 16;
    _inputLabel.top = CGRectGetMaxY(_titleLb.frame);
}

@end
