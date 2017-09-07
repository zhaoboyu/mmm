//
//  LLFNetworkPlugin.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFNetworkPlugin.h"
#import "AppDelegate.h"
@interface LLFNetworkPlugin ()
@property (nonatomic,copy)NSString *callbackId;
@property (nonatomic,strong)HGBPromgressHud *phud;
@end
@implementation LLFNetworkPlugin
/**
 *	@brief	网络请求插件
 *
 */
- (void)network:(CDVInvokedUrlCommand *)command
{
    self.callbackId = command.callbackId;
    __weak LLFNetworkPlugin *weakself = self;
//    [self.commandDelegate runInBackground:^{
        if (command.arguments.count > 2) {
            NSString *method = command.arguments[0];
            NSDictionary *reqInfoDic = command.arguments[1];
			//[reqInfoDic setValue:@"123" forKey:@"images"];
            NSString *TransServiceCode = command.arguments[2];
            
            NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
            //ReqInfo
            
            [dataDic setObject:reqInfoDic forKey:@"ReqInfo"];
            [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:TransServiceCode Contrast:reqInfoDic] forKey:@"SYS_HEAD"];
            //把参数字典转换成JSON字符串
//            NSString *jsonStr = [Tool JSONString:dataDic];
            NetworkRequest *request = [[NetworkRequest alloc]init];
//            [request appendBodyParma:@"msg" value:jsonStr];
            [request setParmaBodyWithParma:dataDic];
            if ([method isEqualToString:@"GET"]) {
                request.requestMethod = @"GET";
            }else{
                request.requestMethod = @"POST";
            }
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            //[self.phud showHUDSaveAddedTo:appDelegate.window];
            [request requestWithSuccessBlock:^(id responseObject) {
//                [self.phud hideSave];
                NSError *error = nil;
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                NSLog(@"%@%@",error,dic);
                CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dic];
                [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            } failedBlock:^(NSError *error) {
//                [self.phud hideSave];
//                self.phud.promptStr = @"网络状况不好...请稍后重试!";
//                [self.phud showHUDResultAddedTo:appDelegate.window];
                CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
                [weakself.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                NSLog(@"error:%@",error);
            }];
            
        }else{
            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
            [weakself.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
//    }];
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}
@end
