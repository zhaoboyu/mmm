//
//  LLFCarGroupView.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLFMechanismCarModel;
@protocol LLFCarGroupViewDelegate <NSObject>

- (void)carGroupButtonMechanismModel:(LLFMechanismCarModel *)MechanismModel;

@end
@interface LLFCarGroupView : UIView
@property (nonatomic,weak)id<LLFCarGroupViewDelegate>delegate;
@property (nonatomic,strong)NSMutableArray *mechanisCarModelArr;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,assign) BOOL fristLoadData;
//@property (nonatomic,strong)UIColor *collectViewBackcolour;
@end
