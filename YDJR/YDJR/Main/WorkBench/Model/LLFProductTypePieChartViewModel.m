//
//  LLFProductTypePieChartViewModel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/6/15.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFProductTypePieChartViewModel.h"
#import "LLFPieChartViewDataModel.h"
#import "LLFWorkBenchModel.h"
@implementation LLFProductTypePieChartViewModel
+ (instancetype)initWithWorkModelArr:(NSArray *)workModelArr
{
    return [[LLFProductTypePieChartViewModel alloc] initWithWorkModelArr:workModelArr];
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
    NSInteger workCount = 0;
    for (LLFWorkBenchModel *model in workModelArr) {
        if ([self isStatisticsWithProductName:model.productName]) {
            workCount ++;
            if ([dic objectForKey:model.productName]) {
                NSMutableArray *tempArr = [dic objectForKey:model.productName];
                [tempArr addObject:model];
            }else{
                NSMutableArray *modelArr = [NSMutableArray arrayWithObject:model];
                [dic setObject:modelArr forKey:model.productName];
            }
        }
        
    }
    NSArray *keyArr = [dic allKeys];
    for (NSString *key in keyArr) {
        NSArray *valueArr = [dic objectForKey:key];
        LLFPieChartViewDataModel *pieChart = [LLFPieChartViewDataModel initWithPieValue:valueArr.count pieText:key];
        [self.pieChartViewDataModelArr addObject:pieChart];
    }
    self.total = workCount;
    self.centText = @"订单总数";
}

- (BOOL)isStatisticsWithProductName:(NSString *)productName
{
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *cardTypeDic = tempArr[0];
    NSArray *productStateArr = productStateArr = [cardTypeDic objectForKey:@"IDFS000344"];
    for (NSDictionary *dic in productStateArr) {
        NSString *productState = [dic objectForKey:@"dictvalue"];
        NSString *isShow = [dic objectForKey:@"dictname"];
        if (productState && [productName isEqualToString:productState] && [isShow isEqualToString:@"01"]) {
            return YES;
        }
    }
    
    return NO;
}
@end
