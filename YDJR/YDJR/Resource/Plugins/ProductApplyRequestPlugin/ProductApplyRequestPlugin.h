//
//  ProductApplyRequestPlugin.h
//  YDJR
//
//  Created by 吕利峰 on 2017/4/5.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface ProductApplyRequestPlugin : CDVPlugin
/**
 *  创建产品申请
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)productApplyRequest:(CDVInvokedUrlCommand *)command;
/**
 *  计算自动适配字段
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)calculationDictionary:(CDVInvokedUrlCommand *)command;
@end
