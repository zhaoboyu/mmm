//
//  SDCCustomerIntroViewModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/4/24.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LLFDafenqiBusinessModel;
@class MessageModel;
@class SDCCustomerIntrestModel;
@interface SDCCustomerIntroViewModel : NSObject

/**
 根据达分期订单信息查询消息

 @param dafenqiBusinessModel 达分期订单信息model
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
+ (void)checkMessageWithDafenqiBusinessModel:(LLFDafenqiBusinessModel *)dafenqiBusinessModel SuccessBlock:(void (^)(MessageModel *messageModel, NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 根据意向单信息查询消息
 
 @param customerIntresModel 意向单信息model
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
+ (void)checkMessageWithCustomerIntresModel:(SDCCustomerIntrestModel *)customerIntresModel SuccessBlock:(void (^)(MessageModel *messageModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
