//
//  LSContractInfoPlugin.h
//  YDJR
//
//  Created by 李爽 on 2017/3/7.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface LSContractInfoPlugin : CDVPlugin

/**
 生成以及提交合同PDF
 
 @param command 两个网页地址
 */
-(void)createAndSubmitContractPDF:(CDVInvokedUrlCommand *)command;

@end
