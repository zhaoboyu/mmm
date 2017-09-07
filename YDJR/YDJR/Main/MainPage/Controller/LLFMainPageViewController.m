//
//  LLFMainPageViewController.m
//  YDJR
//
//  Created by 吕利峰 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFMainPageViewController.h"
#import "LLFMainPageView.h"
#import "LLFRightMenuView.h"
#import "LLFCarGroupViewController.h"
#import "SDCCustomerManagerController.h"
#import "LLFKnowledgeBaseViewController.h"
#import "LLFLoginViewController.h"
#import "MessageViewController.h"
#import "LLFMainPageViewModel.h"
#import "MessageModel.h"
#import "RevisePassworderPopView.h"
@interface LLFMainPageViewController ()<LLFMainPageViewDelegate,LLFRightMenuViewDelegate,RevisePassworderPopViewDelegate>
{
    BOOL _isShowRightView;//是否显示侧边栏
}
@property (nonatomic,strong)UserDataModel *userModel;
@property (nonatomic,strong)LLFMainPageView *mainPageView;
@property (nonatomic,strong)UILabel *leftTitleLabel;//机构名称
@property (nonatomic,strong)UIImageView *iconImageView;//用户头像
@property (nonatomic,strong)UILabel *userNameLabel;//用户名
@property (nonatomic,strong)UILabel *userRoleLabel;//用户角色
@property (nonatomic,strong)LLFRightMenuView *RightMenuView;//右边菜单栏
@property (nonatomic,strong)UIButton *rightMenuButton;

//@property (nonatomic,strong)RevisePassworderPopView *revisePassworderView;
@end

