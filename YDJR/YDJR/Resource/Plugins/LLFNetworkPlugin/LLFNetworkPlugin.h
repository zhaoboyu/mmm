//
//  LLFNetworkPlugin.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface LLFNetworkPlugin : CDVPlugin
/**
 *	@brief	网络请求插件
 *
 */
- (void)network:(CDVInvokedUrlCommand *)command;
@end
