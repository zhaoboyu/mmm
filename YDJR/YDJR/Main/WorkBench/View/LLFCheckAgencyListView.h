//
//  LLFCheckAgencyListView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/5/15.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLFWorkBenchModel;
#import "LLFAgencyListTableView.h"
@protocol LLFCheckAgencyListViewDelegate <NSObject>

- (void)clickButtonWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel;

@end

@interface LLFCheckAgencyListView : UIView
@property (nonatomic,weak)id<LLFCheckAgencyListViewDelegate>delegate;

/**
 已办
 */
@property (nonatomic,strong)NSMutableArray *workCompleteTaskModelArr;

/**
 代办
 */
@property (nonatomic,strong)NSMutableArray *waitTaskModelArr;
@property (nonatomic,strong)LLFAgencyListTableView *agencyListTableView;
@end
