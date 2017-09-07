//
//  LLFCarBuyTypeListView.h
//  YDJR
//
//  Created by 吕利峰 on 2016/12/20.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLFCarModel;
@protocol LLFCarBuyTypeListViewDelegate <NSObject>

@optional

- (void)clickCarBuyListWith:(LLFCarModel *)carModel;

@end
@interface LLFCarBuyTypeListView : UIView
@property(nonatomic,weak)id<LLFCarBuyTypeListViewDelegate>delegate;
/**
 数据模型
 */
@property (nonatomic,strong)NSMutableDictionary *carBuyTypeDic;
@end
