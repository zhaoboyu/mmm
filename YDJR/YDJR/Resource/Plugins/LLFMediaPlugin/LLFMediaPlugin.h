//
//  LLFMediaPlugin.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/6.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface LLFMediaPlugin : CDVPlugin
/**
 *	@brief	调用媒体库
 *
 */
- (void)media:(CDVInvokedUrlCommand *)command;
@end
