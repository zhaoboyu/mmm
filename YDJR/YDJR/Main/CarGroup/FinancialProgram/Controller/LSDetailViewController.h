//
//  LSDetailViewController.h
//  YDJR
//
//  Created by 李爽 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  对比金融方案Detail控制器

#import <UIKit/UIKit.h>
@class LSMasterViewController;
@interface LSDetailViewController : UIViewController
@property(nonatomic,weak)LSMasterViewController *leftVC;
/**
 实际价格
 */
@property (nonatomic,copy)NSString *actualPrice;
/**
 全款购车实际价格
 */
@property (nonatomic,copy)NSString *fullPaymentRealPrice;
/**
 选中的金融产品modelArray
 */
@property (nonatomic,copy)NSMutableArray *choosedProductsModelArray;
@end
