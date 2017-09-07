//
//  LSAddProgramDetailsViewController.h
//  YDJR
//
//  Created by 李爽 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  添加方案详情

#import <UIKit/UIKit.h>
@class LSAddProgramDetailsView;
@class LSFinancialProductsModel;
@class LSChoosedProductsModel;
@protocol LSAddProgramDetailsViewControllerDelegate <NSObject>

-(void)popToAddProgramViewControllerWithChoosedProductModel:(LSChoosedProductsModel *)choosedProductModel;

@end
@interface LSAddProgramDetailsViewController : UIViewController
@property (nonatomic,copy)LSFinancialProductsModel *productsModel;
@property (nonatomic,copy)NSString *catModelDetailPrice;
@property (nonatomic,weak)id<LSAddProgramDetailsViewControllerDelegate> delegate;
@end
