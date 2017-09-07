//
//  PreviewContractPlugin.m
//  YDJR
//
//  Created by 吕利峰 on 2017/4/28.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "PreviewContractPlugin.h"
#import "PreviewContractPopView.h"

@interface PreviewContractPlugin ()<PreviewContractPopViewDelegate>
@property (nonatomic,copy)NSString *callbackId;

@end

@implementation PreviewContractPlugin
/**
 *  预览借款合同和委托合同
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)PreviewContract:(CDVInvokedUrlCommand *)command
{
    self.callbackId = command.callbackId;
    if ([command.arguments count] > 3) {
        NSString *businessID = command.arguments[0];
        NSString *typeNo = command.arguments[1];
        NSString *operationType = command.arguments[2];
        NSString *imageName = command.arguments[3];
        PreviewContractPopView *preViewContra = [[PreviewContractPopView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) businessID:businessID typeNo:typeNo operationType:operationType imageName:imageName];
        preViewContra.deleate = self;
        [self.webView addSubview:preViewContra];
    }
    //@param businessID 订单号
    //@param typeNo 影像代码
    //@param operationType 操作类型
   // @param imageName 合同号
    
    
}
- (void)clickWithType:(NSString *)type
{
    if ([type isEqualToString:@"1"]) {
        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"0"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    }else{
        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"error"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    }
}
@end
