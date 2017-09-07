//
//  CTTXRequestServer+Login.h
//  YDJR
//
//  Created by 吕利峰 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"

@interface CTTXRequestServer (Login)
/**
 *  登录请求
 *
 *  @param username     用户名
 *  @param password     密码
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */

- (void)loginWithUsername:(NSString *)username password:(NSString *)password SuccessBlock:(void (^)(UserDataModel *userDataModel,SysHeadModel *sysHeadModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  推送信息查询
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */

- (void)checkMessageWithSuccessBlock:(void (^)(NSMutableArray *messageModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  修改密码
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */

- (void)revisePassworderWithUserName:(NSString *)userName NewPassworder:(NSString *)newPassworder SuccessBlock:(void (^)(BOOL state))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  意见反馈
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */

- (void)feedbackWithUserCode:(NSString *)userCode content:(NSString *)content opinionType:(NSString *)opinionType SuccessBlock:(void (^)(NSDictionary *resultDic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
