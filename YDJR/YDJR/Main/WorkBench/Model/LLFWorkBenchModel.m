//
//  LLFWorkBenchModel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/5/22.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFWorkBenchModel.h"

@implementation LLFWorkBenchModel
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
//- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
//    NSString *createDate = dic[@"createDate"];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
////    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
////    [dateFormatter setTimeZone:timeZone];
//    
//    NSDate* datea = [dateFormatter dateFromString:createDate]; //------------将字符串按formatter转成nsdate
//    NSDateFormatter *outFromatter = [[NSDateFormatter alloc] init];
//    [outFromatter setDateFormat:@"YYYY-MM-dd"];
////    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//    _createDate = [outFromatter stringFromDate:datea];//----------将nsdate按formatter格式转成nsstring
////    NSLog(@"%@",_createDate);
//    
//    return YES;
//}
- (NSString *)showCreatTime
{
//    NSString *createDate = dic[@"createDate"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* datea = [dateFormatter dateFromString:_createDate]; //------------将字符串按formatter转成nsdate
    NSDateFormatter *outFromatter = [[NSDateFormatter alloc] init];
    [outFromatter setDateFormat:@"YYYY-MM-dd"];
    _showCreatTime = [outFromatter stringFromDate:datea];//----------将nsdate按formatter格式转成nsstring

    return _showCreatTime;
}
/**
 判断产品点击状态

 @return 是否可点击
 */
- (BOOL)isClickButtonState
{
    if ([self.productType isEqualToString:@"01"]) {
        //达分期产品
        return [self.dfqModelInfo isClickButtonState];
    }else if ([self.productType isEqualToString:@"02"]){
        //自营及代理产品
        return [self.intentModelInfo isClickButtonState];
    }
    return NO;
}
/**
 获取产品显示状态

 @return 产品显示状态
 */
- (NSString *)showState
{
    if ([self.productType isEqualToString:@"01"]) {
        //达分期产品
        _showState = self.dfqModelInfo.state;
    }else if ([self.productType isEqualToString:@"02"]){
        //自营及代理产品
        _showState = self.intentModelInfo.processState;
    }
    return _showState;
}
@end
