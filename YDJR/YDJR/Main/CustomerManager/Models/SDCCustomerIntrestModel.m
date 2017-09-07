//
//  SDCCustomerIntrestModel.m
//  YDJR
//
//  Created by sundacheng on 16/10/12.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDCCustomerIntrestModel.h"

@implementation SDCCustomerIntrestModel

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
// 当 JSON 转为 Model 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *contractAmount = dic[@"contractAmount"];
    //    NSLog(@"%@",[totamt class]);
    _contractAmount = [NSString stringWithFormat:@"%.2f",[contractAmount doubleValue]];
    NSString *carPrice = dic[@"carPrice"];
    //    NSLog(@"%@",[totamt class]);
    _carPrice = [NSString stringWithFormat:@"%.2f",[carPrice doubleValue]];
    NSString *carrzgm = dic[@"carrzgm"];
    //    NSLog(@"%@",[totamt class]);
    _carrzgm = [NSString stringWithFormat:@"%.2f",[carrzgm doubleValue]];
    return YES;
}
- (BOOL)isClickButtonState
{
    if ([self.state isEqualToString:@"06"] && ![[UserDataModel sharedUserDataModel] isFinancialManagers]) {
        return NO;
    }else if (([self.state isEqualToString:@"0"] || [self.state isEqualToString:@"00"] || [self.state isEqualToString:@"06"] || [self.state isEqualToString:@"16"] || [_patchState isEqualToString:@"01"]) && ![self.state isEqualToString:@"05"]){
        return YES;
    }else{
        return NO;
    }
}
- (NSString *)processState
{
    NSString *stateStr;
    if ([_patchState isEqualToString:@"01"] && ![self.state isEqualToString:@"05"]) {
        if ([_patchState isEqualToString:@"01"]) {
            //补件
            stateStr = @"补件中";
        }
    }else{
        stateStr = [self changProductState];
//        if ([_state isEqualToString:@"0"]) {
//            stateStr = @"开始申请";
//        } else if ([_state isEqualToString:@"00"]) {
//            stateStr = @"一次进件";
//        } else if ([_state isEqualToString:@"01"]) {
//            stateStr = @"已受理";
//        } else if ([_state isEqualToString:@"02"]) {
//            stateStr = @"审批中";
//        } else if ([_state isEqualToString:@"03"]) {
//            stateStr = @"审批通过";
//        } else if ([_state isEqualToString:@"04"]) {
//            stateStr = @"审批拒绝";
//        } else if ([_state isEqualToString:@"05"]) {
//            stateStr = @"人工终止";
//        } else if ([_state isEqualToString:@"06"]) {
//            stateStr = @"转介中";
//        } else if ([_state isEqualToString:@"07"]){
//            stateStr = @"审批通过";
//        }else if ([_state isEqualToString:@"08"]){
//            stateStr = @"审批失败";
//        }else if ([_state isEqualToString:@"09"]){
//            stateStr = @"首付成功";
//        }else if ([_state isEqualToString:@"10"]){
//            stateStr = @"放款成功";
//        }else if ([_state isEqualToString:@"11"]){
//            stateStr = @"初审";
//        }else if ([_state isEqualToString:@"12"]){
//            stateStr = @"复审";
//        }else if ([_state isEqualToString:@"13"]){
//            stateStr = @"终审";
//        }else if ([_state isEqualToString:@"14"]){
//            stateStr = @"保险购买成功";
//        }else if ([_state isEqualToString:@"15"]){
//            stateStr = @"保险购买失败";
//        }else{
//            stateStr = _state;
//        }
    }
    
    return stateStr;
}
- (NSString *)changProductState
{
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *cardTypeDic = tempArr[0];
    //获取客户类型列表
    NSArray *productStateArr;
    NSString *productState = [NSString stringWithFormat:@"%@",self.productState];
    if ([productState isEqualToString:@"1"]) {
        //自营
        productStateArr = [cardTypeDic objectForKey:@"IDFS000338"];
    }else{
        //代理
        productStateArr = [cardTypeDic objectForKey:@"IDFS000339"];
    }
    //        NSArray *cardTypeArr = [cardTypeDic objectForKey:@"IDFS000210"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (NSDictionary *tempDic in productStateArr) {
        NSString *stateName = [tempDic objectForKey:@"dictname"];
        NSString *stateValue = [tempDic objectForKey:@"dictvalue"];
        [dic setObject:stateName forKey:stateValue];
    }
    NSString *productStateString = [dic objectForKey:self.state];
    if (productStateString && productStateString.length > 0) {
        return productStateString;
    }else{
        return @"其他";
    }
   
}
@end
