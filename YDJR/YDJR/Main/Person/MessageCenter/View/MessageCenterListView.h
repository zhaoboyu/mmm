//
//  MessageCenterListView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
@protocol MessageCenterListViewDelegate <NSObject>

@optional
- (void)clickCellWithMessageModel:(MessageModel *)messageModel type:(NSInteger)messagetype;

@end


@interface MessageCenterListView : UIView


@property (nonatomic,weak)id<MessageCenterListViewDelegate> delegate;


/**
 切换消息分类
 */
- (void)changeMessageTypeWithMessageType:(MESSAGETYPE)messageType;
@end
