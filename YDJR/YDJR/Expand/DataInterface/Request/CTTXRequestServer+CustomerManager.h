//
//  CTTXRequestServer+CustomerManager.h
//  YDJR
//
//  Created by sundacheng on 16/10/11.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"
@class LLFFinalApprovalModel;

@interface CTTXRequestServer (CustomerManager)

/**
 *  客户联系方式获取
 *
 *  @param SuccessBlock 成功
 *  @param failedBlock  失败
 */
- (void)searchCustomerInfoWithSuccessBlock:(void (^)(NSMutableArray *customerArray))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;

/**
 *  客户意向单
 *
 *  @param customerID   客户id
 *  @param SuccessBlock 成功
 *  @param failedBlock  失败
 */
- (void)customerIntentOrderWithCustomerID:(NSString *)customerID SuccessBlock:(void (^)(NSMutableArray *customerArray))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;

/**
 *  修改客户信息
 *
 *  @param customerDict 客户信息
 *  @param SuccessBlock 成功
 *  @param failedBlock  失败
 */
- (void)customerInfoFixWithCustomer:(NSDictionary *)customerDict SuccessBlock:(void (^)(void))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;

/**
 *  状态变更
 *
 *  @param approveStatus 变更状态 01-影像上传完成，02-补件完成，05-取消申请，07-保险购买成功，08-保险购买失败
 *  @param intentID      意向单ID
 *  @param productID     产品ID
 *  @param SuccessBlock  成功
 *  @param failedBlock   失败
 */
- (void)stateChangeWithApproveStatus:(NSString *)approveStatus intentID:(NSString *)intentID productID:(NSString *)productID SuccessBlock:(void (^)(NSString *code,NSString *msg))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  终审批复文档查询
 *
 *  @param intentID   意向单id
 *  @param SuccessBlock 成功
 *  @param failedBlock  失败
 */
- (void)checkZhongShenWithIntentID:(NSString *)intentID SuccessBlock:(void (^)(LLFFinalApprovalModel *finalApprovalModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
