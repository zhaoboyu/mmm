//
//  LookApplyPlugin.m
//  YDJR
//
//  Created by 吕利峰 on 16/11/16.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LookApplyPlugin.h"

@implementation LookApplyPlugin
/**
 *  获取该订单的意向单id和产品id
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)LookApply:(CDVInvokedUrlCommand *)command
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults objectForKey:@"lookApply"];
    CDVPluginResult *result;
    if (dic) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dic];
    }else{
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
    }
    [self.commandDelegate sendPluginResult: result callbackId:command.callbackId];
}
@end
