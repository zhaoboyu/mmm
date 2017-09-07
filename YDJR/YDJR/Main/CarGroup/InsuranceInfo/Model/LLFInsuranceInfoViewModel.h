//
//  LLFInsuranceInfoViewModel.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLFInsuranceInfoViewModel : NSObject
/**
 *  获取InsuranceInfoModel列表
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
+ (void)getInsuranceInfoModelArrWithSuccessBlock:(void (^)(NSMutableDictionary *insuranceInfoModelDic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
