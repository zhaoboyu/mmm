//
//  MessageCenterDetail.h
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoBackAction <NSObject>

- (void)goBack;

@end

@class MessageModel;
@interface MessageCenterDetail : UIView
@property (nonatomic,strong)MessageModel *messageModel;
@property(nonatomic,strong)NSString *messageType;
@property(nonatomic,weak)id<GoBackAction>backDelegate;
@end
