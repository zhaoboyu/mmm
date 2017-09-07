//
//  CTTXRequestServer+Login.m
//  YDJR
//
//  Created by 吕利峰 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+Login.h"
#import "MessageModel.h"
@implementation CTTXRequestServer (Login)
/**
 *  登录请求
 *
 *  @param username     用户名
 *  @param password     密码
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */

- (void)loginWithUsername:(NSString *)username password:(NSString *)password SuccessBlock:(void (^)(UserDataModel *userDataModel,SysHeadModel *sysHeadModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    if ([netWork isEqualToString:@"1"]) {
        NSDictionary *dic = @{@"userName":@"ydtest1",@"userDesc":@"小明",@"mechanismID":@"11001",@"logincnt":@"577",@"mechanismName":@"宝诚浦东店",@"roles":@[@{@"roleId":@"31",@"roleName":@"金融经理"}]};
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        UserDataModel *userModel = [UserDataModel sharedUserDataModel];
        [userModel setValuesForKeysWithDictionary:dic];
        NSDictionary *userDic = [userModel yy_modelToJSONObject];
        [defaults setObject:@"1" forKey:LOGIN];
        [defaults setObject:userDic forKey:USERMODEL];
        //            [Tool saveUserDicKeyChainWithUserDic:userDic userId:userModel.userName];
        [defaults synchronize];
//        SuccessBlock(userModel,@"1");
    }else{
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        //ReqInfo
        NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
        password = [password MD5ForUpper32Bate];
        [reqinfoDic setObject:username forKey:@"username"];
        [reqinfoDic setObject:password forKey:@"password"];
        [reqinfoDic setObject:@"01" forKey:@"isMd5"];
        [reqinfoDic setObject:@"01" forKey:@"isNew"];
        NSString *deviceToken = [Tool getDeviceToken];
        if (deviceToken.length < 2) {
            deviceToken = @"123456";
        }
        [reqinfoDic setObject:deviceToken forKey:@"deviceToken"];
        [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
        [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.l001.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
        //把参数字典转换成JSON字符串
//        NSString *jsonStr = [Tool JSONString:dataDic];
        NetworkRequest *request = [[NetworkRequest alloc]init];
        
//        [request appendBodyParma:@"msg" value:jsonStr];
        [request setParmaBodyWithParma:dataDic];
        //    request.isHttps = YES;
        request.requestMethod = @"POST";
        [request requestWithSuccessBlock:^(id responseObject) {
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",dic);
            SysHeadModel *sysHeadModel = [SysHeadModel yy_modelWithJSON:[dic objectForKey:@"SYS_HEAD"]];
            if ([sysHeadModel.ReturnCode isEqualToString:@"00"]) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                UserDataModel *userModel = [UserDataModel sharedUserDataModel];
                NSDictionary *RespInfo = [dic objectForKey:@"RespInfo"];
                NSString *mechanismIndex = [RespInfo objectForKey:@"userName"];
                if ([defaults objectForKey:mechanismIndex] && [[defaults objectForKey:mechanismIndex] length] > 0) {
                    //不变
                }else{
                    [defaults setObject:@"0" forKey:mechanismIndex];
                }
                [userModel setValuesForKeysWithDictionary:RespInfo];
                //            NSDictionary *userDic = [userModel yy_modelToJSONObject];
                [defaults setObject:@"1" forKey:LOGIN];
                //                [defaults setObject:dic forKey:USERMODEL];
                [Tool saveUserDicKeyChainWithUserDic:RespInfo userId:userModel.userName];
                [defaults synchronize];
                SuccessBlock(userModel,sysHeadModel);
            }else{
                SuccessBlock(nil,sysHeadModel);
            }
            
            
        } failedBlock:^(NSError *error) {
            
            failedBlock(error);
        }];
    }
    
}
/**
 *  推送信息查询
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */

- (void)checkMessageWithSuccessBlock:(void (^)(NSMutableArray *messageModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    if ([netWork isEqualToString:@"1"]) {
        NSDictionary *dic = @{@"messages":@[@{@"id":@"1",@"message":@"BWM 最新版X10000上市，更大商场有售",@"title":@"通知"}]};
        
        NSArray *messageArr = [dic objectForKey:@"messages"];
        NSMutableArray *messageModelArr = [NSMutableArray array];
        if (![messageArr isKindOfClass:[NSNull class]]) {
            for (NSDictionary *messageDic in messageArr) {
                MessageModel *messageModel = [MessageModel yy_modelWithDictionary:messageDic];
                [messageModelArr addObject:messageModel];
            }
        }
        SuccessBlock(messageModelArr);
    }else{
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        //ReqInfo
        NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
        
        [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
        [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.m001.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
        //把参数字典转换成JSON字符串
//        NSString *jsonStr = [Tool JSONString:dataDic];
        NetworkRequest *request = [[NetworkRequest alloc]init];
        
//        [request appendBodyParma:@"msg" value:jsonStr];
        [request setParmaBodyWithParma:dataDic];
        //    request.isHttps = YES;
        request.requestMethod = @"POST";
        
        [request requestWithSuccessBlock:^(id responseObject) {
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",dic);
            NSArray *messageArr = [dic objectForKey:@"messages"];
            NSMutableArray *messageModelArr = [NSMutableArray array];
            if (![messageArr isKindOfClass:[NSNull class]]) {
                for (NSDictionary *messageDic in messageArr) {
                    MessageModel *messageModel = [MessageModel yy_modelWithDictionary:messageDic];
                    [messageModelArr addObject:messageModel];
                }
            }
            SuccessBlock(messageModelArr);
        } failedBlock:^(NSError *error) {
            failedBlock(error);
        }];
    }
    
}
/**
 *  修改密码
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */

- (void)revisePassworderWithUserName:(NSString *)userName NewPassworder:(NSString *)newPassworder SuccessBlock:(void (^)(BOOL state))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:userName forKey:@"username"];
    [reqinfoDic setObject:newPassworder forKey:@"password"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.l001.02" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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
        BOOL result = [dic objectForKey:@"result"];
        SuccessBlock(result);
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}

/**
 *  意见反馈
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */

- (void)feedbackWithUserCode:(NSString *)userCode content:(NSString *)content opinionType:(NSString *)opinionType SuccessBlock:(void (^)(NSDictionary *resultDic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:userCode forKey:@"userCode"];
    [reqinfoDic setObject:content forKey:@"content"];
    [reqinfoDic setObject:opinionType forKey:@"opinionType"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.f001.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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
