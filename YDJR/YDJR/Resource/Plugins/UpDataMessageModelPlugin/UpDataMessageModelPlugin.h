//
//  UpDataMessageModelPlugin.h
//  YDJR
//
//  Created by 吕利峰 on 2017/4/1.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface UpDataMessageModelPlugin : CDVPlugin
/**
 *  更新消息
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)upDataMessageModel:(CDVInvokedUrlCommand *)command;
@end
