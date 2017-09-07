//
//  LLFPieChartViewDataModel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/5/28.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFPieChartViewDataModel.h"

@interface LLFPieChartViewDataModel ()
@property (nonatomic)double pieValue;
@property (nonatomic)NSString *pieText;
@end

@implementation LLFPieChartViewDataModel
- (instancetype)initWithPieValue:(double)pieValue pieText:(NSString *)pieText
{
    if (self = [super init]) {
        self.pieValue = pieValue;
        self.pieText = pieText;
    }
    return  self;
}
+ (instancetype)initWithPieValue:(double)pieValue pieText:(NSString *)pieText
{
    return [[LLFPieChartViewDataModel alloc] initWithPieValue:pieValue pieText:pieText];
}

@end
