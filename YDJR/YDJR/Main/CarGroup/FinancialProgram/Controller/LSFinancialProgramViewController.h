//
//  LSFinancialProgramViewController.h
//  YDJR
//
//  Created by 李爽 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  金融方案

#import <UIKit/UIKit.h>
@class LSTextField;
@class LLFCarModel;
@class LSFinancialProgramView;
@protocol LSFinancialProgramViewControllerDelegate <NSObject>

-(void)popToCarDetailsViewControllerWithTitle:(NSString *)tilte;

-(void)popToFinancialProgramViewControllerWithDataArr:(NSArray *)dataArr withFinancialProgramTag:(NSInteger)tag;

-(void)refreshChoosedFinancialProductTitle:(NSString *)title;

-(void)refreshEditedFinancialProductArray:(NSArray *)array withSelectedProductTag:(NSInteger)tag;
@end
@interface LSFinancialProgramViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 建议零售价(元)
 */
@property (nonatomic,strong)UILabel *suggestedRetailPriceTitleLabel;
/**
 建议零售价格
 */
@property (nonatomic,strong)UILabel *suggestedRetailPriceLabel;
/**
 实际价格
 */
@property (nonatomic,strong)UILabel *realPriceLabel;
/**
 实际价格TextField
 */
@property (nonatomic,strong)LSTextField *realPriceInputTextField;
/**
 购置税
 */
@property (nonatomic,strong)UILabel *gzsLabel;
/**
 购置税TextField
 */
@property (nonatomic,strong)LSTextField *gzsInputTextField;
/**
 保险
 */
@property (nonatomic,strong)UILabel *bxLabel;
/**
 保险TextField
 */
@property (nonatomic,strong)LSTextField *bxInputTextField;
/**
 购置税
 */
@property (nonatomic,copy)NSString *purchaseTax;

@property (nonatomic,strong)LLFCarModel *carModel;
@property (nonatomic,weak)id<LSFinancialProgramViewControllerDelegate> delegate;
@property (nonatomic,strong)NSMutableArray *choosedProductsModelArray;
@property (nonatomic,strong)LSFinancialProgramView *financialProgramView;
@property (nonatomic,strong)UICollectionView *addFinancialProgramView;
@end
