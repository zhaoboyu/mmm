//
//  ZBYWorkBenchViewController.m
//  YDJR
//
//  Created by 赵博宇 on 2017/5/4.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "ZBYWorkBenchViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
//自定义view
#import "LLFWorkBenchView.h"
#import "LLFWorkBenchLeftItemView.h"

//接口API
#import "CTTXRequestServer+WorkBench.h"
#import "CTTXRequestServer+CustomerManager.h"
#import "CTTXRequestServer+LetterofIntent.h"
#import "CTTXRequestServer+statusCodeCheck.h"

//数据Model
#import "LLFPieChartViewDataModel.h"
#import "MessageModel.h"
#import "LLFWorkBenchViewModel.h"
#import "LLFWorkBenchModel.h"
#import "LLFWorkBenchUserInfoViewModel.h"
#import "LLFProductTypePieChartViewModel.h"
#import "LLFProductTypeDIYLineChartViewModel.h"
#import "FinalApprovalView.h"
@interface ZBYWorkBenchViewController ()<LLFWorkBenchLeftItemViewDelegate,LLFWorkBenchViewDelegate>
@property (nonatomic,strong)LLFWorkBenchView *workBenchView;
@property (nonatomic,strong)LLFWorkBenchLeftItemView *leftItemView;
@property (nonatomic,strong)HGBPromgressHud *phud;
@end

@implementation ZBYWorkBenchViewController
- (void)loadView
{
    [super loadView];
    self.workBenchView = [[LLFWorkBenchView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.workBenchView.delegate = self;
    self.view = self.workBenchView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self checkWokBench];
    [self updataForeView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNativeView];
    self.workBenchView.agencyListView.agencyListTableView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewWokBench)];
    // Do any additional setup after loading the view.
    
}
#pragma mark 设置导航栏
- (void)creatNativeView
{
    //设置背景色
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor hex:@"#FF333333"];
    
    //设置导航栏左侧iteam
    self.leftItemView = [[LLFWorkBenchLeftItemView alloc]initWithFrame:CGRectMake(0, 0, 480 * wScale, 44)];
    self.leftItemView.delegate = self;
