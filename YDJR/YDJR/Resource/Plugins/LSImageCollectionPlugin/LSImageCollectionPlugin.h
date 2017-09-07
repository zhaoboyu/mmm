//
//  LSImageCollectionPlugin.h
//  YDJR
//
//  Created by 李爽 on 2017/3/16.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

/**
 影像采集插件
 */
@interface LSImageCollectionPlugin : CDVPlugin

- (void)imageCollection:(CDVInvokedUrlCommand *)command;

@end
