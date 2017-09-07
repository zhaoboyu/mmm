//
//  LSMaterialShowCollectionViewCell.m
//  YDJR
//
//  Created by 李爽 on 2016/10/17.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSMaterialShowCollectionViewCell.h"

@implementation LSMaterialShowCollectionViewCell
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
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 0, self.width - 32*wScale, self.height)];
    self.nameLabel.font = [UIFont systemFontOfSize:17];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.textColor = [UIColor hexString:@"#FF666666"];
    [self addSubview:self.nameLabel];
}
@end