//    self.leftItemView.titleArr = @[[Tool getMechanismName]?[Tool getMechanismName]:@""];
    UserDataModel *userModel = [UserDataModel sharedUserDataModel];
    self.leftItemView.titleArr = userModel.mechanismName;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftItemView];
    
    //设置标题
    self.title = @"工作台";
    NSMutableDictionary *titleAttributesDic = [NSMutableDictionary dictionary];
    [titleAttributesDic setObject:[UIColor hexString:@"#FFFFFFFF"] forKey:NSForegroundColorAttributeName];
    [titleAttributesDic setObject:[UIFont systemFontOfSize:17.0] forKey:NSFontAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributesDic];
}
#pragma mark 刷新数据
- (void)updataForeView
{
    UserDataModel *userModel = [UserDataModel sharedUserDataModel];
//    self.leftItemView.titleArr = @[[Tool getMechanismName]?[Tool getMechanismName]:@""];
    self.leftItemView.titleArr = userModel.mechanismName;
    self.workBenchView.userInfoView.userModel = userModel;
//    self.workBenchView.productTypePieChartView.pieChartViewDataModelArr = [self pieChartViewDataModelArrForProductType];
//    [self.workBenchView.productTypePieChartView setcentText:@"订单总数" total:1000];
}
#pragma mark 获取数据
- (void)checkWokBench
{
    
    [self.phud showHUDSaveAddedTo:self.workBenchView];
    [[CTTXRequestServer shareInstance] checkWorkBenchWithSuccessBlock:^(NSMutableArray *workCompleteTaskModelArr,NSMutableArray *waitTaskModelArr,SysHeadModel *sysHeadModel) {
        [self.phud hideSave];
        if ([sysHeadModel.ReturnCode isEqualToString:@"00"]) {
            self.workBenchView.agencyListView.waitTaskModelArr = waitTaskModelArr;
            self.workBenchView.agencyListView.workCompleteTaskModelArr = workCompleteTaskModelArr;
            NSMutableArray *workModelArr = [NSMutableArray array];
            [workModelArr addObjectsFromArray:workCompleteTaskModelArr];
            [workModelArr addObjectsFromArray:waitTaskModelArr];
            self.workBenchView.userInfoView.workBenchUserInfoViewModel = [LLFWorkBenchUserInfoViewModel initWithWorkModelArr:workModelArr];
            self.workBenchView.productTypePieChartView.productTypePieChartViewModel = [LLFProductTypePieChartViewModel initWithWorkModelArr:workModelArr];
            self.workBenchView.productTypeLineChartView.productTypeLineViewMode = [LLFProductTypeDIYLineChartViewModel initWithWorkModelArr:workModelArr];
    
        }else{
            self.phud.promptStr = sysHeadModel.ReturnMessage;
            [self.phud showHUDResultAddedTo:self.workBenchView];
        }
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        self.phud.promptStr = NetWorkFailHUD;
        [self.phud showHUDResultAddedTo:self.workBenchView];
    }];
}
- (void)loadNewWokBench
{
    [[CTTXRequestServer shareInstance] checkWorkBenchWithSuccessBlock:^(NSMutableArray *workCompleteTaskModelArr,NSMutableArray *waitTaskModelArr,SysHeadModel *sysHeadModel) {
        [self.workBenchView.agencyListView.agencyListTableView.tableView.mj_header endRefreshing];
        if ([sysHeadModel.ReturnCode isEqualToString:@"00"]) {
            self.workBenchView.agencyListView.waitTaskModelArr = waitTaskModelArr;
            self.workBenchView.agencyListView.workCompleteTaskModelArr = workCompleteTaskModelArr;
            NSMutableArray *workModelArr = [NSMutableArray array];
            [workModelArr addObjectsFromArray:workCompleteTaskModelArr];
            [workModelArr addObjectsFromArray:waitTaskModelArr];
            self.workBenchView.userInfoView.workBenchUserInfoViewModel = [LLFWorkBenchUserInfoViewModel initWithWorkModelArr:workModelArr];
            self.workBenchView.productTypePieChartView.productTypePieChartViewModel = [LLFProductTypePieChartViewModel initWithWorkModelArr:workModelArr];
            self.workBenchView.productTypeLineChartView.productTypeLineViewMode = [LLFProductTypeDIYLineChartViewModel initWithWorkModelArr:workModelArr];
            
        }else{
            self.phud.promptStr = sysHeadModel.ReturnMessage;
            [self.phud showHUDResultAddedTo:self.workBenchView];
        }
    } failedBlock:^(NSError *error) {
        [self.workBenchView.agencyListView.agencyListTableView.tableView.mj_header endRefreshing];
        self.phud.promptStr = NetWorkFailHUD;
        [self.phud showHUDResultAddedTo:self.workBenchView];
    }];
}
#pragma mark 响应事件
// 意向单产品的点击响应事件
- (void)customerIntrestStateButtonActionWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel
{
    if ([workBenchModel.intentModelInfo.state isEqualToString:@"16"] || [workBenchModel.intentModelInfo.patchState isEqualToString:@"01"] || [workBenchModel.intentModelInfo.state isEqualToString:@"00"]) {
        if ([workBenchModel.state isEqualToString:@"16"]) {
            [self.phud showHUDSaveAddedTo:self.view];
            [[CTTXRequestServer shareInstance] checkZhongShenWithIntentID:workBenchModel.businessId SuccessBlock:^(LLFFinalApprovalModel *finalApprovalModel) {
                [self.phud hideSave];
                //查看终审批复文档
                CGRect rect = self.view.bounds;
                rect.origin.x = rect.size.width;
                FinalApprovalView *finalApprovalView = [[FinalApprovalView alloc]initWithFrame:rect finalApprovalModel:finalApprovalModel from:YES];
                [self.view addSubview:finalApprovalView];
                [UIView animateWithDuration:0.2 animations:^{
                    CGRect frame = finalApprovalView.frame;
                    frame.origin.x = 0;
                    finalApprovalView.frame = frame;
                } completion:^(BOOL finished) {
                    
                }];
            } failedBlock:^(NSError *error) {
                [self.phud hideSave];
                self.phud.promptStr = @"网络状况不好,请稍后重试!";
                [self.phud showHUDResultAddedTo:self.view];
            }];
            
        }else{
            //补件中 或一次进件
            [self.phud showHUDSaveAddedTo:self.view];
            [LLFWorkBenchViewModel checkMessageWithWorkBenchModel:workBenchModel SuccessBlock:^(MessageModel *messageModel, NSDictionary *responseDict) {
                [self.phud hideSave];
                NSDictionary *StatusCodeRM = [messageModel yy_modelToJSONObject];
                NSMutableDictionary *mStatusCodeRM = [StatusCodeRM mutableCopy];
                [[NSUserDefaults standardUserDefaults]setObject:mStatusCodeRM forKey:@"StatusCodeRM"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                MainViewController *mainVC = [MainViewController new];
                mainVC.isHaveTop = NO;
                mainVC.startPage = @"imageData.html";
                mainVC.isDaFenQiApply = YES;
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appDelegate.mainVC = mainVC;
                [[UIViewController currentViewController] presentViewController:mainVC animated:YES completion:nil];
            } failedBlock:^(NSError *error) {
                [self.phud hideSave];
                self.phud.promptStr = @"网络请求失败,请稍后重试";
                [self.phud showHUDResultAddedTo:self.view];
            }];
        }
        
    }else{
        //插件传值
        //转借状态 0非转接  1转借
        NSNumber *zhuanjieState;
        if ([workBenchModel.state isEqualToString:@"06"]) {
            zhuanjieState = @(1);
        } else {
            zhuanjieState = @(0);
        }
        
        //是否是金融经理
        UserDataModel *userDataModel = [UserDataModel sharedUserDataModel];
        NSNumber *isFinanceManager = [NSNumber numberWithBool:userDataModel.isFinancialManagers];
        
        BOOL isinformationTWeb;
        if (zhuanjieState.intValue == 1 && isFinanceManager.intValue == 1) {
            isinformationTWeb = YES;
        } else {
            isinformationTWeb = NO;
        }
        
        //是否自营
        NSNumber *isSelfRun = workBenchModel.intentModelInfo.productState;
        if (!isSelfRun) {
            isSelfRun = @(-1);
        }
        //如果是达分期，那么
        //        if (weakSelf.customerIntrestModel.isInsFq.intValue == 1) {
        //            isSelfRun = @(3);
        //        }
        
        
        //0、车辆品牌、1、达分期产品id、2、客户id、3、开票价、4、达芬奇产品名称、5、角色权限(1:金融经理,0:销售经理)、6、是否自营(是否自营 1自营 2代理 3达分期)、7、转借状态(0非转接  1转借)、8、意向单id、9、客户类型(01:企业,02:个人) 10.车辆销售名称，11.车辆指导价,12.购置税,13.保险费
        NSString *productState = [NSString stringWithFormat:@"%@",isSelfRun];
        NSMutableArray *paramArray = [NSMutableArray arrayWithObjects:workBenchModel.intentModelInfo.carPpName,workBenchModel.intentModelInfo.productID,workBenchModel.customerModelInfo.customerID,workBenchModel.intentModelInfo.contractAmount,workBenchModel.productName,isFinanceManager,productState,zhuanjieState,workBenchModel.intentModelInfo.intentID,workBenchModel.customerModelInfo.customerType,workBenchModel.intentModelInfo.catModelDetailName,workBenchModel.intentModelInfo.carPrice,workBenchModel.intentModelInfo.purchasetax,workBenchModel.intentModelInfo.insurance, nil];
        
        //存储本地
        [Tool saveIntentValueWithValueArr:paramArray];
        
        //存储当前客户信息
        NSDictionary *customerInfo = [workBenchModel.customerModelInfo yy_modelToJSONObject];
        
        [[NSUserDefaults standardUserDefaults] setObject:customerInfo forKey:@"customerInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //        [NSFileManager saveArrayToPath:DirectoryTypeDocuments withFilename:@"customIntrestInfo" array:paramArray];
        
        //如果是金融经理+转借中 跳application_informationB.html
        //如果不是金融经理+转借中 跳index
        if (isinformationTWeb) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:workBenchModel.intentModelInfo.intentID forKey:@"intentID"];
            [dic setObject:workBenchModel.intentModelInfo.productID forKey:@"productID"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:dic forKey:@"lookApply"];
            [defaults synchronize];
            MainViewController *mainVC = [MainViewController new];
            mainVC.startPage = @"application_informationB.html";
            mainVC.isHaveTop = NO;
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.mainVC = mainVC;
            
            [self presentViewController:mainVC animated:YES completion:nil];
            
            
            
        }else {
            MainViewController *mainVC = [MainViewController new];
            mainVC.isHaveTop = NO;
            //之后删除
            //mainVC.startPage = @"imageData.html";
            //mainVC.startPage = @"toStaging.html";
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.mainVC = mainVC;
            
            [self presentViewController:mainVC animated:YES completion:nil];
            
        }
    }
    
}

