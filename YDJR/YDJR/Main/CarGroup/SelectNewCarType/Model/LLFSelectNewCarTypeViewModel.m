//
//  LLFSelectNewCarTypeViewModel.m
//  YDJR
//
//  Created by 吕利峰 on 2016/12/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFSelectNewCarTypeViewModel.h"
#import "CTTXRequestServer+checkCar.h"
@implementation LLFSelectNewCarTypeViewModel
/**
 *  根据车系查销售名称
 *
 *  @param mechanismCarModel     车系Model
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
+ (void)getCarModelArrWithCarSeriesModel:(LLFMechanismCarModel *)mechanismCarModel SuccessBlock:(void (^)(NSMutableDictionary *carModelDic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    if ([netWork isEqualToString:@"1"]) {
//        SuccessBlock([self getlocalCarModelDic]);
    }else{
        NSString *carSeriesJkhgc = [[NSUserDefaults standardUserDefaults] objectForKey:@"carSeriesJkhgc"];
        CTTXRequestServer *server = [CTTXRequestServer shareInstance];
        [server checkCarWithMechanismCarModel:mechanismCarModel carSeriesJkhgc:carSeriesJkhgc  SuccessBlock:^(NSMutableArray *carModelArr) {
            NSMutableDictionary *carModelDic = [NSMutableDictionary dictionary];
            if (carModelArr.count > 0) {
                
                for (LLFCarModel *carModelTemp in carModelArr) {
                    if ([carModelDic objectForKey:carModelTemp.catModelDetailYear]) {
                        NSMutableArray *carModelTempArr = [carModelDic objectForKey:carModelTemp.catModelDetailYear];
                        [carModelTempArr addObject:carModelTemp];
                        [carModelDic setObject:carModelTempArr forKey:carModelTemp.catModelDetailYear];
                    }else{
                        NSMutableArray *carModelTempArr = [NSMutableArray array];
                        [carModelTempArr addObject:carModelTemp];
                        [carModelDic setObject:carModelTempArr forKey:carModelTemp.catModelDetailYear];
                    }
                    
                }
                //本地缓存销售名称的数据
                NSString *carModelDetailPath = [NSString stringWithFormat:@"%@carModelDetailPath%@%@",[Tool getMechinsId],mechanismCarModel.carSeriesCode,carSeriesJkhgc];
                NSArray *arr = [NSArray arrayWithObject:carModelDic];
                [Tool archiverWithObjectArr:arr fileName:carModelDetailPath];
                
            }
            SuccessBlock(carModelDic);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];
    }
}
@end
