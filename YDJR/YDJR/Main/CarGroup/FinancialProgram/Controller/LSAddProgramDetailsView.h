//
//  LSAddProgramDetailsView.h
//  YDJR
//
//  Created by 李爽 on 2016/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  自营金融产品详情view

#import <UIKit/UIKit.h>
@class LSFinancialProductsModel;
@class LSChoosedProductsModel;
@protocol LSAddProgramDetailsViewDelegate <NSObject>

-(void)addProgramDetailsViewTextFieldDidEndEditing:(UITextField *)textField;

-(void)popToAddProgramViewControllerWithChoosedProductModel:(LSChoosedProductsModel *)choosedProductModel;

@end
@interface LSAddProgramDetailsView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 金融产品model
 */
@property (nonatomic,copy)LSFinancialProductsModel *productsModel;
@property (nonatomic,weak)id<LSAddProgramDetailsViewDelegate> delegate;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,copy)NSString *catModelDetailPrice;
@property (nonatomic,strong)LSChoosedProductsModel *choosedProductsModel;
- (instancetype)initWithFrame:(CGRect)frame andWithModel:(id)productsModel withPrice:(NSString *)price withProductDict:(NSString *)productDict;
@end
