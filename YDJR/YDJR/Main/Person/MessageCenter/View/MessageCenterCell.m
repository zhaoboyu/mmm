//
//  MessageCenterCell.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "MessageCenterCell.h"
#import "MessageModel.h"
@implementation MessageCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.clipsToBounds = YES;
        [self  setupView];
    }
    return self;
}

-(void)setupView{
    //消息未读标记
    self.notReadImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WPQtag_message"]];
    self.notReadImageView.frame = CGRectMake(32 * wScale, 56 * hScale, 18 * wScale, 18 * hScale);
    [self.contentView addSubview:self.notReadImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.frame = CGRectMake(12 * wScale + CGRectGetMaxX(self.notReadImageView.frame), 48 * hScale, CGRectGetWidth(self.contentView.frame) - 62 * wScale, 34 * hScale);
    self.titleLabel.textColor = [UIColor hex:@"#FF333333"];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.titleLabel];
    
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), 24 * hScale + CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.titleLabel.frame), 30 * hScale);
    self.contentLabel.textColor = [UIColor hex:@"#FF999999"];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.contentLabel];
    
    self.messageTimeLabel = [[UILabel alloc]init];
    self.messageTimeLabel.frame = CGRectMake(0,48 * hScale , self.contentView.frame.size.width-32*hScale, 30 * hScale);
    self.messageTimeLabel.textAlignment = NSTextAlignmentRight;
    self.messageTimeLabel.textColor = [UIColor hex:@"#FF999999"];
    
    self.messageTimeLabel.font = [UIFont systemFontOfSize:11.0];
    [self.contentView addSubview:self.messageTimeLabel];
    
    self.bottomLineImageView=[[UIImageView alloc] init];
    self.bottomLineImageView.frame = CGRectMake(32 * wScale, CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame) - 32 * wScale, 1 * hScale);
    self.bottomLineImageView.backgroundColor=[UIColor hex:@"#FFD9D9D9"];
//    lineView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:self.bottomLineImageView];
    
}

- (void)layoutSubviews
{
    self.notReadImageView.frame = CGRectMake(32 * wScale, 56 * hScale, 18 * wScale, 18 * hScale);
    self.titleLabel.frame = CGRectMake(12 * wScale + CGRectGetMaxX(self.notReadImageView.frame), 48 * hScale, CGRectGetWidth(self.contentView.frame) - 62 * wScale, 34 * hScale);
    self.contentLabel.frame = CGRectMake(CGRectGetMinX(self.titleLabel.frame), 24 * hScale + CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.titleLabel.frame), 30 * hScale);
    self.messageTimeLabel.frame = CGRectMake(0,48 * hScale , self.contentView.frame.size.width-32*hScale, 30 * hScale);
    self.bottomLineImageView.frame = CGRectMake(32 * wScale, CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame) - 32 * wScale, 1 * hScale);
}

- (void)setMessageModel:(MessageModel *)messageModel
{
    if (messageModel) {
        _messageModel = messageModel;
        //是否显示新消息标示
        if (_messageModel.isRead) {
            self.notReadImageView.hidden = YES;
        }else{
            self.notReadImageView.hidden = NO;
        }
        
        //消息标题赋值
        self.titleLabel.text = _messageModel.title;
        //消息内容赋值
        self.contentLabel.text = _messageModel.message;
        //发送消息时间
        self.messageTimeLabel.text = _messageModel.receiveTime;
    }
}

@end
