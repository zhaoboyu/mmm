//
//  CTTXRequestServer+CustomerManager.m
//  YDJR
//
//  Created by sundacheng on 16/10/11.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+CustomerManager.h"
#import "LLFDafenqiBusinessModel.h"
#import "SDCCustomerContactModel.h"
#import "SDCCustomerIntrestModel.h"
#import "UserDataModel.h"
#import "LLFFinalApprovalModel.h"

@implementation CTTXRequestServer (CustomerManager)

- (void)searchCustomerInfoWithSuccessBlock:(void (^)(NSMutableArray *customerArray))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock {
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    
    NSString *userName = [UserDataModel sharedUserDataModel].userName;
    NSString *mechanismID = [Tool getMechinsId];
    [reqinfoDic setObject:userName forKey:@"operatorCode"];
    [reqinfoDic setObject:mechanismID forKey:@"mechanismID"];
    
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.g001.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    //把参数字典转换成JSON字符串
//    NSString *jsonStr = [Tool JSONString:dataDic];
    NetworkRequest *request = [[NetworkRequest alloc]init];
    
//    [request appendBodyParma:@"msg" value:jsonStr];
    [request setParmaBodyWithParma:dataDic];

    request.requestMethod = @"POST";
    
    if ([netWork isEqualToString:@"2"]) {
        //来源于网络
        [request requestWithSuccessBlock:^(id responseObject) {
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",dic);
            NSMutableArray *customersArr = [NSMutableArray array];
            
            NSArray *array = [dic objectForKey:@"customers"];
            
            
            if (![array isKindOfClass:[NSNull class]]) {
                for (NSDictionary *insuranceInfoDic in array) {
                    SDCCustomerContactModel *model = [SDCCustomerContactModel yy_modelWithDictionary:insuranceInfoDic];
                    model.indexForRow = -1;
                    [customersArr addObject:model];
                }
            }
            SuccessBlock(customersArr);
        } failedBlock:^(NSError *error) {
            
            failedBlock(error);
        }];
    } else {
        //本地数据
        NSArray *array = [NSFileManager loadArrayFromPath:DirectoryTypeMainBundle withFilename:@"customers"];
        NSMutableArray *customersArr = [NSMutableArray array];
        if (![array isKindOfClass:[NSNull class]]) {
            for (NSDictionary *insuranceInfoDic in array) {
                SDCCustomerContactModel *model = [SDCCustomerContactModel yy_modelWithDictionary:insuranceInfoDic];
                [customersArr addObject:model];
            }
        }
        SuccessBlock(customersArr);
    }
}

- (void)customerIntentOrderWithCustomerID:(NSString *)customerID SuccessBlock:(void (^)(NSMutableArray *customerArray))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock {
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    
    [reqinfoDic setObject:customerID forKey:@"customerID"];
    
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.g001.02" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    //把参数字典转换成JSON字符串
//    NSString *jsonStr = [Tool JSONString:dataDic];
    NetworkRequest *request = [[NetworkRequest alloc]init];
    
//    [request appendBodyParma:@"msg" value:jsonStr];
    [request setParmaBodyWithParma:dataDic];
    
    request.requestMethod = @"POST";
    
    if ([netWork isEqualToString:@"2"]) {
        //来源于网络
        [request requestWithSuccessBlock:^(id responseObject) {
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"agree.ydjr.g001.02:%@",dic);
            NSMutableArray *customersArr = [NSMutableArray array];
            
            NSArray *array = [dic objectForKey:@"intents"];
            
            NSLog(@"home %@",NSHomeDirectory());
            
//            NSLog(@"array%@",array);
            
            
            if (![array isKindOfClass:[NSNull class]]) {
                for (NSDictionary *insuranceInfoDic in array) {
                    SDCCustomerIntrestModel *model = [SDCCustomerIntrestModel yy_modelWithDictionary:insuranceInfoDic];
                    [customersArr addObject:model];
                }
            }
            //达分期订单信息数组
            NSArray *dafenqiBusinessArr = [dic objectForKey:@"dafenqiBusiness"];
            if (![dafenqiBusinessArr isKindOfClass:[NSNull class]]) {
                for (NSDictionary *insuranceInfoDic in dafenqiBusinessArr) {
                    LLFDafenqiBusinessModel *model = [LLFDafenqiBusinessModel yy_modelWithDictionary:insuranceInfoDic];
                    //过滤掉简版达分期产品
                    if (![model.terminalType isEqualToString:@"01"]) {
                      [customersArr addObject:model];
                    }
                    
                }
            }
            
            SuccessBlock(customersArr);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];
    } else {
        NSArray *array = [NSFileManager loadArrayFromPath:DirectoryTypeMainBundle withFilename:customerID];
        NSMutableArray *customersArr = [NSMutableArray array];
        if (![array isKindOfClass:[NSNull class]]) {
            for (NSDictionary *insuranceInfoDic in array) {
                SDCCustomerIntrestModel *model = [SDCCustomerIntrestModel yy_modelWithDictionary:insuranceInfoDic];
                [customersArr addObject:model];
            }
        }
        SuccessBlock(customersArr);
    }
}

