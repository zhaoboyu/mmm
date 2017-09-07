//
//  SDCCustomerIntroViewModel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/4/24.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "SDCCustomerIntroViewModel.h"
#import "LLFDafenqiBusinessModel.h"
#import "SDCCustomerIntrestModel.h"

#import "MessageModel.h"
#import "CTTXRequestServer.h"
#import "CTTXRequestServer+statusCodeCheck.h"
@implementation SDCCustomerIntroViewModel

#pragma mark 达分期订单状态操作处理
/**
 根据达分期订单信息查询消息
 
 @param dafenqiBusinessModel 达分期订单信息model
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
+ (void)checkMessageWithDafenqiBusinessModel:(LLFDafenqiBusinessModel *)dafenqiBusinessModel SuccessBlock:(void (^)(MessageModel *messageModel, NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    /**
     跳转类型
     *01:一次影像资料采集
     *02:补件
     *03:二次进件
     *04:补保单
     *05:重启
     */
    NSString *stateStr;
    if ([dafenqiBusinessModel.patchState isEqualToString:@"01"] || [dafenqiBusinessModel.coverPolicy isEqualToString:@"01"]) {
        //补件
        if ([dafenqiBusinessModel.patchState isEqualToString:@"01"]) {
            stateStr = @"02";
        }else if ([dafenqiBusinessModel.coverPolicy isEqualToString:@"01"]){
            //需补保单
            stateStr = @"04";
        }
        
        
    }else{
        if ([dafenqiBusinessModel.processState isEqualToString:@"04"]) {
            //客户拒绝-进行重启流程
            [self checkMessageWithBusinessID:dafenqiBusinessModel.businessID SuccessBlock:^(MessageModel *messageModel, NSDictionary *responseDict) {
                SuccessBlock(messageModel,responseDict);
            } failedBlock:^(NSError *error) {
                failedBlock(error);
            }];
            return;
            
        }else if ([dafenqiBusinessModel.processState isEqualToString:@"06"]){
            //审批通过,二次进件
            stateStr = @"03";
            
        }else if ([dafenqiBusinessModel.processState isEqualToString:@"12"]){
            //需补保单
            stateStr = @"04";
            
        }else if ([dafenqiBusinessModel.processState isEqualToString:@"13"]){
            //一次进件
            stateStr = @"01";
            
        }
    }
    
    [self checkMessageWithBusinessID:dafenqiBusinessModel.businessID jumpType:stateStr SuccessBlock:^(MessageModel *messageModel) {
        SuccessBlock(messageModel,nil);
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}

+ (void)checkMessageWithBusinessID:(NSString *)BusinessID jumpType:(NSString *)jumpType SuccessBlock:(void (^)(MessageModel *messageModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    [[CTTXRequestServer shareInstance] checkStatusCodeMessageWithBusinessID:BusinessID jumpType:jumpType SuccessBlock:^(MessageModel *messageModel) {
        SuccessBlock(messageModel);
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}

+ (void)checkMessageWithBusinessID:(NSString *)BusinessID SuccessBlock:(void (^)(MessageModel *messageModel, NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    [[CTTXRequestServer shareInstance] checkStatusCodeMessageWithBusinessID:BusinessID jumpType:@"05" SuccessBlock:^(MessageModel *messageModel) {
        [[CTTXRequestServer shareInstance] checkCustomerWithCustomerID:messageModel.customerID SuccessBlock:^(NSDictionary *responseDict) {
            SuccessBlock(messageModel,responseDict);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}

#pragma mark 意向单状态操作处理
/**
 根据意向单信息查询消息
 
 @param customerIntresModel 意向单信息model
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
+ (void)checkMessageWithCustomerIntresModel:(SDCCustomerIntrestModel *)customerIntresModel SuccessBlock:(void (^)(MessageModel *messageModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    /**
     跳转类型
     *01:一次影像资料采集
     *02:补件
     *03:二次进件
     *04:补保单
     *05:重启
     */
    NSString *stateStr;
    if ([customerIntresModel.patchState isEqualToString:@"01"]) {
        //补件
        stateStr = @"02";
        
    }else if ([customerIntresModel.state isEqualToString:@"00"]){
        //一次影像采集
        stateStr = @"01";
    }
    
    [self checkMessageWithBusinessID:customerIntresModel.intentID jumpType:stateStr SuccessBlock:^(MessageModel *messageModel) {
        SuccessBlock(messageModel);
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}
@end