@implementation LLFMainPageViewController
- (void)loadView
{
    self.mainPageView = [[LLFMainPageView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.mainPageView.delegate = self;
    self.view = self.mainPageView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self queryMessageList];
      [self loadNativeView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.userModel = [UserDataModel sharedUserDataModel];
    [self queryMessageList];
//    [self loadNativeView];
    [self setupView];
    [self showReviseView];
    [self loadNewData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewData) name:@"login" object:@"login"];
    // Do any additional setup after loading the view.
}
- (void)loadNewData
{
    LLFUserRoleModel *userRoleModel = self.userModel.roles[0];
    NSString *userNameStr = self.userModel.userDesc;
    CGFloat widthStr1 = [Tool widthForString:userNameStr fontSize:10.0 andHight:10];
    
    CGFloat widthStr2 = [Tool widthForString:userRoleModel.roleName fontSize:10.0 andHight:10];
    CGFloat widthStr = widthStr1 >= widthStr2 ? widthStr1 : widthStr2;
    self.userNameLabel.frame = CGRectMake(CGRectGetMinX(self.rightMenuButton.frame) - 56 * wScale - widthStr, 11, widthStr, 10);
    self.userNameLabel.text = self.userModel.userDesc;
    
    self.userRoleLabel.frame = CGRectMake(CGRectGetMinX(self.userNameLabel.frame), CGRectGetMaxY(self.userNameLabel.frame) + 2, CGRectGetWidth(self.userNameLabel.frame), 10);
    self.userRoleLabel.text = userRoleModel.roleName;
    self.iconImageView.frame = CGRectMake(CGRectGetMinX(self.userNameLabel.frame) - 72 * wScale, 7, 60 * wScale, 60 * wScale);
}
- (void)loadNativeView
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_Nav"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor hexString:@"#FF15181D"];
    //左侧按钮
    UIView *leftItemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400 * wScale, 44)];
    UIImageView *logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 24 * hScale, 194 * wScale, 51 * hScale)];
    logoImageView.image = [UIImage imageNamed:@"item_Logo_nav"];
    [leftItemView addSubview:logoImageView];
    
    UIImageView *leftLineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(logoImageView.frame) + 24 * wScale, 35 * hScale, 1 * wScale, 10)];
    leftLineImageView.image = [UIImage imageNamed:@"line_nav"];
    [leftItemView addSubview:leftLineImageView];
    
    self.leftTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftLineImageView.frame) + 12 * wScale, 0, 100, 44)];
    self.leftTitleLabel.text = self.userModel.mechanismName;
    self.leftTitleLabel.textColor = [UIColor hexString:@"#FF999999"];
    self.leftTitleLabel.font = [UIFont systemFontOfSize:12.0];
    [leftItemView addSubview:self.leftTitleLabel];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftItemView];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 531 * wScale, 44)];
    //侧边栏
    self.rightMenuButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.rightMenuButton.frame = CGRectMake(CGRectGetWidth(rightView.frame) - 36 * wScale, 15.5, 36 * wScale, 13);
    [self.rightMenuButton setBackgroundImage:[UIImage imageNamed:@"icon_normal_menu"] forState:(UIControlStateNormal)];
    [self.rightMenuButton setBackgroundImage:[UIImage imageNamed:@"icon_pressed_menu"] forState:(UIControlStateHighlighted)];
    [self.rightMenuButton addTarget:self action:@selector(hideOrShowForRightMenuViewAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [rightView addSubview:self.rightMenuButton];
    
    UIButton *MenuButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    MenuButton.frame = CGRectMake(CGRectGetWidth(rightView.frame) - 36 * wScale, 0, 72 * wScale, CGRectGetHeight(rightView.frame));
    [MenuButton addTarget:self action:@selector(hideOrShowForRightMenuViewAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    MenuButton.backgroundColor = [UIColor redColor];
    [rightView addSubview:MenuButton];
    [rightView bringSubviewToFront:MenuButton];
    
    //用户名
    LLFUserRoleModel *userRoleModel = self.userModel.roles[0];
    NSString *userNameStr = self.userModel.userDesc;
    CGFloat widthStr1 = [Tool widthForString:userNameStr fontSize:10.0 andHight:10];
    
    CGFloat widthStr2 = [Tool widthForString:userRoleModel.roleName fontSize:10.0 andHight:10];
    CGFloat widthStr = widthStr1 >= widthStr2 ? widthStr1 : widthStr2;
    self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.rightMenuButton.frame) - 56 * wScale - widthStr, 11, widthStr, 10)];
    self.userNameLabel.text = userNameStr;
    self.userNameLabel.textColor = [UIColor hexString:@"#FF999999"];
    self.userNameLabel.font = [UIFont systemFontOfSize:10.0];
    [rightView addSubview:self.userNameLabel];
    //用户角色
    
    self.userRoleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userNameLabel.frame), CGRectGetMaxY(self.userNameLabel.frame) + 2, CGRectGetWidth(self.userNameLabel.frame), 10)];
    self.userRoleLabel.text = userRoleModel.roleName;
    self.userRoleLabel.textColor = [UIColor hexString:@"#FF999999"];
    self.userRoleLabel.font = [UIFont systemFontOfSize:10.0];
    [rightView addSubview:self.userRoleLabel];
    
    //头像
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userNameLabel.frame) - 72 * wScale, 7, 60 * wScale, 60 * wScale)];
    self.iconImageView.image = [UIImage imageNamed:@"tag_defaultt_ouxiang_nav"];
    [rightView addSubview:self.iconImageView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    
}
- (void)queryMessageList
{
    if (self.RightMenuView) {
//        [LLFMainPageViewModel checkMessageWithSuccessBlock:^(NSMutableArray *messageModelArr) {
//            
//            if (messageModelArr.count > 0) {
//                MessageModel *messageModel = messageModelArr[0];
//                self.mainPageView.messageLabel.text = messageModel.message;
//            }else{
//                self.mainPageView.messageLabel.text = @"暂无通知";
//            }
//            self.RightMenuView.messageNum = [self sumWithMessageArr:messageModelArr];
//        } failedBlock:^(NSError *error) {
//            NSArray *tempArr = [Tool unarcheiverWithfileName:MessagePath];
//            if (tempArr.count > 0) {
//                MessageModel *messageModel = tempArr[0];
//                self.mainPageView.messageLabel.text = messageModel.message;
//            }else{
//                self.mainPageView.messageLabel.text = @"暂无通知";
//            }
//            self.RightMenuView.messageNum = [self sumWithMessageArr:tempArr];
//        }];

    }
    
}
- (NSInteger)sumWithMessageArr:(NSArray *)messageArr
{
    NSInteger num = 0;
    for (MessageModel *model in messageArr) {
        if (!model.isRead) {
            num+=1;
        }
    }
    return num;
}
- (void)setupView
{
    NSArray *tempArr = [Tool unarcheiverWithfileName:MessagePath];
    self.RightMenuView = [[LLFRightMenuView alloc]initWithFrame:[[UIScreen mainScreen] bounds] messageNum:tempArr.count];
    self.RightMenuView.delegate = self;
    [self.mainPageView.messageButton addTarget:self action:@selector(messageButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
}
//判断是否是第一次登录
- (void)showReviseView
{
    UserDataModel *userModel = [UserDataModel sharedUserDataModel];
    if (userModel) {
        if ((userModel.logincnt == 0) || (userModel.logincnt == 1)) {
            RevisePassworderPopView *reviseView = [[RevisePassworderPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
            reviseView.delegate = self;
            [reviseView showView];
        }

    }
    
}
- (void)messageButtonAction:(UIButton *)sender
{
    //消息中心
    MessageViewController* vc=[[MessageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark LLFRightMenuView代理
- (void)sendButtonState:(NSString *)state
{
    if ([state isEqualToString:@"logOut"]) {
        //退出登录
        UserDataModel *userModel = [UserDataModel sharedUserDataModel];
        [userModel logOut];
        LLFLoginViewController *loginVC = [[LLFLoginViewController alloc]init];
        [self presentViewController:loginVC animated:YES completion:nil];
    }else if ([state isEqualToString:@"1"]){
        //消息中心
        MessageViewController* vc=[[MessageViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([state isEqualToString:@"revisePW"]){
        RevisePassworderPopView *reviseView = [[RevisePassworderPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        reviseView.delegate = self;
        [reviseView showView];
        
    }
}
#pragma mark 区分点击的事那个功能模块
- (void)sendButtonIndex:(NSString *)index
{
    if ([index isEqualToString:@"0"]) {
        //汽车馆模块
        NSLog(@"汽车馆模块");
        LLFCarGroupViewController *carGroupVC = [[LLFCarGroupViewController alloc]init];
        YDJRNavigationViewController *carGroupNC = [[YDJRNavigationViewController alloc]initWithRootViewController:carGroupVC];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"carSeriesJkhgc"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self presentViewController:carGroupNC animated:YES completion:nil];
    }else if ([index isEqualToString:@"1"]){
        //客户管理模块
        NSLog(@"客户管理模块");
        SDCCustomerManagerController *customerMangerVC = [[SDCCustomerManagerController alloc]init];
        YDJRNavigationViewController *customerMangerNC = [[YDJRNavigationViewController alloc]initWithRootViewController:customerMangerVC];
        [self presentViewController:customerMangerNC animated:YES completion:nil];
    }else if ([index isEqualToString:@"2"]){
        //知识库模块
        NSLog(@"知识库模块");
        LLFKnowledgeBaseViewController *knowledgeBaseVC = [[LLFKnowledgeBaseViewController alloc]init];
        YDJRNavigationViewController *knowledgeBaseNC = [[YDJRNavigationViewController alloc]initWithRootViewController:knowledgeBaseVC];
        [self presentViewController:knowledgeBaseNC animated:YES completion:nil];
    }
}
#pragma mark RevisePassworderPopViewDelegate代理
- (void)sendReviseState:(NSString *)state
{
    if ([state isEqualToString:@"revisePW"]) {
        UserDataModel *userModel = [UserDataModel sharedUserDataModel];
        [userModel logOut];
        LLFLoginViewController *loginVC = [[LLFLoginViewController alloc]init];
        [self presentViewController:loginVC animated:YES completion:nil];

    }
}
#pragma mark 显示或隐藏侧边栏
- (void)hideOrShowForRightMenuViewAction:(UIButton *)sender
{
//    if (!_isShowRightView) {
        //未显示侧边栏时,显示侧边栏
        NSLog(@"显示侧边栏");
        [self.RightMenuView showRightmenuView];
//    }
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
