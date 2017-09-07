//
//  LSLeftMenuViewController.h
//  YDJR
//
//  Created by 李爽 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  对比金融方案Master控制器

#import <UIKit/UIKit.h>
@class LSLeftMenuTableViewCell;
@class LSChoosedProductsModel;
@class LSVSFinancialProgramViewController;
@protocol LSLeftMenuViewControllerDelegate <NSObject>

-(void)deselectLeftMenuWithIndexPath:(NSIndexPath *)indexPath;

-(void)clearDetailViewControllerSelectedProgram;

@end
@interface LSLeftMenuViewController : UIViewController
@property (nonatomic,weak)id<LSLeftMenuViewControllerDelegate> delegate;
@property (nonatomic,copy)NSString *catModelDetailPrice;//车辆价格
@property (nonatomic,assign)int numberOfRows;
@property (nonatomic,copy)NSMutableArray *choosedProductsModelArray;
@property(nonatomic,weak)LSVSFinancialProgramViewController *mainVC;
@end
