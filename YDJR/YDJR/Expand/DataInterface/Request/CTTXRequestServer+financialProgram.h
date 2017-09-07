//
//  CTTXRequestServer+financialProgram.h
//  YDJR
//
//  Created by 李爽 on 2016/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"
#import "LSFinancialProductsModel.h"
#import "LSAgentProductsTemplateModel.h"
@interface CTTXRequestServer (financialProgram)

/**
 *  跟据销售名称查询金融产品名称
 *
 *  @param catModelDetailID catModelDetailID
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkProductsWithCatModelDetailID:(NSString *)catModelDetailID SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 根据意向单ID查询意向单

 @param intentID 意向单ID
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)checkIntentWithIntentID:(NSString *)intentID SuccessBlock:(void (^)(NSDictionary *intentDictionary))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 根据产品ID和条件计算代理产品

 @param param 请求信息
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)countAgentProductsTemplateInfoWithRequestParam:(NSMutableDictionary *)param SuccessBlock:(void (^)(NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;

/**
 根据产品ID查询代理产品模板信息
 
 @param productID 请求信息
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)checkAgentProductsTemplateInfoWithProductID:(NSString *)productID SuccessBlock:(void (^)(NSMutableArray *templateModelArray))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
