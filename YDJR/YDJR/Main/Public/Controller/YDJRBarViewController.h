//
//  YDJRBarViewController.h
//  YDJR
//
//  Created by 赵博宇 on 2017/5/4.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YDJRNavigationViewController.h"
#import "WPQCarGroupViewController.h"
#import "SDCCustomerManagerController.h"
#import "LLFKnowledgeBaseViewController.h"
#import "ZBYPersonViewController.h"
#import "ZBYWorkBenchViewController.h"
@interface YDJRBarViewController : UITabBarController
@property(nonatomic,strong)YDJRNavigationViewController *carGroupNavigationVC;
@property(nonatomic,strong)YDJRNavigationViewController *CustomerManageNavigationVC;
@property(nonatomic,strong)YDJRNavigationViewController *knowledgeNavigationVC;
@property(nonatomic,strong)YDJRNavigationViewController *mineNavigationVC;
@property(nonatomic,strong)YDJRNavigationViewController *workBenchNavigationVC;
@end
