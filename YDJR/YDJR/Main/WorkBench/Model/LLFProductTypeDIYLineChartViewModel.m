//
//  LLFProductTypeDIYLineChartViewModel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/6/19.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFProductTypeDIYLineChartViewModel.h"
#import "LLFWorkBenchModel.h"

@interface LLFProductTypeDIYLineChartViewModel ()
@property (nonatomic,strong)NSMutableArray *allColersArr;
@end

@implementation LLFProductTypeDIYLineChartViewModel
+ (instancetype)initWithWorkModelArr:(NSMutableArray *)workModelArr
{
    return [[LLFProductTypeDIYLineChartViewModel alloc] initWithWorkModelArr:workModelArr];
}
- (instancetype)initWithWorkModelArr:(NSMutableArray *)workModelArr
{
    if (self = [super init]) {
        self.colorArray = [NSMutableArray array];
        self.xTitles = [NSMutableArray array];
        self.valueArr = [NSMutableArray array];
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
- (void)setWorkModelArr:(NSMutableArray *)workModelArr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (workModelArr) {
        [workModelArr sortUsingComparator:^NSComparisonResult(LLFWorkBenchModel *obj1, LLFWorkBenchModel *obj2) {
            return [obj2.showCreatTime compare:obj1.showCreatTime];
        }];
    }
    _workModelArr = workModelArr;
    LLFWorkBenchModel *startModel = [workModelArr lastObject];
    NSString *startTime = startModel.showCreatTime;
    for (LLFWorkBenchModel *model in workModelArr) {
        if ([self isStatisticsWithProductName:model.productName]) {
            if ([dic objectForKey:model.productName]) {
                NSMutableArray *tempArr = [dic objectForKey:model.productName];
                [tempArr addObject:model];
            }else{
                NSMutableArray *modelArr = [NSMutableArray arrayWithObject:model];
                [dic setObject:modelArr forKey:model.productName];
            }
        }
        
    }
    [self jisuantimechaWithTimeString:startTime dic:dic];
}

- (void)jisuantimechaWithTimeString:(NSString *)timeString dic:(NSDictionary *)dic
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date=[dateFormatter dateFromString:timeString];
    
    NSTimeInterval late=[date timeIntervalSince1970]*1;
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSInteger cha = (now - late) / (24 * 60 * 60);
    
    for (int i = 0; i <= cha; i++) {
        NSDate *tempDate = [NSDate dateWithTimeInterval:-(24 * 60 * 60) * i sinceDate:dat];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *tempTimeStr = [dateFormatter stringFromDate:tempDate];
        [self.xTitles addObject:tempTimeStr];
    }
    [self.xTitles sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSArray *keyArr = [dic allKeys];
    for (int i = 0; i < keyArr.count; i++) {
        NSString *key = keyArr[i];
        NSArray *tempArr = [dic objectForKey:key];
        NSMutableArray *valueTempArr = [NSMutableArray array];
        for (int j = 0; j < self.xTitles.count; j++) {
            NSString *secondTimeStr = [self.xTitles objectAtIndex:j];
            NSInteger num = 0;
            for (LLFWorkBenchModel *model in tempArr) {
                
                if ([model.showCreatTime isEqualToString:secondTimeStr]) {
                    num ++;
                }
//                if (j == 0) {
//                    NSString *timeStr = [self.xTitles objectAtIndex:j];
//                    if ([model.showCreatTime compare:timeStr] != NSOrderedDescending) {
//                        num ++;
//                    }
//                }else{
//                    NSString *firstTimeStr = [self.xTitles objectAtIndex:j - 1];
//                    NSString *secondTimeStr = [self.xTitles objectAtIndex:j];
//                    NSComparisonResult result1 = [model.showCreatTime compare:firstTimeStr];
//                    NSComparisonResult result2 = [model.showCreatTime compare:secondTimeStr];
//                    if (result1 == NSOrderedDescending && result2 != NSOrderedDescending) {
//                        num ++;
//                    }
//                    
//                }
            }
            [valueTempArr addObject:[NSString stringWithFormat:@"%ld",num]];
        }
        [self.valueArr addObject:valueTempArr];
        [self.colorArray addObject:self.allColersArr[i]];
    }
    self.productNames = [NSArray arrayWithArray:keyArr];
    
    
}
- (NSMutableArray *)allColersArr
{
    NSMutableArray *colersArr = [NSMutableArray array];
    //黄色
    [colersArr addObject:[UIColor hex:@"#FFFF00"]];
    [colersArr addObject:[UIColor hex:@"#FFBBFF"]];
    [colersArr addObject:[UIColor hex:@"#FF8247"]];
    [colersArr addObject:[UIColor hex:@"#FF34B3"]];
    [colersArr addObject:[UIColor hex:@"#FF0000"]];
    [colersArr addObject:[UIColor hex:@"##C0FF3E"]];
    [colersArr addObject:[UIColor hex:@"#BFEFFF"]];
    [colersArr addObject:[UIColor hex:@"#B23AEE"]];
    [colersArr addObject:[UIColor hex:@"#8E388E"]];
    [colersArr addObject:[UIColor hex:@"#7FFFD4"]];
    [colersArr addObject:[UIColor hex:@"#551A8B"]];
    [colersArr addObject:[UIColor hex:@"#436EEE"]];
//    [colersArr addObject:[UIColor hex:@"#FFFF00"]];
//    [colersArr addObject:[UIColor hex:@"#FFFF00"]];
//    [colersArr addObject:[UIColor hex:@"#FFFF00"]];
//    [colersArr addObject:[UIColor hex:@"#FFFF00"]];
    
    return colersArr;
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
