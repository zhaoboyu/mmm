//
//  LLFAgencyListTableView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/5/25.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLFWorkBenchModel;

@protocol LLFAgencyListTableViewDelegate <NSObject>

- (void)clickButtonWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel;

@end
@interface LLFAgencyListTableView : UIView
@property (nonatomic,strong)NSMutableArray *modelArr;
@property (nonatomic,weak)id<LLFAgencyListTableViewDelegate>delegate;
@property (nonatomic,strong)UITableView *tableView;
@end
