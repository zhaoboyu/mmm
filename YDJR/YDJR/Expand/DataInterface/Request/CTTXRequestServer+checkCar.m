//
//  CTTXRequestServer+checkCar.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+checkCar.h"

@implementation CTTXRequestServer (checkCar)
/**
 *  根据机构代码查询车系
 *
 *  @param mechanismID     机构ID
 *  @param carSeriesJkhgc 是否进口:(1:进口,0:国产)
 *  @param carPpName 品牌
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkCarWithMechanismID:(NSString *)mechanismID carSeriesJkhgc:(NSString *)carSeriesJkhgc carPpName:(NSString *)carPpName SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:carPpName forKey:@"carPpName"];
    [reqinfoDic setObject:mechanismID forKey:@"mechanismID"];
    [reqinfoDic setObject:carSeriesJkhgc forKey:@"carSeriesJkhgc"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.c001.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    //把参数字典转换成JSON字符串
//    NSString *jsonStr = [Tool JSONString:dataDic];
    NetworkRequest *request = [[NetworkRequest alloc]init];
    
//    [request appendBodyParma:@"msg" value:jsonStr];
    [request setParmaBodyWithParma:dataDic];
    //    request.isHttps = YES;
    request.requestMethod = @"POST";
    
    [request requestWithSuccessBlock:^(id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dic);
        NSMutableArray *carModelArr = [NSMutableArray array];
        NSArray *carDicArr = [dic objectForKey:@"series"];
        if (![carDicArr isKindOfClass:[NSNull class]]) {
            for (NSDictionary *carDic in carDicArr) {
                LLFMechanismCarModel *carModel = [LLFMechanismCarModel yy_modelWithDictionary:carDic];
                [carModelArr addObject:carModel];
            }
        }
        SuccessBlock(carModelArr);
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];
}
/**
 *  根据车系代码查询车型
 *
 *  @param MechanismModel     车系Model
 *  @param carSeriesJkhgc 是否进口:(1:进口,0:国产)
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkCarWithMechanismModel:(LLFMechanismCarModel *)MechanismModel carSeriesJkhgc:(NSString *)carSeriesJkhgc SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:MechanismModel.carSeriesCode forKey:@"carSeriesID"];
    [reqinfoDic setObject:carSeriesJkhgc forKey:@"carModelJkhgc"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.c001.02" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    //把参数字典转换成JSON字符串
//    NSString *jsonStr = [Tool JSONString:dataDic];
    NetworkRequest *request = [[NetworkRequest alloc]init];
    
//    [request appendBodyParma:@"msg" value:jsonStr];
    [request setParmaBodyWithParma:dataDic];
    //    request.isHttps = YES;
    request.requestMethod = @"POST";
    
    [request requestWithSuccessBlock:^(id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dic);
        NSMutableArray *carModelArr = [NSMutableArray array];
        NSArray *carDicArr = [dic objectForKey:@"models"];
        if (![carDicArr isKindOfClass:[NSNull class]]) {
            for (NSDictionary *carDic in carDicArr) {
                LLFCarSeriesCarModel *carModel = [LLFCarSeriesCarModel yy_modelWithDictionary:carDic];
                carModel.carPpName = MechanismModel.carPpName;
//                carModel.catModelImgAdree = MechanismModel.carSeriesImg;
                [carModelArr addObject:carModel];
            }
        }
        SuccessBlock(carModelArr);
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];
}
/**
 *  根据车型查销售名称
 *
 *  @param CarSeriesModel     车型Model
 *  @param carSeriesJkhgc 是否进口:(1:进口,0:国产)
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkCarWithCarSeriesModel:(LLFCarSeriesCarModel *)CarSeriesModel carSeriesJkhgc:(NSString *)carSeriesJkhgc SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:CarSeriesModel.carModelID forKey:@"carModelID"];
    [reqinfoDic setObject:carSeriesJkhgc forKey:@"carModelDetailJkhgc"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.c001.03" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    //把参数字典转换成JSON字符串
//    NSString *jsonStr = [Tool JSONString:dataDic];
    NetworkRequest *request = [[NetworkRequest alloc]init];
    
//    [request appendBodyParma:@"msg" value:jsonStr];
    [request setParmaBodyWithParma:dataDic];
    //    request.isHttps = YES;
    request.requestMethod = @"POST";
    
    [request requestWithSuccessBlock:^(id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dic);
        NSMutableArray *carModelArr = [NSMutableArray array];
        NSArray *carDicArr = [dic objectForKey:@"modelDetail"];
        if (![carDicArr isKindOfClass:[NSNull class]]) {
            for (NSDictionary *carDic in carDicArr) {
                LLFCarModel *carModel = [LLFCarModel yy_modelWithDictionary:carDic];
                carModel.carPpName = CarSeriesModel.carPpName;
                [carModelArr addObject:carModel];
            }
        }
        SuccessBlock(carModelArr);
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}
/**
 *  根据车系查销售名称
 *
 *  @param mechanismCarModel     车系Model
 *  @param carSeriesJkhgc 是否进口:(1:进口,0:国产)
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkCarWithMechanismCarModel:(LLFMechanismCarModel *)mechanismCarModel carSeriesJkhgc:(NSString *)carSeriesJkhgc SuccessBlock:(void (^)(NSMutableArray *carModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:mechanismCarModel.carSeriesCode forKey:@"carModelID"];
    [reqinfoDic setObject:carSeriesJkhgc forKey:@"carModelDetailJkhgc"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.c001.03" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    //把参数字典转换成JSON字符串
//    NSString *jsonStr = [Tool JSONString:dataDic];
    NetworkRequest *request = [[NetworkRequest alloc]init];
    
//    [request appendBodyParma:@"msg" value:jsonStr];
    [request setParmaBodyWithParma:dataDic];
    //    request.isHttps = YES;
    request.requestMethod = @"POST";
    
    [request requestWithSuccessBlock:^(id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dic);
        NSMutableArray *carModelArr = [NSMutableArray array];
        NSArray *carDicArr = [dic objectForKey:@"modelDetail"];
        if (![carDicArr isKindOfClass:[NSNull class]]) {
            for (NSDictionary *carDic in carDicArr) {
                LLFCarModel *carModel = [LLFCarModel yy_modelWithDictionary:carDic];
                carModel.carPpName = mechanismCarModel.carPpName;
                carModel.carSeriesName = mechanismCarModel.carSeriesName;
                carModel.carSeriesID = mechanismCarModel.carSeriesID;
                [carModelArr addObject:carModel];
            }
        }
        SuccessBlock(carModelArr);
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}
@end
