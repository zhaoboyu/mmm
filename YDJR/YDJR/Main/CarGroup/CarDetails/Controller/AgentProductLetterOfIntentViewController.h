//
//  AgentProductLetterOfIntentViewController.h
//  YDJR
//
//  Created by 李爽 on 2016/11/17.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  代理金融产品意向单

#import <UIKit/UIKit.h>
@class LSChoosedProductsModel;

@protocol AgentProductLetterOfIntentViewControllerDelegate <NSObject>

/**
 跳转到客户管理界面 代理金融
 */
-(void)pushToCustomerManagerControllerAgent;

@end
@interface AgentProductLetterOfIntentViewController : UIViewController
/**
 代理产品计算出的结果array
 */
@property (nonatomic, strong) NSMutableArray *returnResultArray;
@property (nonatomic, strong) LSChoosedProductsModel *choosedProductsModel;
@property (nonatomic, weak) id<AgentProductLetterOfIntentViewControllerDelegate> delegate;
@end
