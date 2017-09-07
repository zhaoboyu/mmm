//
//  PersonViewController.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/16.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "PersonViewController.h"

@interface PersonViewController ()

@end

@implementation PersonViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigation];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



#pragma mark - set navigation
- (void)setNavigation {
    
    self.tabBarController.navigationItem.rightBarButtonItem =nil;
    [self.tabBarController.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    
    [self.tabBarController.navigationItem.leftBarButtonItem setTintColor:[UIColor hex:@"#FFFFFFFF"]];
    
    [self.tabBarController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_Nav"] forBarMetrics:UIBarMetricsDefault];
    
    self.tabBarController.navigationItem.title = @"我的";
    NSMutableDictionary *titleAttributesDic = [NSMutableDictionary dictionary];
    [titleAttributesDic setObject:[UIColor hex:@"#FFFFFFFF"] forKey:NSForegroundColorAttributeName];
    [titleAttributesDic setObject:[UIFont systemFontOfSize:18.0] forKey:NSFontAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributesDic];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
