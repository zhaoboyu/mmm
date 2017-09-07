//
//  MessageCell.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/10/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}


-(void)setupView{
    //self.backgroundColor=[UIColor yellowColor];
    
    self.titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(20*wScale, 20*wScale, 200, 30*wScale)];
    self.titleLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:_titleLabel];

    self.contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(86*wScale, 76*wScale, kWidth-100*wScale, 30*wScale)];
    self.contentLabel.textAlignment=NSTextAlignmentLeft;
    self.contentLabel.numberOfLines=0;
    [self addSubview:_contentLabel];
    
    
    UIView* line=[[UIView alloc] initWithFrame:CGRectMake(0, 200 * hScale-1, kWidth, 1)];
    line.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:line];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