/**
 达分期产品的点击响应事件
 */
- (void)dafenqiProcessStateButtonActionWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel
{
    [self.phud showHUDSaveAddedTo:self.view];
    [LLFWorkBenchViewModel checkMessageWithWorkBenchModel:workBenchModel SuccessBlock:^(MessageModel *messageModel, NSDictionary *responseDict) {
        [self.phud hideSave];
        if (responseDict) {
            //客户拒绝-进行重启流程
            [self dafenqiRestartButtonActionWithMessageModel:messageModel respoonseDict:responseDict];
        }else{
            NSDictionary *StatusCodeRM = [messageModel yy_modelToJSONObject];
            NSMutableDictionary *mStatusCodeRM = [StatusCodeRM mutableCopy];
            [mStatusCodeRM setObject:[NSString stringWithFormat:@"%@.pdf",workBenchModel.dfqModelInfo.loanContractNo] forKey:@"loanContractNo"];
            [mStatusCodeRM setObject:[NSString stringWithFormat:@"%@.pdf",workBenchModel.dfqModelInfo.insuranceContractNo] forKey:@"insuranceContractNo"];
            [[NSUserDefaults standardUserDefaults]setObject:mStatusCodeRM forKey:@"StatusCodeRM"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            MainViewController *mainVC = [MainViewController new];
            mainVC.isHaveTop = NO;
            mainVC.startPage = [Tool getWWWPackAddressWithIndexName:@"imageData.html"];
            mainVC.isDaFenQiApply = YES;
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.mainVC = mainVC;
            [[UIViewController currentViewController] presentViewController:mainVC animated:YES completion:nil];
        }
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        self.phud.promptStr = @"网络请求失败,请稍后重试";
        [self.phud showHUDResultAddedTo:self.view];
    }];
}

/**
 达分期重启流程
 */
- (void)dafenqiRestartButtonActionWithMessageModel:(MessageModel *)messageModel respoonseDict:(NSDictionary *)respoonseDict
{
    NSMutableDictionary *transferDict = [respoonseDict[@"res"] mutableCopy];
    //是否是扫描
    [transferDict setValue:@"1" forKey:@"isScan"];
    [transferDict setValue:messageModel.messageId forKey:@"messageId"];
    [[NSUserDefaults standardUserDefaults]setObject:transferDict forKey:@"dafenqiDic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    MainViewController *applyMainVC = [[MainViewController alloc]init];
    
    applyMainVC.startPage = [Tool getWWWPackAddressWithIndexName:@"toStaging.html"];
    applyMainVC.isDaFenQiApply = YES;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.mainVC = applyMainVC;
    [[UIViewController currentViewController] presentViewController:applyMainVC animated:YES completion:nil];
}
#pragma mark 测试数据获取
- (NSArray *)pieChartViewDataModelArrForUserInfo
{
    NSArray *items = @[[LLFPieChartViewDataModel initWithPieValue:10 pieText:@"开始申请"],
                       [LLFPieChartViewDataModel initWithPieValue:11 pieText:@"一次进件"],
                       [LLFPieChartViewDataModel initWithPieValue:12 pieText:@"二次进件"],[LLFPieChartViewDataModel initWithPieValue:13 pieText:@"补件"],[LLFPieChartViewDataModel initWithPieValue:14 pieText:@"需补保单"],[LLFPieChartViewDataModel initWithPieValue:15 pieText:@"已完成"]
                       ];

    return items;
}
- (NSArray *)pieChartViewDataModelArrForProductType
{
    NSArray *items = @[[LLFPieChartViewDataModel initWithPieValue:10 pieText:@"融资租赁标准产品"],[LLFPieChartViewDataModel initWithPieValue:13 pieText:@"银行贷款"],[LLFPieChartViewDataModel initWithPieValue:14 pieText:@"宝马贴息产品"],[LLFPieChartViewDataModel initWithPieValue:15 pieText:@"宝马尾款贴息"]
                       ];
    
    return items;
}
#pragma mark 代理
- (void)clickButtonWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel
{
    if ([workBenchModel.productType isEqualToString:@"01"]) {
        //达分期
        [self dafenqiProcessStateButtonActionWithWorkBenchModel:workBenchModel];
    }else if ([workBenchModel.productType isEqualToString:@"02"]){
        //自营及代理
        [self customerIntrestStateButtonActionWithWorkBenchModel:workBenchModel];
    }
}
//LLFWorkBenchLeftItemViewDelegate
- (void)selectMechanismName:(NSString *)mechanismName
{
    [self checkWokBench];
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}
#pragma mark 设置状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
