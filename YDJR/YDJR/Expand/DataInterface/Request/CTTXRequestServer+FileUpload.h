//
//  CTTXRequestServer+FileUpload.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/30.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"
#import "UploadFileModel.h"
@interface CTTXRequestServer (FileUpload)
/**
 *  远程上传图片
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)fileUploadWithFileModel:(UploadFileModel *)fileModel WithSuccessBlock:(void (^)(NSString *ReturnCode))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  上传图片
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)imageUploadWithFileModel:(UploadFileModel *)fileModel WithSuccessBlock:(void (^)(BOOL ReturnCode))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  达分期上传图片
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)uploadImageFileWithFileModel:(UploadFileModel *)fileModel WithSuccessBlock:(void (^)(SysHeadModel *sysHeadModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 达分期订单状态变更接口
 
 @param businessID 达分期订单号
 @param operaTionType 操作类型
 01:一次影像资料采集
 02:补件
 03:二次进件
 04:补保单
 17:取消申请
 @param productType 产品类型
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)upDFQStateWithBusinessID:(NSString *)businessID operaTionType:(NSString *)operaTionType productType:(NSString *)productType WithSuccessBlock:(void (^)(NSString *ReturnCode,NSString *ReturnMessage))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
