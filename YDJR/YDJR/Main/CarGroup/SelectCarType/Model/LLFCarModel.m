//
//  LLFCarModel.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarModel.h"

@implementation LLFCarModel
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
    NSString *catModelDetailYear = dic[@"catModelDetailYear"];
    _catModelDetailYear = [NSString stringWithFormat:@"%@%@",catModelDetailYear,@"款"];
    NSString *catModelDetailPrice = dic[@"catModelDetailPrice"];
    //    NSLog(@"%@",[totamt class]);
    _catModelDetailPrice = [NSString stringWithFormat:@"%.2f",[catModelDetailPrice doubleValue] * 10000];
    return YES;
}
@end
