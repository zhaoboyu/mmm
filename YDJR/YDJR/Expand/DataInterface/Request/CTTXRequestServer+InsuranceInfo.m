//
//  CTTXRequestServer+InsuranceInfo.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+InsuranceInfo.h"
#import "InsuranceInfoModel.h"
@implementation CTTXRequestServer (InsuranceInfo)
/**
 *  查保险信息
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkInsuranceInfoWithSuccessBlock:(void (^)(NSMutableArray *insuranceInfoModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.i001.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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
        NSMutableArray *insuranceInfoModelArr = [NSMutableArray array];
        NSArray *insuranceInfoDicArr = [dic objectForKey:@"DictInsus"];
        if (![insuranceInfoDicArr isKindOfClass:[NSNull class]]) {
            for (NSDictionary *insuranceInfoDic in insuranceInfoDicArr) {
                InsuranceInfoModel *insuranceInfoModel = [InsuranceInfoModel yy_modelWithDictionary:insuranceInfoDic];
                if ([insuranceInfoModel.insuranceSort isEqualToString:@"1"]) {
                    insuranceInfoModel.insuranceSortName = @"必交项";
                    insuranceInfoModel.isSelect = YES;
                }else if ([insuranceInfoModel.insuranceSort isEqualToString:@"2"]){
                    insuranceInfoModel.insuranceSortName = @"主险";
                    insuranceInfoModel.isSelect = NO;

                }else if ([insuranceInfoModel.insuranceSort isEqualToString:@"3"]){
                    insuranceInfoModel.insuranceSortName = @"附加险";
                    insuranceInfoModel.isSelect = NO;
                    
                }
                [insuranceInfoModelArr addObject:insuranceInfoModel];
            }
            
            
            NSArray *insuranceNumDicArr = [dic objectForKey:@"InsCount"];
            
            if (![insuranceNumDicArr isKindOfClass:[NSNull class]]) {
                for (NSDictionary *insuranceInfoDic in insuranceNumDicArr) {
                    InsuranceInfoModel *insuranceInfoModel = [InsuranceInfoModel new];
                    insuranceInfoModel.insuranceSort = @"4";
                    insuranceInfoModel.insuranceSortName = @"保险期限";
                    insuranceInfoModel.insurancePrice = @"0";
                    insuranceInfoModel.insuranceName = [insuranceInfoDic objectForKey:@"dictname"];
                    insuranceInfoModel.dictvalue = [insuranceInfoDic objectForKey:@"dictvalue"];
                    insuranceInfoModel.isSelect = NO;
                    [insuranceInfoModelArr addObject:insuranceInfoModel];
                }
            }
        }
        SuccessBlock(insuranceInfoModelArr);
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];
}
@end
