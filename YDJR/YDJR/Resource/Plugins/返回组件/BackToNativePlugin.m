//
//  BackToNativePlugin.m
//  CTTX
//
//  Created by 吕利峰 on 16/5/27.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "BackToNativePlugin.h"
#import "AppDelegate.h"
#import "MainViewController.h"
@implementation BackToNativePlugin
/**
 *  返回原声界面插件
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)backToNatiove:(CDVInvokedUrlCommand *)command
{
    self.callBackId = command.callbackId;

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    appDelegate.window.rootViewController = (UIViewController *)appDelegate.rootVC;
    MainViewController *mainVC = appDelegate.mainVC;
    [mainVC dismissViewControllerAnimated:YES completion:nil];
    [Tool cleanCacheAndCookie];
    CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

    
//    UserDataModel *userDataModel = [UserDataModel sharedUserDataModel];
//    if (userDataModel.isLogin) {
//        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:USERMODEL];
//        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dic];
//        [self.commandDelegate sendPluginResult:result callbackId:_callBackId];
//    }else{
//        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"未登录"];
//        [self.commandDelegate	sendPluginResult:result callbackId:_callBackId];
//    }

}
@end
