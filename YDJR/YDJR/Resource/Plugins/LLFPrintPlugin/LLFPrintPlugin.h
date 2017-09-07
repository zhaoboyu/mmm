//
//  LLFPrintPlugin.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/18.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface LLFPrintPlugin : CDVPlugin
/**
 *  打印文件
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)printFile:(CDVInvokedUrlCommand *)command;
@end
