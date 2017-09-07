//
//  LLFWorkBenchUserInfoView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/5/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLFWorkBenchUserInfoViewModel;
@interface LLFWorkBenchUserInfoView : UIView
@property (nonatomic,strong)UserDataModel *userModel;
@property (nonatomic,strong)NSArray *pieChartViewDataModelArr;
@property (nonatomic,strong)LLFWorkBenchUserInfoViewModel *workBenchUserInfoViewModel;
- (void)setcentText:(NSString *)centText total:(NSInteger)total;
@end
