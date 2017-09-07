//
//  LLFSeriesListView.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLFMechanismCarModel;
@protocol LLFSeriesListViewDelegate <NSObject>

- (void)seriesListButtonMechanismModel:(LLFMechanismCarModel *)MechanismModel;

/**
 选中的汽车分类

 @param carType 1:进口,0:国产
 */
- (void)selectCarTypeWithCarType:(NSString *)carType;

@end
@interface LLFSeriesListView : UIView
@property (nonatomic,weak)id<LLFSeriesListViewDelegate>delegate;
@property (nonatomic,strong)NSMutableArray *mechanisCarModelArr;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIButton *jinkouButton;
@property (nonatomic,strong)UIButton *guochanButton;
@end
