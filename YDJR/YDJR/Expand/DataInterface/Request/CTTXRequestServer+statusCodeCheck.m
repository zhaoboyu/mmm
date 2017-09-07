//
//  CTTXRequestServer+statusCodeCheck.m
//  YDJR
//
//  Created by 李爽 on 2017/3/17.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+statusCodeCheck.h"
#import "MessageModel.h"
#import "MessageCenterViewModel.h"

@implementation CTTXRequestServer (statusCodeCheck)

/**
 状态码消息查询
 
 @param messageId 消息ID
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)checkStatusCodeMessageWithMessageId:(NSString *)messageId SuccessBlock:(void (^)(MessageModel *messageModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:messageId forKey:@"messageID"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.x001.02" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    
    NetworkRequest *request = [[NetworkRequest alloc]init];
    //    request.isRepeatRequest = YES;
    //    [request setIsSendNotification:YES noticeName:@"loadMessage"];
    [request setParmaBodyWithParma:dataDic];
    
    [request requestWithSuccessBlock:^(id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dic);
        NSDictionary *res = [dic objectForKey:@"RespInfo"];
        MessageModel *messageModel = [MessageModel yy_modelWithDictionary:res];
        messageModel.userName = [[UserDataModel sharedUserDataModel] userName];
        //缓存信息
        [MessageCenterViewModel updataMessageModelWithMessageModel:messageModel];
        //发通知更新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loadMessage" object:@"loadMessage"];
        });
        //[[NSNotificationCenter defaultCenter]postNotificationName:@"loadMessage" object:@"loadMessage"];
        SuccessBlock(messageModel);
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];
}


/**
 根据businessID和jumpType查询消息
 
 @param businessID 达分期订单ID
 @param jumpType 消息跳转类型
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)checkStatusCodeMessageWithBusinessID:(NSString *)businessID jumpType:(NSString *)jumpType SuccessBlock:(void (^)(MessageModel *messageModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:businessID forKey:@"businessID"];
    [reqinfoDic setObject:jumpType forKey:@"jumpType"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.x001.12" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    
    NetworkRequest *request = [[NetworkRequest alloc]init];
    //    request.isRepeatRequest = YES;
    //    [request setIsSendNotification:YES noticeName:@"loadMessage"];
    [request setParmaBodyWithParma:dataDic];
    
    [request requestWithSuccessBlock:^(id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dic);
        NSDictionary *res = [dic objectForKey:@"RespInfo"];
        MessageModel *messageModel = [MessageModel yy_modelWithDictionary:res];
        messageModel.userName = [[UserDataModel sharedUserDataModel] userName];
        //缓存信息
        [MessageCenterViewModel updataMessageModelWithMessageModel:messageModel];
        //发通知更新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"loadMessage" object:@"loadMessage"];
        });
        SuccessBlock(messageModel);
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];
}

/**
 客户基本信息查询
 
 @param customerID 客户ID
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)checkCustomerWithCustomerID:(NSString *)customerID SuccessBlock:(void (^)(NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    //测试用：66df1f53-cc63-44d4-afc3-f8bb3511d030
    [reqinfoDic setObject:customerID forKey:@"customerID"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.x001.03" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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
