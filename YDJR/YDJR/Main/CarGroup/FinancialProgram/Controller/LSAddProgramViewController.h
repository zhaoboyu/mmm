//
//  LSAddProgramViewController.h
//  YDJR
//
//  Created by 李爽 on 2016/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  添加方案

#import <UIKit/UIKit.h>
@class LLFCarModel;
@class LSChoosedProductsModel;
@class LSFinancialProductsModel;
@protocol LSAddProgramViewDelegate <NSObject>

-(void)popToFinancialProgramViewControllerWithChoosedProductsModel:(LSChoosedProductsModel *)choosedProductsModel;

@end
@interface LSAddProgramViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)LLFCarModel *carModel;
/**
 实际价格
 */
@property (nonatomic,copy)NSString *realPrice;
/**
 购置税
 */
@property (nonatomic,copy)NSString *purchaseTax;
/**
 保险
 */
@property (nonatomic,copy)NSString *insurance;
@property (nonatomic,copy)NSMutableArray *choosedProductsModelArray;

@property (nonatomic,weak)id<LSAddProgramViewDelegate> delegate;
@end
