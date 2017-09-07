//
//  LSVSFinancialProgramViewController.h
//  YDJR
//
//  Created by 李爽 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  对比金融方案

#import <UIKit/UIKit.h>
@protocol LSVSFinancialProgramViewControllerDelegate <NSObject>

-(void)clearSelectedProgram;

@end
@interface LSVSFinancialProgramViewController : UIViewController
/**
 实际价格
 */
@property (nonatomic,copy)NSString *realPrice;
/**
 全款购车实际价格
 */
@property (nonatomic,copy)NSString *fullPaymentRealPrice;
/**
 选中的金融产品modelArray
 */
@property (nonatomic,copy)NSMutableArray *choosedProductsModelArray;
@property (nonatomic,assign)int numberOfRows;
@property (nonatomic,weak)id<LSVSFinancialProgramViewControllerDelegate> delegate;
@end
