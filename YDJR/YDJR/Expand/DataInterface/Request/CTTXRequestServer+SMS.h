//
//  CTTXRequestServer+SMS.h
//  YDJR
//
//  Created by sundacheng on 16/10/31.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"

/**
 *  短信发送及验证
 */
@interface CTTXRequestServer (SMS)

//发送短信
- (void)appSMSSendWithPhoneNum:(NSString *)PhoneNum SuccessBlock:(void (^)(void))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;

//验证短信
- (void)appSMSVerifyWithSMSCode:(NSString *)SMSCode andPhoneNum:(NSString *)PhoneNum SuccessBlock:(void (^)(void))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;

@end
