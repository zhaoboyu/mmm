//
//  LSMasterViewController.h
//  YDJR
//
//  Created by 李爽 on 2016/11/14.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  对比金融方案Master控制器

#import <UIKit/UIKit.h>
@class LSVSFinancialProgramViewController;
@protocol LSMasterViewControllerDelegate <NSObject>

-(void)deselectLeftMenuWithIndexPath:(NSIndexPath *)indexPath;

-(void)clearDetailViewControllerSelectedProgram;

@end
@interface LSMasterViewController : UIViewController
/**
 实际价格
 */
@property (nonatomic,copy)NSString *catModelDetailPrice;
/**
 全款购车实际价格
 */
@property (nonatomic,copy)NSString *fullPaymentRealPrice;
/**
 金融产品个数
 */
@property (nonatomic,assign)int numberOfRows;
/**
 选中的金融产品modelArray
 */
@property (nonatomic,copy)NSMutableArray *choosedProductsModelArray;
@property(nonatomic,weak)LSVSFinancialProgramViewController *mainVC;
@property (nonatomic,weak)id<LSMasterViewControllerDelegate> delegate;
@end
