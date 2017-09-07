//
//  CTTXRequestServer+SMS.m
//  YDJR
//
//  Created by sundacheng on 16/10/31.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+SMS.h"

@implementation CTTXRequestServer (SMS)

- (void)appSMSSendWithPhoneNum:(NSString *)PhoneNum SuccessBlock:(void (^)(void))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    
    [reqinfoDic setObject:PhoneNum forKey:@"mobile"];
    
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.m001.02" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    //把参数字典转换成JSON字符串
//    NSString *jsonStr = [Tool JSONString:dataDic];
    NetworkRequest *request = [[NetworkRequest alloc]init];
    
//    [request appendBodyParma:@"msg" value:jsonStr];
    [request setParmaBodyWithParma:dataDic];
    
    request.requestMethod = @"POST";
    
    [request requestWithSuccessBlock:^(id responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"dict %@",dict);
        
        SuccessBlock();
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}

- (void)appSMSVerifyWithSMSCode:(NSString *)SMSCode andPhoneNum:(NSString *)PhoneNum SuccessBlock:(void (^)(void))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock {
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    
    [reqinfoDic setObject:SMSCode forKey:@"receiveMessage"];
    [reqinfoDic setObject:PhoneNum forKey:@"mobile"];
    
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.m001.03" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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

@end
