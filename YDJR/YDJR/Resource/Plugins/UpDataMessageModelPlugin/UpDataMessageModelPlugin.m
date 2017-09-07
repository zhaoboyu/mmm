//
//  UpDataMessageModelPlugin.m
//  YDJR
//
//  Created by 吕利峰 on 2017/4/1.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "UpDataMessageModelPlugin.h"
#import "MessageModel.h"
#import "MessageCenterViewModel.h"
@interface UpDataMessageModelPlugin ()
@property (nonatomic,copy)NSString *callbackId;
@property (nonatomic,copy)NSString *messageId;
@end

@implementation UpDataMessageModelPlugin
/**
 *  更新消息
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)upDataMessageModel:(CDVInvokedUrlCommand *)command
{
    self.callbackId = command.callbackId;
    if (command.arguments.count > 0) {
        self.messageId = command.arguments[0];
        MessageModel *messageModel = [MessageCenterViewModel queryMessageModelWithMessageId:self.messageId];
        messageModel.isHandle = YES;
        BOOL result;
        if (messageModel) {
            result  = [MessageCenterViewModel updataMessageModelWithMessageModel:messageModel];
        }else{
            result = NO;
        }
       
        if (result) {
            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"消息更新成功!"];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }else{
            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"消息更新失败!"];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }else{
        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数传输失败!"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
    
}
@end
