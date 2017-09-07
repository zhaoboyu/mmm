//
//  CTTXRequestServer+checkCar.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"
#import "LLFCarModel.h"
#import "LLFMechanismCarModel.h"
#import "LLFCarSeriesCarModel.h"
@interface CTTXRequestServer (checkCar)
/**
 *  根据机构代码查询车系
 *
 *  @param mechanismID     机构ID
 *  @param carSeriesJkhgc 是否进口:(1:进口,0:国产)
 *  @param carPpName 品牌
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkCarWithMechanismID:(NSString *)mechanismID carSeriesJkhgc:(NSString *)carSeriesJkhgc carPpName:(NSString *)carPpName SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  根据车系代码查询车型
 *
 *  @param MechanismModel     车系Model
 *  @param carSeriesJkhgc 是否进口:(1:进口,0:国产)
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkCarWithMechanismModel:(LLFMechanismCarModel *)MechanismModel carSeriesJkhgc:(NSString *)carSeriesJkhgc SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  根据车型查销售名称
 *
 *  @param CarSeriesModel     车型Model
 *  @param carSeriesJkhgc 是否进口:(1:进口,0:国产)
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkCarWithCarSeriesModel:(LLFCarSeriesCarModel *)CarSeriesModel carSeriesJkhgc:(NSString *)carSeriesJkhgc SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  根据车系查销售名称
 *
 *  @param mechanismCarModel     车系Model
 *  @param carSeriesJkhgc 是否进口:(1:进口,0:国产)
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkCarWithMechanismCarModel:(LLFMechanismCarModel *)mechanismCarModel carSeriesJkhgc:(NSString *)carSeriesJkhgc SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
