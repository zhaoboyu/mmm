//
//  CTTXRequestServer+WorkBench.m
//  YDJR
//
//  Created by 吕利峰 on 2017/5/16.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+WorkBench.h"

@implementation CTTXRequestServer (WorkBench)
/**
 代办已办任务查询

 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)checkWorkBenchWithSuccessBlock:(void (^)(NSMutableArray *workCompleteTaskModelArr,NSMutableArray *waitTaskModelArr,SysHeadModel *sysHeadModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    NSString *operatorCode = [[UserDataModel sharedUserDataModel] operatorCode];
    [reqinfoDic setObject:operatorCode forKey:@"operatorCode"];
    [reqinfoDic setObject:[Tool getMechinsId] forKey:@"mechanismID"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.y001.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    //把参数字典转换成JSON字符串
    NetworkRequest *request = [[NetworkRequest alloc]init];
    [request setParmaBodyWithParma:dataDic];
    request.requestMethod = @"POST";
    
    [request requestWithSuccessBlock:^(id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSArray *workArr = [[dic objectForKey:@"RespInfo"] objectForKey:@"workArr"];
        NSMutableArray *workCompleteTaskModelArr = [NSMutableArray array];
        NSMutableArray *waitTaskModelArr = [NSMutableArray array];
        for (NSDictionary *work in workArr) {
            LLFWorkBenchModel *workBenchModel = [LLFWorkBenchModel yy_modelWithJSON:work];
            if ([workBenchModel.productType isEqualToString:@"01"] && [workBenchModel.dfqModelInfo.terminalType isEqualToString:@"01"]) {
                //筛选掉PC端简版达分期产品
            }else{
                if ([workBenchModel.workerState isEqualToString:@"01"]) {
                    [waitTaskModelArr addObject:workBenchModel];
                }else{
                    [workCompleteTaskModelArr addObject:workBenchModel];
                }
            }
            
        }
        SysHeadModel *sysHeadModel = [SysHeadModel yy_modelWithJSON:[dic objectForKey:@"SYS_HEAD"]];
        
        SuccessBlock(workCompleteTaskModelArr,waitTaskModelArr,sysHeadModel);
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}
@end
