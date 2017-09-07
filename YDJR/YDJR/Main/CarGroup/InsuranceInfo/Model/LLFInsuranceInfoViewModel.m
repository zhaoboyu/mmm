//
//  LLFInsuranceInfoViewModel.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFInsuranceInfoViewModel.h"
#import "InsuranceInfoModel.h"
#import "CTTXRequestServer+InsuranceInfo.h"
@implementation LLFInsuranceInfoViewModel
/**
 *  获取InsuranceInfoModel列表
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
+ (void)getInsuranceInfoModelArrWithSuccessBlock:(void (^)(NSMutableDictionary *insuranceInfoModelDic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    if ([netWork isEqualToString:@"1"]) {
        SuccessBlock([self getlocalInsuranceInfoDic]);
    }else{
        CTTXRequestServer *server = [CTTXRequestServer shareInstance];
        [server checkInsuranceInfoWithSuccessBlock:^(NSMutableArray *insuranceInfoModelArr) {
            NSMutableDictionary *insuranceInfoModelDic = [NSMutableDictionary dictionary];
            if (insuranceInfoModelArr.count > 0) {
            
                for (InsuranceInfoModel *insuranceInfoModelTemp in insuranceInfoModelArr) {
                    insuranceInfoModelTemp.bgImageName = [self getBgItemImageNameWithInsuranceName:insuranceInfoModelTemp.insuranceName];
                    if ([insuranceInfoModelDic objectForKey:insuranceInfoModelTemp.insuranceSort]) {
                        NSMutableArray *insuranceInfoModelTempArr = [insuranceInfoModelDic objectForKey:insuranceInfoModelTemp.insuranceSort];
                        [insuranceInfoModelTempArr addObject:insuranceInfoModelTemp];
                        [insuranceInfoModelDic setObject:insuranceInfoModelTempArr forKey:insuranceInfoModelTemp.insuranceSort];
                    }else{
                        NSMutableArray *insuranceInfoModelTempArr = [NSMutableArray array];
                        [insuranceInfoModelTempArr addObject:insuranceInfoModelTemp];
                        [insuranceInfoModelDic setObject:insuranceInfoModelTempArr forKey:insuranceInfoModelTemp.insuranceSort];
                    }
                    
                }
                
            }
            SuccessBlock(insuranceInfoModelDic);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];
    }
}
+ (NSString *)getBgItemImageNameWithInsuranceName:(NSString *)insuranceName
{
    NSDictionary *dic = @{@"交强险":@"LLF_InsuranceInfo_bg_jiaoqaingxian",
                          @"车船税":@"LLF_InsuranceInfo_bg_chechuanshui",
                          @"车辆损失险":@"LLF_InsuranceInfo_bg_pressed_cheliangsunshixian",
                          @"全车盗抢险":@"LLF_InsuranceInfo_bg_pressed_quancheqiangdaoxian",
                          @"第三者责任险":@"LLF_InsuranceInfo_bg_pressed_disanfangzerenxian",
                          @"不计免赔险":@"LLF_InsuranceInfo_bg_pressed_bujimianpeixian",
                          @"车身划痕损失险":@"LLF_InsuranceInfo_bg_pressed_cheshenhuahensunshixian",
                          @"玻璃单独破碎险":@"LLF_InsuranceInfo_bg_pressed_bolidanduposuixian",
                          @"司机座位责任险":@"LLF_InsuranceInfo_bg_pressed_sijizuoweizerenxian",
                          @"乘客座位责任险":@"LLF_InsuranceInfo_bg_pressed_chengkezuoweizerenxian",
                          @"自燃损失险":@"LLF_InsuranceInfo_bg_pressed_ziransunshixian",
                          @"涉水行驶损失险":@"LLF_InsuranceInfo_bg_pressed_sheshuixingshisunshixian",
                          @"1年期":@"LLF_InsuranceInfo_bg_pressed_1nianqi",@"2年期":@"LLF_InsuranceInfo_bg_pressed_2ninaqi",
                          @"3年期":@"LLF_InsuranceInfo_bg_pressed_3nianqi"};
    return [dic objectForKey:insuranceName];
}
+ (NSMutableDictionary *)getlocalInsuranceInfoDic
{
    NSDictionary *dic = @{@"DictInsus":@[@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"jqx",@"insuranceId":@"1",@"insuranceName":@"交强险",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"1"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"ccs",@"insuranceId":@"2",@"insuranceName":@"车船税",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"1"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"clssx",@"insuranceId":@"3",@"insuranceName":@"车辆损失险",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"2"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"qcdqx",@"insuranceId":@"4",@"insuranceName":@"全车盗抢险",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"2"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"dsfzrx",@"insuranceId":@"5",@"insuranceName":@"第三者责任险",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"2"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"bjmpx",@"insuranceId":@"6",@"insuranceName":@"不计免赔险",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"2"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"cshhssx",@"insuranceId":@"11",@"insuranceName":@"车身划痕损失险",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"3"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"blddpsx",@"insuranceId":@"10",@"insuranceName":@"玻璃单独破碎险",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"3"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"sjzwzrx",@"insuranceId":@"9",@"insuranceName":@"司机座位责任险",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"3"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"ckzwzrx",@"insuranceId":@"8",@"insuranceName":@"乘客座位责任险",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"3"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"zrssx",@"insuranceId":@"7",@"insuranceName":@"自燃损失险",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"3"},@{@"bak1":@"",@"bak2":@"",@"bak3":@"",@"insuranceCode":@"ssxsssx",@"insuranceId":@"12",@"insuranceName":@"涉水行驶损失险",@"insurancePrice":@"0.10000000149011612",@"insuranceSort":@"3"}],@"InsCount":@[@{@"dictdesc":@"",@"dictitem": @"IDFS000304",@"dictname":@"1年期",@"dictvalue":@"1"},@{@"dictdesc":@"",@"dictitem": @"IDFS000304",@"dictname":@"2年期",@"dictvalue":@"2"},@{@"dictdesc":@"",@"dictitem": @"IDFS000304",@"dictname":@"3年期",@"dictvalue":@"3"}]};
    NSMutableArray *insuranceInfoModelArr = [NSMutableArray array];
    NSArray *insuranceInfoDicArr = [dic objectForKey:@"DictInsus"];
//    NSArray *insuranceInfoDicArr = [NSFileManager loadArrayFromPath:DirectoryTypeMainBundle withFilename:@"InsuranceInfoModelArr"];
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
                insuranceInfoModel.isSelect = NO;
                [insuranceInfoModelArr addObject:insuranceInfoModel];
            }
        }
    }
    
    NSMutableDictionary *insuranceInfoModelDic = [NSMutableDictionary dictionary];
    if (insuranceInfoModelArr.count > 0) {
        
        for (InsuranceInfoModel *insuranceInfoModelTemp in insuranceInfoModelArr) {
            if ([insuranceInfoModelDic objectForKey:insuranceInfoModelTemp.insuranceSort]) {
                NSMutableArray *insuranceInfoModelTempArr = [insuranceInfoModelDic objectForKey:insuranceInfoModelTemp.insuranceSort];
                [insuranceInfoModelTempArr addObject:insuranceInfoModelTemp];
                [insuranceInfoModelDic setObject:insuranceInfoModelTempArr forKey:insuranceInfoModelTemp.insuranceSort];
            }else{
                NSMutableArray *insuranceInfoModelTempArr = [NSMutableArray array];
                [insuranceInfoModelTempArr addObject:insuranceInfoModelTemp];
                [insuranceInfoModelDic setObject:insuranceInfoModelTempArr forKey:insuranceInfoModelTemp.insuranceSort];
            }
            
        }
        
    }
    return insuranceInfoModelDic;
}
@end
