//
//  SDCCutomerIntrestInfoPlugin.h
//  YDJR
//
//  Created by sundacheng on 16/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface SDCCutomerIntrestInfoPlugin : CDVPlugin

/**
 *  用户意向单传值
 *
 *  @param command CDVInvokedUrlCommand
 */
- (void)customerIntrestInfoPass:(CDVInvokedUrlCommand *)command;

@end
