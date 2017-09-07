//
//  LSScanLifePlugin.h
//  YDJR
//
//  Created by 李爽 on 2017/3/17.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

/**
 二维码扫描结果插件
 */
@interface LSScanLifePlugin : CDVPlugin

-(void)scanLife:(CDVInvokedUrlCommand *)command;

@end
