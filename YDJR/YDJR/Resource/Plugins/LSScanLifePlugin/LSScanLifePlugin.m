//
//  LSScanLifePlugin.m
//  YDJR
//
//  Created by 李爽 on 2017/3/17.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LSScanLifePlugin.h"

@implementation LSScanLifePlugin

-(void)scanLife:(CDVInvokedUrlCommand *)command
{
	NSMutableDictionary *dafenqiDic = [[[NSUserDefaults standardUserDefaults]objectForKey:@"dafenqiDic"] mutableCopy];
	[dafenqiDic setValue:[Tool getMechinsId] forKey:@"mechanismID"];
	[dafenqiDic setValue:[Tool getMechanismQName] forKey:@"mechanismName"];
	
	//客户类型
	[dafenqiDic setValue:@"IDFS000046" forKey:@"customerTypeDict"];
	//性别
	[dafenqiDic setValue:@"IDFS000035" forKey:@"customerSexDict"];
	//[dafenqiDic setValue:@"01" forKey:@"idsType"];
	
	//证件类别
	[dafenqiDic setValue:@"IDFS000210" forKey:@"credentialsType"];
	//按揭机构
	[dafenqiDic setValue:@"IDFS000326" forKey:@"ajjg"];
	//保险公司名称
	[dafenqiDic setValue:@"IDFS000327" forKey:@"bxgsmc"];  
	//银行机构列表
	[dafenqiDic setValue:@"IDFS000328" forKey:@"yhjglb"];
    //达分期保险年限
    [dafenqiDic setValue:@"IDFS000337" forKey:@"dfqlyear"];
	
	CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dafenqiDic];
	[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
