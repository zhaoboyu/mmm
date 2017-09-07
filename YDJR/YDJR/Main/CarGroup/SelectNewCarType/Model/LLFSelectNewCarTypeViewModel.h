//
//  LLFSelectNewCarTypeViewModel.h
//  YDJR
//
//  Created by 吕利峰 on 2016/12/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LLFMechanismCarModel;
@interface LLFSelectNewCarTypeViewModel : NSObject
/**
 *  根据车系查销售名称
 *
 *  @param mechanismCarModel     车系Model
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
+ (void)getCarModelArrWithCarSeriesModel:(LLFMechanismCarModel *)mechanismCarModel SuccessBlock:(void (^)(NSMutableDictionary *carModelDic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
