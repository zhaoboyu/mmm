//
//  LLFProductTypeDIYLineChartViewModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/6/19.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLFProductTypeDIYLineChartViewModel : NSObject
@property (nonatomic,strong)NSMutableArray *workModelArr;
@property (nonatomic,strong)NSMutableArray *colorArray;
@property (nonatomic,strong)NSMutableArray *xTitles;
@property (nonatomic,strong)NSMutableArray *valueArr;
@property (nonatomic,strong)NSArray *productNames;
+ (instancetype)initWithWorkModelArr:(NSMutableArray *)workModelArr;
@end
