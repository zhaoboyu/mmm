//
//  SDCCutomerIntrestInfoPlugin.m
//  YDJR
//
//  Created by sundacheng on 16/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDCCutomerIntrestInfoPlugin.h"

@implementation SDCCutomerIntrestInfoPlugin

- (void)customerIntrestInfoPass:(CDVInvokedUrlCommand *)command {
    
//    NSArray *array = [NSFileManager loadArrayFromPath:DirectoryTypeDocuments withFilename:@"customIntrestInfo"];
//    NSArray *array = @[@"宝马",@"5",@"df1596ea-d581-464a-9418-27cf3c058f3c",@"1999",@"达分期",@"1",@"2",@"0"];
    
//    NSLog(@"customIntrestInfoArray %@",array);
    NSMutableArray *array = [Tool getIntentValueArr];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:array];
    
    [self.commandDelegate sendPluginResult: result callbackId:command.callbackId];
}

@end
