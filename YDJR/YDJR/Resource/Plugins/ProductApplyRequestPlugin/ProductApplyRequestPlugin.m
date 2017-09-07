//
//  ProductApplyRequestPlugin.m
//  YDJR
//
//  Created by 吕利峰 on 2017/4/5.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "ProductApplyRequestPlugin.h"
@interface ProductApplyRequestPlugin ()
@property (nonatomic,copy)NSString *callbackId;

/**
 项目总额
 */
@property (nonatomic,copy)NSString *totalMoney;

/**
 融资金额
 */
@property (nonatomic,copy)NSString *BusinessSum;

/**
 是否需要计算手续费
 */
@property (nonatomic,assign)BOOL isCalculation;
@end
@implementation ProductApplyRequestPlugin
/**
 *  创建产品申请
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)productApplyRequest:(CDVInvokedUrlCommand *)command
{
    self.callbackId = command.callbackId;
    self.isCalculation = NO;
    if (command.arguments.count > 1) {
        NSDictionary *reqInfoDic = command.arguments[0];
        NSString *TransServiceCode = command.arguments[1];
        
        if (command.arguments.count > 2) {
            self.totalMoney = command.arguments[2];
        }
        reqInfoDic = [self setReqInfoWithDic:reqInfoDic];
        
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        //ReqInfo
        
        [dataDic setObject:reqInfoDic forKey:@"ReqInfo"];
        [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:TransServiceCode Contrast:reqInfoDic] forKey:@"SYS_HEAD"];
        NetworkRequest *request = [[NetworkRequest alloc]init];
        [request setParmaBodyWithParma:dataDic];
        [request requestWithSuccessBlock:^(id responseObject) {
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@%@",error,dic);
            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dic];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        } failedBlock:^(NSError *error) {
            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }];
        
    }else{
        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
}
- (NSMutableDictionary *)setReqInfoWithDic:(NSDictionary *)dic
{
    NSMutableDictionary *reqInfo = [[NSMutableDictionary dictionaryWithDictionary:dic] mutableCopy];
    NSMutableDictionary *obj_Mesage = [NSMutableDictionary dictionaryWithDictionary:[reqInfo objectForKey:@"obj_Mesage"]];
    NSString *BusinessType = [obj_Mesage objectForKey:@"BusinessType"];
    if ([BusinessType isEqualToString:@"030"] || [BusinessType isEqualToString:@"031"]) {
        //报价方案
        NSString *ProductPlan = [obj_Mesage objectForKey:@"ProductPlan"];
        //融资期限
        NSString *BusinessTerm = [obj_Mesage objectForKey:@"BusinessTerm"];
        //融资金额
        self.BusinessSum = [obj_Mesage objectForKey:@"BusinessSum"];
        //保证金比例
        NSString *BZJPercent = [obj_Mesage objectForKey:@"BZJPercent"];
        obj_Mesage = [self makeReqInfoWithReqInfo:obj_Mesage ProductPlan:ProductPlan BusinessTerm:BusinessTerm BZJPercent:BZJPercent];
        [reqInfo setObject:obj_Mesage forKey:@"obj_Mesage"];
        return reqInfo;
    }else{
        return reqInfo;
    }
}
/**
 *  计算自动适配字段
 *
 *  @param command 用来接收h5传过来的参数对象
 */
