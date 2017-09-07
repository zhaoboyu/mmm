//
//  LLFWorkBenchViewModel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/6/11.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFWorkBenchViewModel.h"
#import "LLFWorkBenchModel.h"
#import "MessageModel.h"
#import "LLFDafenqiBusinessModel.h"
#import "SDCCustomerIntroViewModel.h"

#import "CTTXRequestServer+statusCodeCheck.h"
@implementation LLFWorkBenchViewModel
/**
 根据订单信息查询消息
 
 @param workBenchModel 订单信息model
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
+ (void)checkMessageWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel SuccessBlock:(void (^)(MessageModel *messageModel, NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    if ([workBenchModel.productType isEqualToString:@"01"]) {
        //达分期
        [SDCCustomerIntroViewModel checkMessageWithDafenqiBusinessModel:workBenchModel.dfqModelInfo SuccessBlock:^(MessageModel *messageModel, NSDictionary *responseDict) {
            SuccessBlock(messageModel,responseDict);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];
    }else if ([workBenchModel.productType isEqualToString:@"02"]){
        //自营及其他
        [SDCCustomerIntroViewModel checkMessageWithCustomerIntresModel:workBenchModel.intentModelInfo SuccessBlock:^(MessageModel *messageModel) {
            SuccessBlock(messageModel,NULL);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];

    }
    
}
@end
