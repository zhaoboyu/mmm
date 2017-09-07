//
//  CTTXRequestServer+uploadContract.h
//  YDJR
//
//  Created by 李爽 on 2017/3/17.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"

@interface CTTXRequestServer (uploadContract)

/**
 上传合同
 
 @param param 请求参数
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)uploadContractWithRequestParam:(NSDictionary *)param SuccessBlock:(void (^)(NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 采集影像是上传
 
 @param businessID 订单号
 @param typeNo 影像代码
 @param operationType 操作类型
 @param imageName 合同号
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)uploadContractInBGWithBusinessID:(NSString *)businessID typeNo:(NSString *)typeNo operationType:(NSString *)operationType imageName:(NSString *)imageName SuccessBlock:(void (^)(NSDictionary *dic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 下载合同
 
 @param businessID 订单号
 @param fileName 合同号
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)downContractWithBusinessID:(NSString *)businessID fileName:(NSString *)fileName SuccessBlock:(void (^)(NSString *contractPath))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
