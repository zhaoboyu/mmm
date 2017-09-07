//
//  CTTXRequestServer+InsuranceInfo.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"

@interface CTTXRequestServer (InsuranceInfo)
/**
 *  查保险信息
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkInsuranceInfoWithSuccessBlock:(void (^)(NSMutableArray *insuranceInfoModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
