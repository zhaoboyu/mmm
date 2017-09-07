//
//  LLFKnowledgeBaseViewController.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/17.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFKnowledgeBaseViewController.h"
#import "LLFKnowledgeBaseView.h"
#import "CTTXRequestServer+statusCodeCheck.h"
@interface LLFKnowledgeBaseViewController ()
@property (nonatomic,strong)LLFKnowledgeBaseView *knowledgeBaseView;
@end

@implementation LLFKnowledgeBaseViewController
- (void)loadView
{
    [super loadView];
    self.knowledgeBaseView = [[LLFKnowledgeBaseView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view = self.knowledgeBaseView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self creatNativeView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self creatNativeView];
    // Do any additional setup after loading the view.
}
- (void)creatNativeView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_Nav"] forBarMetrics:UIBarMetricsDefault];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back_Nav"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
////    self.navigationItem.rightBarButtonItem =nil;
//    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
//    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor hexString:@"#FFFFFFFF"]];
    
    self.navigationItem.title = @"知识库";
    NSMutableDictionary *titleAttributesDic = [NSMutableDictionary dictionary];
    [titleAttributesDic setObject:[UIColor hexString:@"#FFFFFFFF"] forKey:NSForegroundColorAttributeName];
    [titleAttributesDic setObject:[UIFont systemFontOfSize:18.0] forKey:NSFontAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributesDic];
    
}
//#pragma mark 返回
//- (void)leftBarButtonItemAction:(UIButton *)sender
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
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
