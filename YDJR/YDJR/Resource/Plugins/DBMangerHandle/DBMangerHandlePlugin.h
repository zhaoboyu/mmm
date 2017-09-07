//
//  DBMangerHandlePlugin.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/30.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface DBMangerHandlePlugin : CDVPlugin
/**
 *  根据表单名字插入数据
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)insertTable:(CDVInvokedUrlCommand *)command;

/**
 上传图片

 @param command 用来接收h5传过来的参数对象
 */
- (void)uploadFile:(CDVInvokedUrlCommand *)command;
@end
