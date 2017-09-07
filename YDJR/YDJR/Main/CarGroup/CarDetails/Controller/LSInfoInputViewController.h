//
//  LSInfoInputViewController.h
//  YDJR
//
//  Created by 李爽 on 2016/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  客户信息录入

#import <UIKit/UIKit.h>
@class LSInfoInputCollectionViewCell;
@class LSChoosedProductsModel;
@protocol LSInfoInputViewControllerDelegate <NSObject>

-(void)removeVisibleViews;

@end
@interface LSInfoInputViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)LSChoosedProductsModel *choosedProductsModel;
@property (nonatomic,weak)id<LSInfoInputViewControllerDelegate> delegate;
/**
 客户类型 02:个人 01：企业
 */
@property (nonatomic,copy)NSString *customerType;
@end
