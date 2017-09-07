//
//  LLFPrintPlugin.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/18.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFPrintPlugin.h"
#import "MainViewController.h"
#import "AppDelegate.h"

@interface LLFPrintPlugin ()<UIPrintInteractionControllerDelegate>
@property (nonatomic,copy)NSString *callbackId;
@end
@implementation LLFPrintPlugin
/**
 *  打印文件
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)printFile:(CDVInvokedUrlCommand *)command
{
    self.callbackId = command.callbackId;
    
    if (command.arguments.count > 1) {
        NSString *htmlName = command.arguments[0];
        
        NSString *parmStr = command.arguments[1];
        NSDictionary *parmDic = [Tool dictionaryWithJsonString:parmStr];
        NSLog(@"打印界面传值参数:%@",parmDic);
        BOOL isNull = YES;
        //        for (NSString *key in [parmDic allKeys]) {
        //            NSString *value = [parmDic objectForKey:key];
        //            if (value && value.length > 0) {
        //                isNull = YES;
        //            }else{
        //                if ([key isEqualToString:@"InvoiceSendAddress"] || [key isEqualToString:@"InvoiceAddTel"] || [key isEqualToString:@"InvoiceAccount"] || [key isEqualToString:@"InvoiceHeader"]) {
        //                    isNull = YES;
        //                }else{
        //                    isNull = NO;
        //                }
        //
        //                break;
        //            }
        //        }
        

        if (isNull) {
            MainViewController *applyMainVC = [[MainViewController alloc]init];
            
            applyMainVC.startPage = [Tool getWWWPackAddressWithIndexName:htmlName];
            applyMainVC.isHaveTop = YES;
            YDJRNavigationViewController *applyMianNC = [[YDJRNavigationViewController alloc]initWithRootViewController:applyMainVC];
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            MainViewController *mainVC = appDelegate.mainVC;
//            [UserDataModel sharedUserDataModel].flag = 0;
            [mainVC presentViewController:applyMianNC animated:YES completion:nil];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"必输字段未填写完整,请检查后重新尝试!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
        }
        
        
    }else{
        MainViewController *applyMainVC = [[MainViewController alloc]init];
        //        NSString *htmlName = command.arguments[0];
        
        applyMainVC.startPage = [Tool getWWWPackAddressWithIndexName:@"enterprise_table.html"];
        applyMainVC.isHaveTop = YES;
        UINavigationController *applyMianNC = [[UINavigationController alloc]initWithRootViewController:applyMainVC];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MainViewController *mainVC = appDelegate.mainVC;
        [mainVC presentViewController:applyMianNC animated:YES completion:nil];
    }
    
}
@end