- (void)customerInfoFixWithCustomer:(NSDictionary *)customerDict SuccessBlock:(void (^)(void))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock {
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    
    [dataDic setObject:customerDict forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.g001.05" Contrast:customerDict] forKey:@"SYS_HEAD"];
    //把参数字典转换成JSON字符串
//    NSString *jsonStr = [Tool JSONString:dataDic];
    NetworkRequest *request = [[NetworkRequest alloc]init];
    
//    [request appendBodyParma:@"msg" value:jsonStr];
    [request setParmaBodyWithParma:dataDic];
    
    request.requestMethod = @"POST";
    
    [request requestWithSuccessBlock:^(id responseObject) {
        SuccessBlock();
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}

- (void)stateChangeWithApproveStatus:(NSString *)approveStatus intentID:(NSString *)intentID productID:(NSString *)productID SuccessBlock:(void (^)(NSString *, NSString *))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    //意向单ID
    [reqinfoDic setObject:intentID forKey:@"intentID"];
    //产品ID
    [reqinfoDic setObject:productID forKey:@"productID"];
    
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.b001.05" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    //把参数字典转换成JSON字符串
//    NSString *jsonStr = [Tool JSONString:dataDic];
    NetworkRequest *request = [[NetworkRequest alloc]init];
	
//    [request appendBodyParma:@"msg" value:jsonStr];
    [request setParmaBodyWithParma:dataDic];
    
    request.requestMethod = @"POST";
    //查业务编号
    [request requestWithSuccessBlock:^(id responseObject) {
        
//        NSLog(@"responseObject %@",responseObject);
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"dict %@",dict);
        
        NSString *serialNo = [dict objectForKey:@"applySerialNo"];
        
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        //ReqInfo
        NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
        
        //业务编号
        [reqinfoDic setObject:@"1" forKey:@"productType"];
        [reqinfoDic setObject:serialNo forKey:@"ApplySerialNo"];
        [reqinfoDic setObject:intentID forKey:@"intentID"];
        //变更后状态
        [reqinfoDic setObject:approveStatus forKey:@"ApproveStatus"];
        //创建时间
        NSDate *senddate = [NSDate date];
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYYMMDDHHMMSS"];
        NSString *dateStr = [dateformatter stringFromDate:senddate];
//        NSLog(@"获取当前时间   = %@",dateStr);
        
        [reqinfoDic setObject:dateStr forKey:@"CreateTime"];
        //平台ID
        [reqinfoDic setObject:@"04" forKey:@"SystemChannelFlag"];
        
        [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
        [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.b001.03" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
        //把参数字典转换成JSON字符串
//        NSString *jsonStr = [Tool JSONString:dataDic];
        NetworkRequest *request = [[NetworkRequest alloc]init];
        
//        [request appendBodyParma:@"msg" value:jsonStr];
        [request setParmaBodyWithParma:dataDic];
        
        request.requestMethod = @"POST";
        
        [request requestWithSuccessBlock:^(id responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            NSString *code = dict[@"ReturnCode"];
            NSString *msg = dict[@"ReturnMessage"];
            SuccessBlock(code,msg);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}
/**
 *  终审批复文档查询
 *
 *  @param intentID   意向单id
 *  @param SuccessBlock 成功
 *  @param failedBlock  失败
 */
- (void)checkZhongShenWithIntentID:(NSString *)intentID SuccessBlock:(void (^)(LLFFinalApprovalModel *finalApprovalModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:intentID forKey:@"intentID"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.g002.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    NetworkRequest *request = [[NetworkRequest alloc]init];
    [request setParmaBodyWithParma:dataDic];
    //    request.isHttps = YES;
    request.requestMethod = @"POST";
    [request requestWithSuccessBlock:^(id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dic);

        LLFFinalApprovalModel *finalApprovalModel = [LLFFinalApprovalModel yy_modelWithJSON:dic];
        SuccessBlock(finalApprovalModel);
        
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];

}
@end    
