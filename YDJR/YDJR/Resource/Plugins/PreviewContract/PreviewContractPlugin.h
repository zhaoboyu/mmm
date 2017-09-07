//
//  PreviewContractPlugin.h
//  YDJR
//
//  Created by 吕利峰 on 2017/4/28.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface PreviewContractPlugin : CDVPlugin
/**
 *  预览借款合同和委托合同
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)PreviewContract:(CDVInvokedUrlCommand *)command;
@end
