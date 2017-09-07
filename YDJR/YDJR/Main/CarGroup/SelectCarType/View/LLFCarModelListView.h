//
//  LLFCarModelListView.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLFCarModelListViewDelegate <NSObject>

- (void)carModelListButtonState:(id)state;

@end
@interface LLFCarModelListView : UIView
@property (nonatomic,weak)id<LLFCarModelListViewDelegate>delegate;
@property (nonatomic,strong)NSMutableArray *seriesCarModelArr;
@property (nonatomic,strong)UITableView *tableView;
@end
