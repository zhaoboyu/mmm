//
//  LSImageCollectionPlugin.m
//  YDJR
//
//  Created by 李爽 on 2017/3/16.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LSImageCollectionPlugin.h"

@implementation LSImageCollectionPlugin

- (void)imageCollection:(CDVInvokedUrlCommand *)command
{

	NSDictionary *dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"StatusCodeRM"];
	//NSDictionary *dict = @{@"businessID":@"1111",@"jumpType":@"01",@"iamgelist":@[@{@"iamgeUrl":@"test",@"imageName":@"法人基本资料",@"imageId":@"0001"},@{@"iamgeUrl":@"test",@"imageName":@"身份证明",@"imageId":@"1100"}]};
	//影像代码 上传影像 影像类型typeno
	CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
	[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
