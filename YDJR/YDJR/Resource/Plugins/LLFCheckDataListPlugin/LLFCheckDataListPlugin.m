//
//  LLFCheckDataListPlugin.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCheckDataListPlugin.h"
@interface LLFCheckDataListPlugin ()
@property (nonatomic,copy)NSString *callbackId;

@end
@implementation LLFCheckDataListPlugin
/**
 *	@brief	获取数据字典插件
 *
 */
- (void)checkDataList:(CDVInvokedUrlCommand *)command
{
    self.callbackId = command.callbackId;
    __weak LLFCheckDataListPlugin *weakself = self;
    [self.commandDelegate runInBackground:^{
        if (command.arguments.count > 0) {
            NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
            NSArray *keyIDArr = command.arguments[0];
            NSMutableArray *resultArr = [NSMutableArray array];
            for (int i = 0; i < keyIDArr.count; i++) {
                NSString *keyID = keyIDArr[i];
                if (tempArr.count > 0) {
                    NSDictionary *dic = tempArr[0];
                    NSArray *dataArr = [dic objectForKey:keyID];
                    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
                    if (dataArr) {
                        [dataDic setObject:dataArr forKey:@"msg"];
                    }
                    [resultArr addObject:dataDic];
                }
                

            }
            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:resultArr];
            [weakself.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            
        }else{
            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
            [weakself.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }
    }];
}
@end
