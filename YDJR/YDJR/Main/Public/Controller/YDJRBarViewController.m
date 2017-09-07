//
//  YDJRBarViewController.m
//  YDJR
//
//  Created by 赵博宇 on 2017/5/4.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "YDJRBarViewController.h"


@interface YDJRBarViewController ()<UINavigationControllerDelegate>

@end
@implementation YDJRBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.translucent = YES;
    self.tabBar.tintColor = [UIColor blackColor];
    [self initViewControllers];
}
- (void) initViewControllers{
    
    
    WPQCarGroupViewController *car = [[WPQCarGroupViewController alloc] init];
    self.carGroupNavigationVC = [self createController:car];
    
    SDCCustomerManagerController *customer = [[SDCCustomerManagerController alloc] init];
    self.CustomerManageNavigationVC = [self createController:customer];
    
    ZBYWorkBenchViewController *work = [[ZBYWorkBenchViewController alloc]init];
    self.workBenchNavigationVC  = [self createController:work];
    
    ZBYPersonViewController * mine  = [[ZBYPersonViewController alloc]  init];
    self.mineNavigationVC = [self createController:mine];
   self.mineNavigationVC.navigationBar.tintColor = [UIColor blackColor];
    
    LLFKnowledgeBaseViewController *knowLedge = [[LLFKnowledgeBaseViewController alloc]init];
    self.knowledgeNavigationVC = [self createController:knowLedge];
    
    self.viewControllers = [NSArray arrayWithObjects:self.workBenchNavigationVC,self.carGroupNavigationVC,self.CustomerManageNavigationVC,self.knowledgeNavigationVC,self.mineNavigationVC, nil];
    
    [self setUptabBarItem];
}
-(void)setUptabBarItem
{
   
    self.workBenchNavigationVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"工作台" image:[UIImage imageNamed:@"icon_normal_gongzuotai"] selectedImage:[UIImage imageNamed:@"icon_pressed_gongzuotai"]];

    self.carGroupNavigationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"汽车馆"image:[UIImage imageNamed:@"icon_normal_qicheguan"]  selectedImage:[UIImage imageNamed:@"icon_pressed_qicheguan"]];
    self.CustomerManageNavigationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"客户管理" image:[UIImage imageNamed:@"icon_normal_kehuguanli"]  selectedImage:[UIImage imageNamed:@"icon_pressed_kehuguanli"]];
      self.knowledgeNavigationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"知识库" image:[UIImage imageNamed: @"icon_normal_zhishiku"]  selectedImage:[UIImage imageNamed:@"icon_pressed_zhishiku"]];
    self.mineNavigationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"image:[UIImage imageNamed: @"icon_normal_wode"]  selectedImage:[UIImage imageNamed:@"icon_pressed_wode"]];
}
- (YDJRNavigationViewController *) createController:(UIViewController *) controller
{
    YDJRNavigationViewController *nav = [[YDJRNavigationViewController alloc] initWithRootViewController:controller];
    [nav setDelegate:self];
    nav.navigationBar.translucent = NO;
    return nav;
}

@end
