//
//  GetUserModelInfoPlugin.h
//  YDJR
//
//  Created by 吕利峰 on 16/12/1.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface GetUserModelInfoPlugin : CDVPlugin
/**
 *  获取当前登录用户的信息和客户信息
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)getUserModelInfo:(CDVInvokedUrlCommand *)command;
@end
