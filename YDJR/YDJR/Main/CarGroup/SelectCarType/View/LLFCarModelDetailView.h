//
//  LLFCarModelDetailView.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLFCarSeriesCarModel;

@protocol LLFCarModelDetailViewDelegate <NSObject>

- (void)carModelDetailButtonState:(id)state;

@end

@interface LLFCarModelDetailView : UIView
@property (nonatomic,weak)id<LLFCarModelDetailViewDelegate>delegate;
@property (nonatomic,strong)LLFCarSeriesCarModel *carSeriesCarModel;
@property (nonatomic,strong)NSMutableDictionary *carModelDic;
@property (nonatomic,strong)UITableView *tableView;
@end
