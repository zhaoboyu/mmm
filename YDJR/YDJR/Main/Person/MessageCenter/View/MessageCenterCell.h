//
//  MessageCenterCell.h
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;
@interface MessageCenterCell : UITableViewCell
@property (nonatomic,strong)UIImageView *notReadImageView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *contentLabel;
@property (nonatomic,strong)UILabel *messageTimeLabel;
@property (nonatomic,strong)UIImageView *bottomLineImageView;
@property (nonatomic,strong)MessageModel *messageModel;
@end
