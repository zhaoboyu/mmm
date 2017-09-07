//
//  BackToNativePlugin.h
//  CTTX
//
//  Created by 吕利峰 on 16/5/27.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Cordova/CDV.h>

@interface BackToNativePlugin : CDVPlugin
@property (nonatomic,copy)NSString *callBackId;

/**
 *  返回原声界面插件
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)backToNatiove:(CDVInvokedUrlCommand *)command;
@end
