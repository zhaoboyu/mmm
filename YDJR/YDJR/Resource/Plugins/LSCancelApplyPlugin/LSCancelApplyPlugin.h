//
//  LSCancelApplyPlugin.h
//  YDJR
//
//  Created by 李爽 on 2017/3/19.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

/**
 取消申请插件
 */
@interface LSCancelApplyPlugin : CDVPlugin

-(void)cancelApply:(CDVInvokedUrlCommand *)command;

@end
