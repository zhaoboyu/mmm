//
//  LLFInsuranceInfoView.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLFInsuranceInfoViewDelegate <NSObject>

- (void)insuranceInfoButtonstate:(NSString *)state modelArr:(NSMutableArray *)modelArr insuranceNum:(NSString *)insuranceNum;

- (void)sendSumInsuranceMoney:(NSString *)sumMoney;
- (void)sendIsByDaFenQi:(BOOL)isBy;
@end
@interface LLFInsuranceInfoView : UIView
@property (nonatomic,weak)id<LLFInsuranceInfoViewDelegate>delegate;
@property (nonatomic,strong)NSMutableDictionary *insuranceInfoModelDic;
@property (nonatomic,strong)UICollectionView *collectionView;
@end
