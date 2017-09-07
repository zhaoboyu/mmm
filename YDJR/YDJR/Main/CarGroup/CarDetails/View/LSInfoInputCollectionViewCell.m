//
//  LSInfoInputCollectionViewCell.m
//  YDJR
//
//  Created by 李爽 on 2016/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSInfoInputCollectionViewCell.h"
#import "LSTextField.h"
@interface LSInfoInputCollectionViewCell ()
@end
@implementation LSInfoInputCollectionViewCell
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
        
    self.contentTextField = [[LSTextField alloc]initWithFrame:CGRectMake(32*wScale, 66*hScale, 420*wScale, 54*hScale)];
    self.contentTextField.font = [UIFont systemFontOfSize:17];
    //self.contentTextField.backgroundColor = [UIColor hexString:@"#F2F3F7"];
    self.contentTextField.placeholder = @"请输入";
    [self addSubview:self.contentTextField];
    
	UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(32*wScale, 129 * hScale, 522 * wScale, hScale)];
	bottomView.backgroundColor = [UIColor hexString:@"#FFD9D9D9"];
	[self addSubview:bottomView];
}

@end
