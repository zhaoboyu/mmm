//
//  LLFProductTypePieChartView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/5/27.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLFProductTypePieChartViewModel;
@interface LLFProductTypePieChartView : UIView
@property (nonatomic,strong)NSArray *pieChartViewDataModelArr;
@property (nonatomic,strong)LLFProductTypePieChartViewModel *productTypePieChartViewModel;
- (void)setcentText:(NSString *)centText total:(NSInteger)total;
@end
