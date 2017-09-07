//
//  LLFCarGroupViewModel.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarGroupViewModel.h"
#import "LLFCarModel.h"
@implementation LLFCarGroupViewModel
/**
 *  获取车系Model列表
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
+ (void)getMechanismModelArrWithSuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    if ([netWork isEqualToString:@"1"]) {
        SuccessBlock([self getlocalMechanismArr]);
    }else{
        NSString *carSeriesJkhgc = [[NSUserDefaults standardUserDefaults] objectForKey:@"carSeriesJkhgc"];
//        UserDataModel *userModel = [UserDataModel sharedUserDataModel];
        CTTXRequestServer *server = [CTTXRequestServer shareInstance];
        [server checkCarWithMechanismID:[Tool getMechinsId] carSeriesJkhgc:carSeriesJkhgc carPpName:[Tool getPpName] SuccessBlock:^(NSMutableArray *carModelArr) {
            [Tool archiverWithObjectArr:carModelArr fileName:[NSString stringWithFormat:@"%@%@carSerierModelArrPath%@",[Tool getMechinsId],[Tool getPpName],carSeriesJkhgc]];
            SuccessBlock(carModelArr);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];
    }
    
}
//带参车型
+ (void)getMechanismModelArrWithcarSeriesJkhgc:(NSString *)carSeriesJkhgc  SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock{
    
    
    
    if ([netWork isEqualToString:@"1"]) {
        SuccessBlock([self getlocalMechanismArr]);
    }else{
//        UserDataModel *userModel = [UserDataModel sharedUserDataModel];
        CTTXRequestServer *server = [CTTXRequestServer shareInstance];
        [server checkCarWithMechanismID:[Tool getMechinsId] carSeriesJkhgc:carSeriesJkhgc carPpName:[Tool getPpName] SuccessBlock:^(NSMutableArray *carModelArr) {
            [Tool archiverWithObjectArr:carModelArr fileName:[NSString stringWithFormat:@"%@%@carSerierModelArrPath%@",[Tool getMechinsId],[Tool getPpName],carSeriesJkhgc]];
            SuccessBlock(carModelArr);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];
    }
    

}
/**
 *  获取车型model列表
 *
 *  @param MechanismModel     车系Model
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
+ (void)getSerierModelArrWithMechanismModel:(LLFMechanismCarModel *)MechanismModel SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    if ([netWork isEqualToString:@"1"]) {
        SuccessBlock([self getlocalSerierArr]);
    }else{
        NSString *carSeriesJkhgc = [[NSUserDefaults standardUserDefaults] objectForKey:@"carSeriesJkhgc"];
        CTTXRequestServer *server = [CTTXRequestServer shareInstance];
        [server checkCarWithMechanismModel:MechanismModel carSeriesJkhgc:carSeriesJkhgc SuccessBlock:^(NSMutableArray *carModelArr) {
            SuccessBlock(carModelArr);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];
    }
    
    
}
/**
 *  根据车型查销售名称
 *
 *  @param CarSeriesModel     车型Model
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
+ (void)getCarModelArrWithCarSeriesModel:(LLFCarSeriesCarModel *)CarSeriesModel SuccessBlock:(void (^)(NSMutableDictionary *carModelDic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    if ([netWork isEqualToString:@"1"]) {
        SuccessBlock([self getlocalCarModelDic]);
    }else{
        NSString *carSeriesJkhgc = [[NSUserDefaults standardUserDefaults] objectForKey:@"carSeriesJkhgc"];
        CTTXRequestServer *server = [CTTXRequestServer shareInstance];
        [server checkCarWithCarSeriesModel:CarSeriesModel carSeriesJkhgc:carSeriesJkhgc  SuccessBlock:^(NSMutableArray *carModelArr) {
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
                
            }
            SuccessBlock(carModelDic);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];
    }
}

//获取车系Model列表测试数据
+ (NSMutableArray *)getlocalMechanismArr
{

    NSDictionary *dic = @{@"series":@[@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"carSeriesID":@"1",@"carSeriesImg":@"",@"carSeriesName":@"宝马1系",@"mechanismID":@"1"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"carSeriesID":@"2",@"carSeriesImg":@"",@"carSeriesName":@"宝马2系",@"mechanismID":@"1"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"carSeriesID":@"3",@"carSeriesImg":@"",@"carSeriesName":@"宝马3系",@"mechanismID":@"1"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"carSeriesID":@"4",@"carSeriesImg":@"",@"carSeriesName":@"宝马4系",@"mechanismID":@"1"}]};
    NSMutableArray *carModelArr = [NSMutableArray array];
    NSArray *carDicArr = [dic objectForKey:@"series"];
    if (![carDicArr isKindOfClass:[NSNull class]]) {
        for (NSDictionary *carDic in carDicArr) {
            LLFMechanismCarModel *carModel = [LLFMechanismCarModel yy_modelWithDictionary:carDic];
            [carModelArr addObject:carModel];
        }
    }
    return carModelArr;
}
//获取车系Model列表测试数据
+ (NSMutableArray *)getlocalSerierArr
{
//    {"models":[
//               {"bak1":"","bak2":"","bak3":"","carModelID":"1","carModelName":"BMW1系运动型两厢轿车","carSeriesID":"1","catModelImgAdree":" ","catModelPrice":25.600000381469727}
//               ]
//    }
    NSDictionary *dic = @{@"models":@[@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"carModelID":@"1",@"carModelName":@"BMW1系运动型两厢轿车",@"carSeriesID":@"1",@"catModelImgAdree":@"",@"catModelPrice":@"25.600000381469727"}]};
    NSMutableArray *carModelArr = [NSMutableArray array];
    NSArray *carDicArr = [dic objectForKey:@"models"];
//    NSArray *carDicArr = [NSFileManager loadArrayFromPath:DirectoryTypeMainBundle withFilename:@"SerierModelArr"];
    if (![carDicArr isKindOfClass:[NSNull class]]) {
        for (NSDictionary *carDic in carDicArr) {
            LLFCarSeriesCarModel *carModel = [LLFCarSeriesCarModel yy_modelWithDictionary:carDic];
            [carModelArr addObject:carModel];
        }
    }
    return carModelArr;
}
//获取车系Model列表测试数据
+ (NSMutableDictionary *)getlocalCarModelDic
{
//    {"modelDetail":[
//                    {"bak1":"","bak2":"","bak3":"","catModelDetailID":"1","catModelDetailName":"BMW 1系118i 都市设计套装",
//                        "catModelDetailPrice":27.899999618530273,"catModelDetailYear":2016,"catModelID":"1"},
//                    {"bak1":"","bak2":"","bak3":"","catModelDetailID":"2","catModelDetailName":"BMW 1系118i 都市设计套装",
//                        "catModelDetailPrice":27.600000381469727,"catModelDetailYear":2015,"catModelID":"1"},
//                    {"bak1":"","bak2":"","bak3":"","catModelDetailID":"3","catModelDetailName":"BMW 1系120i 运动设计套装",
//                        "catModelDetailPrice":25.600000381469727,"catModelDetailYear":2015,"catModelID":"1"}
//                    ]
//    }
    NSDictionary *dic = @{@"modelDetail":@[@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"catModelDetailID":@"1",@"catModelDetailName":@"BMW 1系118i 都市设计套装",@"catModelDetailPrice":@"27.899999618530273",@"catModelDetailYear":@"2016",@"catModelID":@"1"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"catModelDetailID":@"2",@"catModelDetailName":@"BMW 1系118i 都市设计套装",@"catModelDetailPrice":@"27.600000381469727",@"catModelDetailYear":@"2015",@"catModelID":@"1"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"catModelDetailID":@"3",@"catModelDetailName":@"BMW 1系120i 运动设计套装",@"catModelDetailPrice":@"25.600000381469727",@"catModelDetailYear":@"2015",@"catModelID":@"1"}]};
    NSMutableArray *carModelArr = [NSMutableArray array];
    NSArray *carDicArr = [dic objectForKey:@"modelDetail"];
//    NSArray *carDicArr = [NSFileManager loadArrayFromPath:DirectoryTypeMainBundle withFilename:@"CarModelArr"];
    if (![carDicArr isKindOfClass:[NSNull class]]) {
        for (NSDictionary *carDic in carDicArr) {
            LLFCarModel *carModel = [LLFCarModel yy_modelWithDictionary:carDic];
            [carModelArr addObject:carModel];
        }
    }
    NSMutableDictionary *carModelDic = [NSMutableDictionary dictionary];
    if (carDicArr.count > 0) {
        
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
        
    }

    return carModelDic;
}
@end
