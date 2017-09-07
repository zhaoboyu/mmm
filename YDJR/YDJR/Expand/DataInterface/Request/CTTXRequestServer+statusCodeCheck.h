//
//  CTTXRequestServer+statusCodeCheck.h
//  YDJR
//
//  Created by 李爽 on 2017/3/17.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"
@class MessageModel;
@interface CTTXRequestServer (statusCodeCheck)

/**
 状态码消息查询
 
 @param messageId 消息ID
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)checkStatusCodeMessageWithMessageId:(NSString *)messageId SuccessBlock:(void (^)(MessageModel *messageModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 根据businessID和jumpType查询消息
 
 @param businessID 达分期订单ID
 @param jumpType 消息跳转类型
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)checkStatusCodeMessageWithBusinessID:(NSString *)businessID jumpType:(NSString *)jumpType SuccessBlock:(void (^)(MessageModel *messageModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 客户基本信息查询
 
 @param customerID 客户ID
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)checkCustomerWithCustomerID:(NSString *)customerID SuccessBlock:(void (^)(NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;

@end
