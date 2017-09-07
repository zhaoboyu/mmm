//
//  CTTXRequestServer+fileManger.h
//  YDJR
//
//  Created by 吕利峰 on 2017/6/12.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"
@class UploadFileModel;
@interface CTTXRequestServer (fileManger)
/**
 上传用户头像
 
 @param filePath 头像路径
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)uploadFileHeadImageWithFilePath:(NSString *)filePath SuccessBlock:(void (^)(BOOL result))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
- (void)downloadFileWithPamart:(NSString *)pamart SuccessBlock:(void (^)(UIImage *headImage))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 达分期上传合同
 
 @param param 参数对象
 @param loanContractNoPath 借款合同地址
 @param commissionContractNoPath 委托合同地址
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)uploadContractWithRequestParam:(NSDictionary *)param loanContractNoPath:(NSString *)loanContractNoPath commissionContractNoPath:(NSString *)commissionContractNoPath SuccessBlock:(void (^)(NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  意见反馈上传图片
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)fileUploadOpinionIdWithFileModel:(UploadFileModel *)fileModel WithSuccessBlock:(void (^)(BOOL ReturnCode))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  达分期上传图片
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)fileUploadImageFileWithFileModel:(UploadFileModel *)fileModel WithSuccessBlock:(void (^)(SysHeadModel *sysHeadModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