- (void)calculationDictionary:(CDVInvokedUrlCommand *)command
{
    self.callbackId = command.callbackId;
    self.isCalculation = YES;
    if (command.arguments.count > 1) {
        NSDictionary *reqInfoDic = command.arguments[0];
        NSMutableDictionary *reqInfo = [[NSMutableDictionary dictionaryWithDictionary:reqInfoDic] mutableCopy];
        self.totalMoney = command.arguments[1];
        //报价方案
        NSString *ProductPlan = [reqInfo objectForKey:@"ProductPlan"];
        //融资期限
        NSString *BusinessTerm = [reqInfo objectForKey:@"BusinessTerm"];
        //融资金额
        self.BusinessSum = [reqInfo objectForKey:@"BusinessSum"];
        //保证金比例
        NSString *BZJPercent = [reqInfo objectForKey:@"BZJPercent"];
        reqInfo = [self makeReqInfoWithReqInfo:reqInfo ProductPlan:ProductPlan BusinessTerm:BusinessTerm BZJPercent:BZJPercent];
        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:reqInfo];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }else{
        CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }
}
- (NSMutableDictionary *)makeReqInfoWithReqInfo:(NSMutableDictionary *)reqInfo ProductPlan:(NSString *)ProductPlan BusinessTerm:(NSString *)BusinessTerm BZJPercent:(NSString *)BZJPercent
{
    if ([ProductPlan isEqualToString:@"01"]) {
        //01-2017-标准产品
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"5.00" BusinessRate:@"0.00" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"8.41" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"8.11" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
        
    }else if ([ProductPlan isEqualToString:@"02"]){
        //02-体系外-标准产品
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"6.00" BusinessRate:@"0.00" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"12.00" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"12.50" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
        
    }else if ([ProductPlan isEqualToString:@"03"]){
        
        //03-体系外-二手车产品
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"6.00" BusinessRate:@"-" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"10.00" BusinessRate:@"-" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"13.00" BusinessRate:@"-" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
        
    }else if ([ProductPlan isEqualToString:@"04"]){
        //04-BMW-12期免息产品
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"0.00" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }
        
    }else if ([ProductPlan isEqualToString:@"05"]){
        //05-体系外-森那美
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"9.00" BusinessRate:@"-" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"15.00" BusinessRate:@"-" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"21.00" BusinessRate:@"-" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
        
    }else if ([ProductPlan isEqualToString:@"06"]){
        //06-试乘试驾
        if ([BusinessTerm isEqualToString:@"6"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"2.88" BusinessRate:@"-" InstallGPS:@"0" GPSCount:@"-" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"03" TransferFeeUnderTaker:@"02" DoGuaranty:@"0" GuarantyFeeUnderTaker:@"02" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"12"]){
            if ([BZJPercent isEqualToString:@"0"]) {
                return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"7.00" BusinessRate:@"-" InstallGPS:@"0" GPSCount:@"-" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"03" TransferFeeUnderTaker:@"02" DoGuaranty:@"0" GuarantyFeeUnderTaker:@"02" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            }else if ([BZJPercent isEqualToString:@"10"]){
                return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"5.50" BusinessRate:@"-" InstallGPS:@"0" GPSCount:@"-" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"03" TransferFeeUnderTaker:@"02" DoGuaranty:@"0" GuarantyFeeUnderTaker:@"02" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            }
            
        }
        
    }else if ([ProductPlan isEqualToString:@"07"]){
        //07-奥迪新车
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"0.00" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"02" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"02" RRPercent:[NSString stringWithFormat:@"%f",1 / [self.totalMoney floatValue] * 100] RRAmount:@"1" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"6.50" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"02" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"02" RRPercent:[NSString stringWithFormat:@"%f",1 / [self.totalMoney floatValue] * 100] RRAmount:@"1" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"9.00" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"02" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"02" RRPercent:[NSString stringWithFormat:@"%f",1 / [self.totalMoney floatValue] * 100] RRAmount:@"1" isFEEPercentAmount:YES];
        }
        
    }else if ([ProductPlan isEqualToString:@"08"]){
        //08-奥迪-品鉴二手车（首付）
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"2.24" BusinessRate:@"-" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",1 / [self.totalMoney floatValue] * 100] RRAmount:@"1" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"7.24" BusinessRate:@"-" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",1 / [self.totalMoney floatValue] * 100] RRAmount:@"1" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"12.24" BusinessRate:@"-" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",1 / [self.totalMoney floatValue] * 100] RRAmount:@"1" isFEEPercentAmount:YES];
        }
    }else if ([ProductPlan isEqualToString:@"09"]){
        //09-奥迪-品鉴二手车（50-50）
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"5.50" BusinessRate:@"-" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:@"50" RRAmount:[NSString stringWithFormat:@"%f",[self.totalMoney floatValue] * 0.5] isFEEPercentAmount:YES];
            
        }
        
    }else if ([ProductPlan isEqualToString:@"10"]){
        //10-BMW厂方-低息融资租赁产品
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"2.88" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"4.88" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"6.88" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
        
    }else if ([ProductPlan isEqualToString:@"11"]){
        //11-BMW厂方-标准融资租赁产品
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"4.88" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"02" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"02" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"6.88" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"02" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"02" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"8.88" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"02" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"02" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
    }else if ([ProductPlan isEqualToString:@"12"]){
        //12-BMW厂方-售后回租产品（SLB回租）
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"2.99" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"4.99" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"6.99" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"1" GPSChargeSunderTaker:@"02" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
        
    }else if ([ProductPlan isEqualToString:@"13"]){
        //13-沃尔沃低息产品
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"3.65" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"5.64" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"7.49" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
    }else if ([ProductPlan isEqualToString:@"14"]){
        //14-新-富二货
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"4.00" BusinessRate:@"0.00" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"7.50" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"03" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
    }else if ([ProductPlan isEqualToString:@"16"]){
        //16-增值购_手续费3.99%
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"3.99" BusinessRate:@"-" InstallGPS:@"0" GPSCount:@"0" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"03" TransferFeeUnderTaker:@"01" DoGuaranty:@"0" GuarantyFeeUnderTaker:@"03" RRPercent:@"50" RRAmount:[NSString stringWithFormat:@"%f",[self.totalMoney floatValue] * 0.5] isFEEPercentAmount:NO];
            
        }
        
    }else if ([ProductPlan isEqualToString:@"17"]){
        //17-增值购_阶梯手续费
        if ([BusinessTerm isEqualToString:@"12"]) {
            NSString *FEEPercent;
            float ContractAmount = [[reqInfo objectForKey:@"ContractAmount"] floatValue];
            if (ContractAmount <= 2000000) {
                FEEPercent = @"3.39";
            }else if (ContractAmount > 2000000 || ContractAmount <= 3000000){
                FEEPercent = [NSString stringWithFormat:@"%f",70000 /[self.totalMoney floatValue] * 100];
            }else{
                FEEPercent = [NSString stringWithFormat:@"%f",100000 /[self.totalMoney floatValue] * 100];
            }
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"3.99" BusinessRate:@"-" InstallGPS:@"0" GPSCount:@"0" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"03" TransferFeeUnderTaker:@"01" DoGuaranty:@"0" GuarantyFeeUnderTaker:@"03" RRPercent:@"50" RRAmount:[NSString stringWithFormat:@"%f",[self.totalMoney floatValue] * 0.5] isFEEPercentAmount:NO];
            
        }
    }else if ([ProductPlan isEqualToString:@"18"]){
        //18-总经理
        
    }else if ([ProductPlan isEqualToString:@"19"]){
        //19-总监及以上级别
        
    }else if ([ProductPlan isEqualToString:@"20"]){
        //20-普通管理人员
        
    }else if ([ProductPlan isEqualToString:@"99"]){
        //99-自定义产品
        
    }else if ([ProductPlan isEqualToString:@"0201"]){
        //0201-体系外-保证金（新）
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"5.00" BusinessRate:@"0.00" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"8.41" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"8.11" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
    }else if ([ProductPlan isEqualToString:@"22"]){
        //0201-体系外-保证金（新）
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"5.00" BusinessRate:@"0.00" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"9.17" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"3.00" BusinessRate:@"6.67" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
    }else if ([ProductPlan isEqualToString:@"23"]){
        //0201-体系外-保证金（新）
        if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"3.00" BusinessRate:@"9.87" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
    }else if ([ProductPlan isEqualToString:@"0605"]){
        //0201-体系外-保证金（新）
        if ([BusinessTerm isEqualToString:@"12"]) {
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"5.00" BusinessRate:@"0.00" InstallGPS:@"1" GPSCount:@"1" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
            
        }else if ([BusinessTerm isEqualToString:@"24"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"-" BusinessRate:@"9.17" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }else if ([BusinessTerm isEqualToString:@"36"]){
            return [self makeReqInfoWithReqInfo:reqInfo FEEPercent:@"3.00" BusinessRate:@"6.67" InstallGPS:@"1" GPSCount:@"2" SignGPSAgreement:@"0" GPSChargeSunderTaker:@"01" TransferFeeUnderTaker:@"01" DoGuaranty:@"1" GuarantyFeeUnderTaker:@"01" RRPercent:[NSString stringWithFormat:@"%f",100 / [self.totalMoney floatValue] * 100] RRAmount:@"100" isFEEPercentAmount:YES];
        }
    }
    return reqInfo;
}
- (NSMutableDictionary *)makeReqInfoWithReqInfo:(NSMutableDictionary *)reqInfo FEEPercent:(NSString *)FEEPercent BusinessRate:(NSString *)BusinessRate InstallGPS:(NSString *)InstallGPS GPSCount:(NSString *)GPSCount SignGPSAgreement:(NSString *)SignGPSAgreement GPSChargeSunderTaker:(NSString *)GPSChargeSunderTaker TransferFeeUnderTaker:(NSString *)TransferFeeUnderTaker DoGuaranty:(NSString *)DoGuaranty GuarantyFeeUnderTaker:(NSString *)GuarantyFeeUnderTaker RRPercent:(NSString *)RRPercent RRAmount:(NSString *)RRAmount isFEEPercentAmount:(BOOL)isFEEPercentAmount
{
    //手续费比例
    if ([FEEPercent isEqualToString:@"-"]) {
        FEEPercent = @"0.00";
    }
    [reqInfo setObject:FEEPercent forKey:@"FEEPercent"];
    //手续费
    if (self.isCalculation) {
        NSString *FEEPercentAmount;
        if (isFEEPercentAmount) {
            FEEPercentAmount = [NSString stringWithFormat:@"%f",[self.BusinessSum floatValue] * [FEEPercent floatValue] / 100];
            
        }else{
            FEEPercentAmount = [NSString stringWithFormat:@"%f",[self.totalMoney floatValue] * [FEEPercent floatValue] / 100];
        }
        [reqInfo setObject:FEEPercentAmount forKey:@"FEEPercentAmount"];
    }
    //客户利率
    if ([BusinessRate isEqualToString:@"-"]) {
        BusinessRate = @"0.00";
    }
    [reqInfo setObject:BusinessRate forKey:@"BusinessRate"];
    //GPS是否安装
    /*
     1-是；0-否
     */
    if ([InstallGPS isEqualToString:@"-"]) {
        InstallGPS = @"0";
    }
    [reqInfo setObject:InstallGPS forKey:@"InstallGPS"];
    //GPS安装数量
    if ([GPSCount isEqualToString:@"-"]) {
        GPSCount = @"0";
    }
    [reqInfo setObject:GPSCount forKey:@"GPSCount"];
    //是否签署GPS补充协议
    /*
     1-是；0-否
     */
    [reqInfo setObject:SignGPSAgreement forKey:@"SignGPSAgreement"];
    //GPS费用承担方
    /*
     01-融资租赁
     02-客户
     03-不涉及
     */
    [reqInfo setObject:GPSChargeSunderTaker forKey:@"GPSChargeSunderTaker"];
    //过户费承担方-待定,怎么确认是上海还是外省
    /*
     01-融资租赁
     02-客户
     03-不涉及
     */
    [reqInfo setObject:TransferFeeUnderTaker forKey:@"TransferFeeUnderTaker"];
    //是否办理抵押
    /*
     1-是；0-否
     */
    [reqInfo setObject:DoGuaranty forKey:@"DoGuaranty"];
    //抵押、解押费承担方-怎么确认是上海还是外省
    /*
     01-融资租赁
     02-客户
     03-不涉及
     */
    [reqInfo setObject:GuarantyFeeUnderTaker forKey:@"GuarantyFeeUnderTaker"];
    //留购比例
    [reqInfo setObject:RRPercent forKey:@"RRPercent"];
    //留购价
    [reqInfo setObject:RRAmount forKey:@"RRAmount"];
    return reqInfo;
}
@end
