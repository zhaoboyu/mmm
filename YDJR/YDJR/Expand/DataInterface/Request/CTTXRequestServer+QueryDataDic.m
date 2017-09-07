//
//  CTTXRequestServer+QueryDataDic.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+QueryDataDic.h"

@implementation CTTXRequestServer (QueryDataDic)
/**
 *  获取数据字典
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkListDicInfoWithSuccessBlock:(void (^)(NSDictionary *insuranceInfoModelDic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    //判断当前是否是登录状态
    UserDataModel *userModel = [UserDataModel sharedUserDataModel];
    
    if (userModel.isLogin){
        [reqinfoDic setObject:[Tool getMechinsId] forKey:@"mechanismID"];
    }
    
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.d001.02" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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
        SuccessBlock(dic);
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];
}
@end
