//
//  GetUserModelInfoPlugin.m
//  YDJR
//
//  Created by 吕利峰 on 16/12/1.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "GetUserModelInfoPlugin.h"

@implementation GetUserModelInfoPlugin
/**
 *  获取当前登录用户的信息和客户信息
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)getUserModelInfo:(CDVInvokedUrlCommand *)command
{
    //当前客户的信息
    NSDictionary *customerInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"customerInfo"];
    NSLog(@"当前客户信息customerInfo:%@",customerInfo);
    //当前登录客户的信息
//    UserDataModel *userModel = [UserDataModel sharedUserDataModel];
//    userModel.mechanismID = [Tool getMechinsId];
//    userModel.mechanismQName = [Tool getMechanismQName];
    NSMutableDictionary *userInfo = [[[UserDataModel sharedUserDataModel] yy_modelToJSONObject] mutableCopy];
    [userInfo setObject:[Tool getMechinsId] forKey:@"mechanismID"];
    [userInfo setObject:[Tool getMechanismName] forKey:@"mechanismName"];
    [userInfo setObject:[Tool getMechanismQName] forKey:@"mechanismQName"];
    NSLog(@"当前登录用户的信息userInfo:%@",userInfo);
    
    NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
    [resultDic setObject:customerInfo forKey:@"customerInfo"];
    [resultDic setObject:userInfo forKey:@"userInfo"];
    
    
    CDVPluginResult *result;
    if (resultDic) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDic];
    }else{
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
    }
    [self.commandDelegate sendPluginResult: result callbackId:command.callbackId];
}
@end
