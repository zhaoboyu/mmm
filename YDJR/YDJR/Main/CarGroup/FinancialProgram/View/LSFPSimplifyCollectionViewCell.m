//
//  LSFPSimplifyCollectionViewCell.m
//  YDJR
//
//  Created by 李爽 on 16/10/6.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFPSimplifyCollectionViewCell.h"

@implementation LSFPSimplifyCollectionViewCell

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
    self.bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 472*wScale, 200*hScale)];
	self.bgView.userInteractionEnabled = YES;
	self.bgView.backgroundColor = [UIColor hexString:@"#99000000"];
	
	UIView *lightGrayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 472*wScale, 200*hScale)];
	lightGrayView.backgroundColor = [UIColor hexString:@"#99000000"];
	[self.bgView addSubview:lightGrayView];
	//self.bgView.layer.masksToBounds = YES;
	//self.bgView.layer.cornerRadius = 4;
	//self.bgView.layer.borderWidth = 1.0f;
	//self.bgView.layer.borderColor = [UIColor hexString:@"#FFCCCCCC"].CGColor;
	
    self.programTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 0, self.bgView.frame.size.width - 88*wScale, self.bgView.frame.size.height)];
    self.programTitleLabel.numberOfLines = 0;
    self.programTitleLabel.font = [UIFont systemFontOfSize:17];
    self.programTitleLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.bgView.width - 46*wScale, 89*hScale, 16*wScale, 28*hScale)];
    arrowImageView.image = [UIImage imageNamed:@"icon_normal_arrow"];
    [self.bgView addSubview:arrowImageView];
    
    [self.bgView addSubview:self.programTitleLabel];
    [self addSubview:self.bgView];
}

@end
