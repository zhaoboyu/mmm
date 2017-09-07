//
//  LLFFinalApprovalModel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/4/7.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFFinalApprovalModel.h"

@implementation LLFFinalApprovalModel
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
    NSString *includeAmountType = dic[@"includeAmountType"];
    //    NSLog(@"%@",[totamt class]);
    _includeAmountType = [self changeValueWithIncludeAmountType:includeAmountType];
    NSString *projectSum= [NSString stringWithFormat:@"%@",dic[@"projectSum"]];
    _projectSum = [projectSum cut];
    NSString *businessSum = [NSString stringWithFormat:@"%@",dic[@"businessSum"]];
    _businessSum = [businessSum cut];
    
    NSString *approveDate = dic[@"approveDate"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    //dateFromString 将时间字符串转化为日期类型，
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]]; // 默认使用0时区，所以需要时区的转换
    NSDate *nowDate = [formatter dateFromString:approveDate];
    NSDateFormatter *formatterTmep = [[NSDateFormatter alloc] init];
    [formatterTmep setDateFormat:@"yyyy年MM月dd日"];
    _approveDate = [formatterTmep stringFromDate:nowDate];
    
    return YES;
}
- (NSString *)changeValueWithIncludeAmountType:(NSString *)includeAmountType
{
    NSArray *typeArr = [includeAmountType componentsSeparatedByString:@","];
    NSMutableString *typeValueStr = [NSMutableString string];
    for (NSString *type in typeArr) {
        NSString *value;
        if ([type isEqualToString:@"01"]) {
            value = @"车";
        }else if ([type isEqualToString:@"02"]){
            value = @"购置税";
        }else if ([type isEqualToString:@"03"]){
            value = @"保险";
        }
        if (typeValueStr && typeValueStr.length > 0) {
            [typeValueStr appendFormat:@",%@",value];
        
        }else{
            [typeValueStr appendString:value];
        }
    }
    return typeValueStr;
}
@end
