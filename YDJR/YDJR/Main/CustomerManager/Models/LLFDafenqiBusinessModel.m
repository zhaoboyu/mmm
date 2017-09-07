//
//  LLFDafenqiBusinessModel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/3/29.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFDafenqiBusinessModel.h"

@implementation LLFDafenqiBusinessModel
// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
- (id)copyWithZone:(NSZone *)zone
{
    return [self yy_modelCopy];
}
-(NSString *)description
{
    return [self yy_modelDescription];
}
- (BOOL)isCanApplyBook
{
    if (![self.processState isEqualToString:@"01"]) {
        return YES;
    }else{
        return NO;
    }
}
- (BOOL)isClickButtonState
{
    if (([self.patchState isEqualToString:@"01"] || [self.coverPolicy isEqualToString:@"01"]) && ![self.processState isEqualToString:@"16"]) {
        return YES;
    }else{
        if ([self.processState isEqualToString:@"04"] || [self.processState isEqualToString:@"06"] || [self.processState isEqualToString:@"12"] || [self.processState isEqualToString:@"13"]) {
            return YES;
        }else{
            return NO;
        }
    }
}
- (NSString *)state
{
    NSString *stateStr;
    if (([self.patchState isEqualToString:@"01"] || [self.coverPolicy isEqualToString:@"01"]) && ![self.processState isEqualToString:@"16"]) {
        if ([self.patchState isEqualToString:@"01"]) {
            stateStr = @"补件中";
        }else{
            stateStr = @"补保单";
        }
        
    }else{
        stateStr = [self changProductState];
//        if ([self.processState isEqualToString:@"01"]) {
//            stateStr = @"创建订单";
//        }else if ([self.processState isEqualToString:@"02"]){
//            stateStr = @"待客户确认";
//        }else if ([self.processState isEqualToString:@"03"]){
//            stateStr = @"客户确认";
//        }else if ([self.processState isEqualToString:@"04"]){
//            stateStr = @"客户拒绝";
//        }else if ([self.processState isEqualToString:@"05"]){
//            stateStr = @"审批中";
//        }else if ([self.processState isEqualToString:@"06"]){
//            stateStr = @"审批通过,二次进件";
//        }else if ([self.processState isEqualToString:@"07"]){
//            stateStr = @"审批拒绝";
//        }else if ([self.processState isEqualToString:@"08"]){
//            stateStr = @"保险购买成功";
//        }else if ([self.processState isEqualToString:@"09"]){
//            stateStr = @"保险购买失败";
//        }else if ([self.processState isEqualToString:@"10"]){
//            stateStr = @"待放款";
//        }else if ([self.processState isEqualToString:@"11"]){
//            stateStr = @"已放款";
//        }else if ([self.processState isEqualToString:@"12"]){
//            stateStr = @"补保单";
//        }else if ([self.processState isEqualToString:@"13"]){
//            stateStr = @"一次进件";
//        }else if ([self.processState isEqualToString:@"14"]){
//            stateStr = @"二次进件完成";
//        }else if ([self.processState isEqualToString:@"15"]){
//            stateStr = @"补保单完成";
//        }else if ([self.processState isEqualToString:@"16"]){
//            stateStr = @"人工终止";
//        }else if ([self.processState isEqualToString:@"17"]){
//            stateStr = @"已取消申请";
//        }else if ([self.processState isEqualToString:@"18"]){
//            stateStr = @"合同签署失败";
//        }else{
//            stateStr = @"其他";
//        }
    }
    return stateStr;
}
- (NSString *)changeReplenState
{
    if ([self.replenState isEqualToString:@"1"]) {
        return @"补款中";
    }else if ([self.replenState isEqualToString:@"2"]){
        return @"补款成功";
    }else{
        return @" ";
    }
}

/**
 是否显示补款状态
 
 @return yes:显示,no:不显示
 */
- (BOOL)isReplenishment
{
    if ([self.replenState isEqualToString:@"1"] || [self.replenState isEqualToString:@"2"]) {
        return YES;
    }else{
        return NO;
    }
}
/**
 是否可以取消申请
 
 @return yes:可点击,NO:不可点击
 */
- (BOOL)isCanCancleApply
{
    if ([self.processState isEqualToString:@"01"] ||[self.processState isEqualToString:@"02"]||[self.processState isEqualToString:@"03"]||[self.processState isEqualToString:@"04"]||[self.processState isEqualToString:@"16"]||[self.processState isEqualToString:@"17"]||[self.processState isEqualToString:@"18"]||[self.processState isEqualToString:@"11"]||[self.processState isEqualToString:@"08"]||[self.processState isEqualToString:@"09"]) {
        return NO;
    }else{
        return YES;
    }
}
- (NSString *)changProductState
{
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *cardTypeDic = tempArr[0];
    //获取客户类型列表
    NSArray *productStateArr = [cardTypeDic objectForKey:@"IDFS000340"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSDictionary *tempDic in productStateArr) {
        NSString *stateName = [tempDic objectForKey:@"dictname"];
        NSString *stateValue = [tempDic objectForKey:@"dictvalue"];
        [dic setObject:stateName forKey:stateValue];
    }
    NSString *productStateString = [dic objectForKey:self.processState];
    if (productStateString && productStateString.length > 0) {
        return productStateString;
    }else{
        return @"其他";
    }
    
}
@end
