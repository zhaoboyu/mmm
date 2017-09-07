//
//  LLFCarGroupViewModel.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTTXRequestServer+checkCar.h"
@interface LLFCarGroupViewModel : NSObject
/**
 *  获取车系Model列表
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
+ (void)getMechanismModelArrWithSuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;

/*
 **带参车型
 */
+ (void)getMechanismModelArrWithcarSeriesJkhgc:(NSString *)carSeriesJkhgc  SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  获取车型model列表
 *
 *  @param MechanismModel     车系Model
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
+ (void)getSerierModelArrWithMechanismModel:(LLFMechanismCarModel *)MechanismModel SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  根据车型查销售名称
 *
 *  @param CarSeriesModel     车型Model
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
+ (void)getCarModelArrWithCarSeriesModel:(LLFCarSeriesCarModel *)CarSeriesModel SuccessBlock:(void (^)(NSMutableDictionary *carModelDic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
