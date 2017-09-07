//
//  LLFWorkBenchViewModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/6/11.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LLFWorkBenchModel;
@class MessageModel;
@interface LLFWorkBenchViewModel : NSObject
/**
 根据订单信息查询消息
 
 @param workBenchModel 订单信息model
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
+ (void)checkMessageWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel SuccessBlock:(void (^)(MessageModel *messageModel, NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
