//
//  LLFMechanismCarModel.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFMechanismCarModel.h"
#import "LLFCarSeriesImageModel.h"
@implementation LLFMechanismCarModel
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
    NSString *carSeriesImgStr = dic[@"carSeriesImg"];
    NSArray *arr = [Tool arrayWithJsonString:carSeriesImgStr];
//    _carSeriesImg = [NSMutableArray arrayWithArray:[Tool arrayWithJsonString:carSeriesImgStr]];
    //    NSLog(@"%@",[totamt class]);
    _carSeriesImg = [NSMutableArray array];
    for (NSDictionary *tempDic in arr) {
        [_carSeriesImg addObject:[tempDic objectForKey:@"imageurl"]];
    }
    return YES;
}
 //返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"carSeriesImg" : [LLFCarSeriesImageModel class]};
//}
@end
