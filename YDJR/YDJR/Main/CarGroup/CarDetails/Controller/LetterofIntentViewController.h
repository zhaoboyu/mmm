//
//  LetterofIntentViewController.h
//  YDJR
//
//  Created by 李爽 on 2016/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  购车意向确认单

#import <UIKit/UIKit.h>
@class LSChoosedProductsModel;

@protocol LetterofIntentViewControllerDelegate <NSObject>

/**
 跳转到客户管理界面
 */
-(void)pushToCustomerManagerController;

@end
@interface LetterofIntentViewController : UIViewController
@property (nonatomic, strong) LSChoosedProductsModel *choosedProductsModel;
@property (nonatomic, weak) id<LetterofIntentViewControllerDelegate> delegate;
@end
