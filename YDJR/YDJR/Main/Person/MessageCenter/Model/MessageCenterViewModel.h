//
//  MessageCenterViewModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/10.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"
@interface MessageCenterViewModel : NSObject

/**
 不存在的话插入,存在的话更新
 */
+ (BOOL)updataMessageModelWithMessageModel:(MessageModel *)messageModel;

/**
 根据消息分类获取消息数组
 */
+ (NSArray *)queryMessageModelArrWithMessageType:(MESSAGETYPE)messageType;

/**
 查询各类消息未读数量
 
 @return 返回各类消息未读数量
 */
+ (NSArray *)queryMessageTypesNum;

/**
 根据条件查询消息

 @param businessID 订单号
 @param jumpType 跳转类型
 @return 消息model
 */
+ (MessageModel *)queryMessageModelWithBusinessID:(NSString *)businessID jumpType:(NSString *)jumpType;
/**
 根据messageID查询消息
 
 @param messageId 消息id
 @return 消息model
 */
+ (MessageModel *)queryMessageModelWithMessageId:(NSString *)messageId;
@end
