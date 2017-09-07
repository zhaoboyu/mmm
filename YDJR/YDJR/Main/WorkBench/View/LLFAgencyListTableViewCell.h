//
//  LLFAgencyListTableViewCell.h
//  YDJR
//
//  Created by 吕利峰 on 2017/5/25.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLFWorkBenchModel;

@protocol LLFAgencyListTableViewCellDelegate <NSObject>

@optional
- (void)clickButtonWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel;
@end

@interface LLFAgencyListTableViewCell : UITableViewCell
@property (nonatomic,strong)LLFWorkBenchModel *workBenchModel;
@property (nonatomic,weak)id<LLFAgencyListTableViewCellDelegate>delegate;
@end
