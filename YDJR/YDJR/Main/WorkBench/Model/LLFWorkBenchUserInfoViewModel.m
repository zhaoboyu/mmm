//
//  LLFWorkBenchUserInfoViewModel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/6/15.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFWorkBenchUserInfoViewModel.h"
#import "LLFPieChartViewDataModel.h"
#import "LLFWorkBenchModel.h"
@implementation LLFWorkBenchUserInfoViewModel
+ (instancetype)initWithWorkModelArr:(NSArray *)workModelArr
{
    return [[LLFWorkBenchUserInfoViewModel alloc] initWithWorkModelArr:workModelArr];
}
- (instancetype)initWithWorkModelArr:(NSArray *)workModelArr
{
    if (self = [super init]) {
        self.pieChartViewDataModelArr = [NSMutableArray array];
        self.workModelArr = workModelArr;
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.pieChartViewDataModelArr = [NSMutableArray array];
    }
    return self;
}

- (void)setWorkModelArr:(NSArray *)workModelArr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    _workModelArr = workModelArr;
    NSInteger arrCount = 0;
    for (LLFWorkBenchModel *model in workModelArr) {
        if ([self isStatisticsWithProductState:model.showState]) {
            arrCount ++;
            if ([dic objectForKey:model.showState]) {
                NSMutableArray *tempArr = [dic objectForKey:model.showState];
                [tempArr addObject:model];
            }else{
                NSMutableArray *modelArr = [NSMutableArray arrayWithObject:model];
                [dic setObject:modelArr forKey:model.showState];
            }
        }
    }
    NSArray *keyArr = [dic allKeys];
    for (NSString *key in keyArr) {
        NSArray *valueArr = [dic objectForKey:key];
        LLFPieChartViewDataModel *pieChart = [LLFPieChartViewDataModel initWithPieValue:valueArr.count pieText:key];
        [self.pieChartViewDataModelArr addObject:pieChart];
    }
    self.total = arrCount;
    self.centText = @"订单总数";
}

- (BOOL)isStatisticsWithProductState:(NSString *)productState
{
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *cardTypeDic = tempArr[0];
    NSArray *productStateArr = productStateArr = [cardTypeDic objectForKey:@"IDFS000343"];
    for (NSDictionary *dic in productStateArr) {
        NSString *productState1 = [dic objectForKey:@"dictvalue"];
        NSString *isShow = [dic objectForKey:@"dictname"];
        if (productState1 && [productState isEqualToString:productState1] && [isShow isEqualToString:@"01"]) {
            return YES;
        }
    }
    
    return NO;
}
@end
