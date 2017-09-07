//
//  LLFWorkBenchView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/5/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLFWorkBenchUserInfoView.h"
#import "LLFCheckAgencyListView.h"
#import "LLFProductTypePieChartView.h"
#import "LLFProductTypeDIYLineChartView.h"
@protocol LLFWorkBenchViewDelegate <NSObject>

- (void)clickButtonWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel;

@end

@interface LLFWorkBenchView : UIView
@property (nonatomic,weak)id<LLFWorkBenchViewDelegate>delegate;
/**
 用户及产品状态图表
 */
@property (nonatomic,strong)LLFWorkBenchUserInfoView *userInfoView;

/**
 代办已办任务工作台
 */
@property (nonatomic,strong)LLFCheckAgencyListView *agencyListView;

/**
 产品种类图表
 */
@property (nonatomic,strong)LLFProductTypePieChartView *productTypePieChartView;

/**
 产品种类折线图
 */
@property (nonatomic,strong)LLFProductTypeDIYLineChartView *productTypeLineChartView;
@end
