//
//  LLFPieChartViewDataModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/5/28.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLFPieChartViewDataModel : NSObject
@property (nonatomic,readonly)double pieValue;
@property (nonatomic,readonly)NSString *pieText;

+ (instancetype)initWithPieValue:(double)pieValue pieText:(NSString *)pieText;
@end
