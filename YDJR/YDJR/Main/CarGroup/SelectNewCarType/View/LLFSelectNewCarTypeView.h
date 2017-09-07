//
//  LLFSelectNewCarTypeView.h
//  YDJR
//
//  Created by 吕利峰 on 2016/12/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLFCarBuyTypeListView;
@class LLFRunloopView;
@class LLFCarDetailInfoView;
@class LLFMechanismCarModel;
@class LLFCarModel;
@protocol LLFSelectNewCarTypeViewDelegate <NSObject>

@optional

- (void)clickCarBuyListWith:(LLFCarModel *)carModel;

@end
@interface LLFSelectNewCarTypeView : UIView
@property(nonatomic,weak)id<LLFSelectNewCarTypeViewDelegate>delegate;
@property (nonatomic,strong)LLFMechanismCarModel *mechanismCarModel;
@property (nonatomic,strong)NSMutableDictionary *carBuyTypeDic;
@property (nonatomic,strong)UIButton *customizedFinancialPlanButton;
@end
