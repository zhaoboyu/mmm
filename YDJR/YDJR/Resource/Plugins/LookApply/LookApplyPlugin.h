//
//  LookApplyPlugin.h
//  YDJR
//
//  Created by 吕利峰 on 16/11/16.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface LookApplyPlugin : CDVPlugin
/**
 *  获取该订单的意向单id和产品id
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)LookApply:(CDVInvokedUrlCommand *)command;
@end
