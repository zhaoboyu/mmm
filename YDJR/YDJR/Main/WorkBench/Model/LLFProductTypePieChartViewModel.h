//
//  LLFProductTypePieChartViewModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/6/15.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLFProductTypePieChartViewModel : NSObject
@property (nonatomic,strong)NSArray *workModelArr;
@property (nonatomic,strong)NSMutableArray *pieChartViewDataModelArr;
@property (nonatomic,copy)NSString *centText;
@property (nonatomic,assign)NSInteger total;
+ (instancetype)initWithWorkModelArr:(NSArray *)workModelArr;
@end
