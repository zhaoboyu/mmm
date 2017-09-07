//
//  LLFCarInfoModel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/3/29.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFCarInfoModel.h"

@implementation LLFCarInfoModel
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
@end
