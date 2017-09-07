//
//  ZBYBrandSelectTableViewCell.m
//  YDJR
//
//  Created by 赵博宇 on 2017/6/8.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "ZBYBrandSelectTableViewCell.h"



@interface ZBYBrandSelectTableViewCell ()
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *selectedImage;

@end
@implementation ZBYBrandSelectTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(29*wScale, 0, (480-29-64)*wScale, 100*wScale)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor hexString:@"#999999"];
    [self.contentView addSubview:_titleLabel];
    
    self.selectedImage = [[UIImageView alloc]initWithFrame:CGRectMake((480-61)*wScale, (100*wScale - 25*hScale)/2, 34*wScale, 25*hScale)];
    self.selectedImage.hidden  = YES;
    self.selectedImage.image = [UIImage imageNamed:@"brandSelected"];
    [self.contentView addSubview:_selectedImage];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(29*wScale, 100*wScale-1*wScale, (478-29)*wScale, 1*wScale)];
       line.backgroundColor = [UIColor hexString:@"#d9d9d9"];
       [self.contentView addSubview:line];
}
- (void)cell:(NSString *)title selected:(BOOL)selected{
    self.titleLabel.text = title;
    self.titleLabel.textColor=selected? [UIColor hexString:@"#333333"]:[UIColor hexString:@"#999999"];
    self.selectedImage.hidden  = selected?NO:YES;
}
@end
