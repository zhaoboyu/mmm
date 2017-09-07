//
//  LSContractInfoPlugin.m
//  YDJR
//
//  Created by 李爽 on 2017/3/7.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LSContractInfoPlugin.h"
#import "HGBPromgressHud.h"
#import "LLFPDFManager.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "CTTXRequestServer+uploadContract.h"
#import "CTTXRequestServer+fileManger.h"
#import "NDHTMLtoPDF.h"

@interface LSContractInfoPlugin ()<NDHTMLtoPDFDelegate>


@property (nonatomic,strong)HGBPromgressHud *phud;
@property (nonatomic,copy)NSString *callbackId;
/**
 借款合同编号
 */
@property (nonatomic,copy)NSString *loanContractNo;
/**
 委托投保合同编号
 */
@property (nonatomic,copy)NSString *insuranceContractNo;
/**
 订单号
 */
@property (nonatomic,copy)NSString *businessID;

@property (nonatomic,weak)LSContractInfoPlugin *contractInfoPlugin;
@property (nonatomic,assign) int times;
@property (nonatomic, strong) NDHTMLtoPDF *PDFCreator;
@property (nonatomic, strong) NSString *insuranceContract;
@property(assign,nonatomic)NSInteger index;
@end

@implementation LSContractInfoPlugin

/**
 生成以及提交合同PDF
 
 @param command 两个网页地址
 */
-(void)createAndSubmitContractPDF:(CDVInvokedUrlCommand *)command
{
    self.callbackId = command.callbackId;
    [self.phud showHUDSaveAddedTo:self.webView];
    if (command.arguments.count >= 5) {
        self.times = 0;
        NSString *loanContract = command.arguments[0];
        self.insuranceContract = command.arguments[1];
        //借款合同编号
        self.businessID = command.arguments[2];
        //委托投保合同编号
        self.loanContractNo = command.arguments[3];
        //订单号
        self.insuranceContractNo = command.arguments[4];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL * url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:loanContract ofType:@"html"]];
            self.index=0;
//            self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:url
//                                                 pathForPDF:[@"~/Documents/loanContract.pdf" stringByExpandingTildeInPath]
//                                                   delegate:self
//                                                   pageSize:pagetype1
//                                                    margins:UIEdgeInsetsMake(10, 5, 10, 5)];
            self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:url
                                                 pathForPDF:[[NSString stringWithFormat:@"~/Documents/%@.pdf",self.loanContractNo] stringByExpandingTildeInPath]
                                                   delegate:self
                                                   pageSize:pagetype1
                                                    margins:UIEdgeInsetsMake(10, 5, 10, 5)];
            
        });
        
        
    }else{
        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
        [self.contractInfoPlugin.commandDelegate sendPluginResult:result callbackId:_callbackId];
    }
}
#pragma mark NDHTMLtoPDFDelegate

- (void)HTMLtoPDFDidSucceed:(NDHTMLtoPDF*)htmlToPDF
{
    NSString *result = [NSString stringWithFormat:@"HTMLtoPDF did succeed (%@ / %@)", htmlToPDF, htmlToPDF.PDFpath];
    NSLog(@"%@",result);
    dispatch_async(dispatch_get_main_queue(), ^{
        if(self.index==0){
            self.index=1;
            NSURL * url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:self.insuranceContract ofType:@"html"]];
//            self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:url
//                                                 pathForPDF:[@"~/Documents/insuranceContract.pdf" stringByExpandingTildeInPath]
//                                                   delegate:self
//                                                   pageSize:pagetype1
//                                                    margins:UIEdgeInsetsMake(10, 5, 10, 5)];
            self.PDFCreator = [NDHTMLtoPDF createPDFWithURL:url
                                                 pathForPDF:[[NSString stringWithFormat:@"~/Documents/%@.pdf",self.insuranceContractNo] stringByExpandingTildeInPath]
                                                   delegate:self
                                                   pageSize:pagetype1
                                                    margins:UIEdgeInsetsMake(10, 5, 10, 5)];
        }else{
            [self uploadContract];
        }
        
    });
    
    
}

- (void)HTMLtoPDFDidFail:(NDHTMLtoPDF*)htmlToPDF
{
    NSString *result = [NSString stringWithFormat:@"HTMLtoPDF did fail (%@)", htmlToPDF];
    NSLog(@"%@",result);
    
}

