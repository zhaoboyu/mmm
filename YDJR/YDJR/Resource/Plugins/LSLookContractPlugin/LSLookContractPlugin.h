//
//  LSLookContractPlugin.h
//  YDJR
//
//  Created by 李爽 on 2017/3/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

/**
 查看合同插件
 */
@interface LSLookContractPlugin : CDVPlugin

-(void)lookContract:(CDVInvokedUrlCommand *)command;

@end
