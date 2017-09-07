//
//  LSCarDetailsViewController.h
//  YDJR
//
//  Created by 李爽 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSCarDetailsView;
@class LSFinancialProgramViewController;
@class LLFInsuranceInfoViewController;
@class LLFCarModel;
@interface LSCarDetailsViewController : UIViewController
@property (nonatomic,strong)LLFCarModel *carModel;
@property (nonatomic,strong)LSCarDetailsView *carDetailsView;
@property (nonatomic,strong)LSFinancialProgramViewController *financialProgramVC;
@property (nonatomic,strong)LLFInsuranceInfoViewController *insuranceVC;
@end