#pragma mark - 上传合同
-(void)uploadContract
{
    __weak LSContractInfoPlugin *weakself = self;
    

//    NSString *insuranceContractPDFPath = [LLFPDFManager pdfDestPath:self.insuranceContractNo];

//    NSString *loanContractPDFPath = [LLFPDFManager pdfDestPath:self.loanContractNo];
    //NSString *string = [[NSBundle mainBundle]pathForResource:@"test1" ofType:@"png"];
    //UIImage *image = [UIImage imageWithContentsOfFile:string];

    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    //businessID = 14906002325734288;
    //insuranceContractNo = "DFQOL201700063-2";
    //loanContractNo = "DFQOL201700063-1";
    [paramDic setValue:self.businessID forKey:@"businessID"];
    [paramDic setValue:self.loanContractNo forKey:@"loanContractNo"];
    [paramDic setValue:self.insuranceContractNo forKey:@"commissionContractNo"];
   // [paramDic setValue:loanContractBase64Encoded forKey:@"LoanImages"];
   //[paramDic setValue:insuranceContractBase64Encoded forKey:@"EntrustImages"];
    
    [[CTTXRequestServer shareInstance]uploadContractWithRequestParam:paramDic loanContractNoPath:[LLFPDFManager pdfDestPath:self.loanContractNo] commissionContractNoPath:[LLFPDFManager pdfDestPath:self.insuranceContractNo] SuccessBlock:^(NSDictionary *responseDict) {
        
        [weakself.phud hideSave];
        //删除文件
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *MapLayerDataPath1 = [LLFPDFManager pdfDestPath:self.insuranceContractNo];
        NSString *MapLayerDataPath2 = [LLFPDFManager pdfDestPath:self.loanContractNo];
        BOOL bRet = [fileMgr fileExistsAtPath:MapLayerDataPath1];
        if (bRet) {
            //
            NSError *err;
            [fileMgr removeItemAtPath:MapLayerDataPath1 error:&err];
        }
        BOOL bRet1 = [fileMgr fileExistsAtPath:MapLayerDataPath2];
        if (bRet1) {
            //
            NSError *err;
            [fileMgr removeItemAtPath:MapLayerDataPath2 error:&err];
        }
        //
        NSString *ReturnCode = [NSString stringWithFormat:@"%@",[[responseDict objectForKey:@"SYS_HEAD"] objectForKey:@"ReturnCode"]];
        if ([ReturnCode isEqualToString:@"0"]) {
            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"0"];
            [weakself.commandDelegate sendPluginResult:result callbackId:self.callbackId];
            weakself.phud.promptStr = @"合同上传成功!";
            [weakself.phud showHUDResultAddedTo:self.webView];
            [[UIViewController currentViewController]dismissToViewSpecifiedController];
        }else{
            [weakself.phud hideSave];
            weakself.phud.promptStr = [responseDict[@"SYS_HEAD"] objectForKey:@"ReturnMessage"];
            [weakself.phud showHUDResultAddedTo:self.webView];
            
        }
    } failedBlock:^(NSError *error) {
        
        [weakself.phud hideSave];
        weakself.phud.promptStr = @"网络状况不好,请稍后重试!";
        [weakself.phud showHUDResultAddedTo:self.webView];
        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
        [weakself.commandDelegate sendPluginResult:result callbackId:_callbackId];
    }];
    
 /* [[CTTXRequestServer shareInstance]uploadContractWithRequestParam:paramDic
                                                        SuccessBlock:^(NSDictionary *responseDict) {
                                                            [weakself.phud hideSave];
                                                            //删除文件
                                                            NSFileManager *fileMgr = [NSFileManager defaultManager];
                                                            NSString *MapLayerDataPath1 = [LLFPDFManager pdfDestPath:@"insuranceContract"];
                                                            NSString *MapLayerDataPath2 = [LLFPDFManager pdfDestPath:@"loanContract"];
                                                            BOOL bRet = [fileMgr fileExistsAtPath:MapLayerDataPath1];
                                                            if (bRet) {
                                                                //
                                                                NSError *err;
                                                                [fileMgr removeItemAtPath:MapLayerDataPath1 error:&err];
                                                            }
                                                            BOOL bRet1 = [fileMgr fileExistsAtPath:MapLayerDataPath2];
                                                            if (bRet1) {
                                                                //
                                                                NSError *err;
                                                                [fileMgr removeItemAtPath:MapLayerDataPath2 error:&err];
                                                            }
                                                            //
                                                            NSString *ReturnCode = [NSString stringWithFormat:@"%@",[[responseDict objectForKey:@"SYS_HEAD"] objectForKey:@"ReturnCode"]];
                                                            if ([ReturnCode isEqualToString:@"0"]) {
                                                                CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"0"];
                                                                [weakself.commandDelegate sendPluginResult:result callbackId:self.callbackId];
                                                                weakself.phud.promptStr = @"合同上传成功!";
                                                                [weakself.phud showHUDResultAddedTo:self.webView];
                                                                [[UIViewController currentViewController]dismissToViewSpecifiedController];
                                                            }else{
                                                                [weakself.phud hideSave];
                                                                weakself.phud.promptStr = [responseDict[@"SYS_HEAD"] objectForKey:@"ReturnMessage"];
                                                                [weakself.phud showHUDResultAddedTo:self.webView];
                                                                
                                                            }
                                                        } failedBlock:^(NSError *error) {
                                                            [weakself.phud hideSave];
                                                            weakself.phud.promptStr = @"网络状况不好,请稍后重试!";
                                                            [weakself.phud showHUDResultAddedTo:self.webView];
                                                            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
                                                            [weakself.commandDelegate sendPluginResult:result callbackId:_callbackId];
                                                        }];
  */
    
    
}

#pragma mark - get
-(HGBPromgressHud *)phud
{ 
    if(_phud == nil){
        _phud = [[HGBPromgressHud alloc]init];
    }
    return _phud;
}

@end
