//
//  LLFCheckDataListPlugin.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface LLFCheckDataListPlugin : CDVPlugin
/**
 *	@brief	获取数据字典插件
 *
 */
- (void)checkDataList:(CDVInvokedUrlCommand *)command;
@end
