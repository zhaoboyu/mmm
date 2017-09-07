//
//  DBMangerHandlePlugin.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/30.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "DBMangerHandlePlugin.h"
#import "CTTXRequestServer+FileUpload.h"
#import "CTTXRequestServer+fileManger.h"
@interface DBMangerHandlePlugin ()
@property (nonatomic,copy)NSString *callbackId;
@end
@implementation DBMangerHandlePlugin
/**
 *  根据表单名字插入数据
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)insertTable:(CDVInvokedUrlCommand *)command
{
    self.callbackId = command.callbackId;
    __weak DBMangerHandlePlugin *weakself = self;
//    [self.commandDelegate runInBackground:^{
        if (command.arguments.count > 1) {
//            NSString *tableName = command.arguments[0];
            NSMutableDictionary *objectDic = [NSMutableDictionary dictionaryWithDictionary:command.arguments[1]];
            NSLog(@"需要上传文件信息:%@",objectDic);
            if (objectDic && ![objectDic isEqual:[NSNull class]]) {
                NSString *ObjectNo = [objectDic objectForKey:@"ObjectNo"];
                NSString *TypeNo = [objectDic objectForKey:@"TypeNo"];
                NSString *filePath = [objectDic objectForKey:@"filePath"];
                if (![ObjectNo isEqualToString:@"undefined"]) {
//                    [objectDic setObject:@"1" forKey:@"Type"];
                    //开始上传文件
                    UploadFileModel *fileModel = [[UploadFileModel alloc]init];
                    fileModel.filePath = filePath;
                    fileModel.ObjectNo = ObjectNo;
                    fileModel.TypeNo = TypeNo;
                    if ([Tool isExistWithImagePath:fileModel.filePath]) {
                        //上传文件
                        NSLog(@"开始上传文件!");
                        [[CTTXRequestServer shareInstance] fileUploadWithFileModel:fileModel WithSuccessBlock:^(NSString *ReturnCode) {
                            //上送成功
                            if ([ReturnCode isEqualToString:@"0"]) {
                                CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
                                [weakself.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                            }else{
                                CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
                                [weakself.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                            }
                            
                        } failedBlock:^(NSError *error) {
                            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
                            [weakself.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                        }];
                        
                    }else{
                        NSLog(@"文件不存在");
                        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"文件不存在"];
                        [weakself.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                    }

                }
                
            }
            
        }
//    }];
}


/**
 上传图片
 
 @param command 用来接收h5传过来的参数对象
 */
- (void)uploadFile:(CDVInvokedUrlCommand *)command
{
    self.callbackId = command.callbackId;
    if (command.arguments.count > 0) {
        //            NSString *tableName = command.arguments[0];
        NSMutableDictionary *objectDic = [NSMutableDictionary dictionaryWithDictionary:command.arguments[0]];
        NSLog(@"需要上传文件信息:%@",objectDic);
        if (objectDic && ![objectDic isEqual:[NSNull class]]) {
            NSString *businessID = [objectDic objectForKey:@"businessID"];
            NSString *typeNo = [objectDic objectForKey:@"typeNo"];
            NSString *operationType = [objectDic objectForKey:@"operationType"];
            NSString *productType = [objectDic objectForKey:@"productType"];
            NSString *filePath = [objectDic objectForKey:@"filePath"];
            if (![businessID isEqualToString:@"undefined"]) {
                //开始上传文件
                UploadFileModel *fileModel = [[UploadFileModel alloc]init];
                fileModel.filePath = filePath;
                fileModel.businessID = businessID;
                fileModel.operationType = operationType;
                fileModel.productType = productType;
                fileModel.TypeNo = typeNo;
                if ([Tool isExistWithImagePath:fileModel.filePath]) {
                    //上传文件
                    NSLog(@"开始上传文件!");
//                    [[CTTXRequestServer shareInstance] uploadImageFileWithFileModel:fileModel WithSuccessBlock:^(SysHeadModel *sysHeadModel) {
//                        if ([sysHeadModel.ReturnCode isEqualToString:@"0"]) {
//                            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
//                            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//                        }else{
//                            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
//                            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//                        }
//                    } failedBlock:^(NSError *error) {
//                        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
//                        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
//                    }];
                    [[CTTXRequestServer shareInstance] fileUploadImageFileWithFileModel:fileModel WithSuccessBlock:^(SysHeadModel *sysHeadModel) {
                        if ([sysHeadModel.ReturnCode isEqualToString:@"0"]) {
                            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
                            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                        }else{
                            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:sysHeadModel.ReturnMessage];
                            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                        }
                    } failedBlock:^(NSError *error) {
                        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
                        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
 
                    }];
                    
                }else{
                    NSLog(@"文件不存在");
                    CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"文件不存在"];
                    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                }
                
            }
            
        }
        
    }
}
@end
