//
//  WPQCarGroupViewController.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/20.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "WPQCarGroupViewController.h"
#import "LLFCarGroupView.h"
#import "LLFSeriesListView.h"
#import "LLFCarModelListView.h"
#import "LLFCarModelDetailView.h"
#import "LLFCarGroupViewModel.h"
#import "LSCarDetailsViewController.h"
#import "WPQCarGroupTopViw.h"
#import "LLFSelectNewCarTypeViewController.h"
#import "LLFPersonCenterPopView.h"
#import "LLFMainPageViewModel.h"
#import "MessageCenterViewModel.h"
//二维码扫描
#import "HGBScanViewController.h"

@interface WPQCarGroupViewController ()<LLFSeriesListViewDelegate,LLFCarGroupViewDelegate,LLFCarModelListViewDelegate,LLFCarModelDetailViewDelegate,LLFPersonCenterPopViewDelegate,WPQCarGroupTopViwDelegate>
@property (nonatomic,strong)LLFCarGroupView *selectCarGroupView;
@property (nonatomic,strong)LLFCarGroupView *allCarGroupView;
@property (nonatomic,strong)LLFCarGroupView *homebredCarGroupView;
@property (nonatomic,strong)LLFCarGroupView *importCarGroupView;
@property (nonatomic,strong)LLFSeriesListView *seriesListView;
@property (nonatomic,strong)LLFCarModelListView *carModelListView;
@property (nonatomic,strong)LLFCarModelDetailView *carModelDetaileView;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)HGBPromgressHud *phud;
@property (nonatomic,strong)LLFMechanismCarModel *MechanismModel;
@property (nonatomic,strong)LLFCarSeriesCarModel *carSeriesCarModel;
@property (nonatomic,strong)WPQCarGroupTopViw *topView;

/**
 消息个数
 */
@property (nonatomic,copy)NSString *messageCount;

/**
 消息数组
 */
@property (nonatomic,strong)NSMutableArray *messageArr;
@property (nonatomic,strong)UILabel *iconMessageNumLabel;
@property (nonatomic,strong)UIImageView *iconMessageNumBGImageView;
@property (nonatomic,strong)NSMutableArray *boxArr;
@end

@implementation WPQCarGroupViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadMessageData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    [self showReviseView];
    [self stepUI];
//    [self queryMechanismCarModelList];
    [self brandSeletedReload];
    //注册通知,接受新消息通知更新界面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadMessageData) name:@"loadMessage" object:@"loadMessage"];
}
-(void)stepUI{
    
    self.topView=[[WPQCarGroupTopViw alloc] initWithFrame:CGRectMake(0, 40*hScale, kWidth, 88*hScale)];
    self.topView.presentVC = self;
    self.topView.delegate = self;
    [self.view addSubview:self.topView];
    
    _myScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), kWidth, kHeight-CGRectGetMaxY(self.topView.frame))];
    _myScrollView.directionalLockEnabled = YES;
    _myScrollView.contentSize=CGSizeMake(kWidth*3,_myScrollView.frame.size.height);
    _myScrollView.pagingEnabled=YES;
    _myScrollView.delegate=self;
    _myScrollView.showsHorizontalScrollIndicator = false;
    _myScrollView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_myScrollView];
    
    CGRect bounds=_myScrollView.bounds;
    CGRect _allFrame=CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    _allCarGroupView = [[LLFCarGroupView alloc]initWithFrame:_allFrame];
    _allCarGroupView.delegate = self;
    _allCarGroupView.collectionView.mj_y = 0*hScale;
    _allCarGroupView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewMechanismCarModelList)];
    
    //获取本地缓存数据
    NSString *allCarPath = [NSString stringWithFormat:@"%@%@carSerierModelArrPath%@",[Tool getMechinsId],[Tool getPpName],@"2"];
    NSArray *allCarArr = [Tool unarcheiverWithfileName:allCarPath];
    if (allCarArr.count > 0) {
        _allCarGroupView.mechanisCarModelArr = [NSMutableArray arrayWithArray:allCarArr];
    }
    [_myScrollView addSubview:_allCarGroupView];
    
    CGRect _homebredFrame=CGRectMake(bounds.size.width, 0, bounds.size.width, bounds.size.height);
    _homebredCarGroupView=[[LLFCarGroupView alloc] initWithFrame:_homebredFrame];
    _homebredCarGroupView.delegate = self;
    _homebredCarGroupView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewMechanismCarModelList)];
    //获取本地缓存数据
    NSString *homeCarPath = [NSString stringWithFormat:@"%@%@carSerierModelArrPath%@",[Tool getMechinsId],[Tool getPpName],@"0"];
    NSArray *homeCarArr = [Tool unarcheiverWithfileName:homeCarPath];
    if (allCarArr.count > 0) {
        _homebredCarGroupView.mechanisCarModelArr = [NSMutableArray arrayWithArray:homeCarArr];
    }
    [_myScrollView addSubview:_homebredCarGroupView];
    
    CGRect _importFrame=CGRectMake(bounds.size.width*2, 0, bounds.size.width, bounds.size.height);
    _importCarGroupView=[[LLFCarGroupView alloc] initWithFrame:_importFrame];
    _importCarGroupView.delegate = self;
    _importCarGroupView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewMechanismCarModelList)];
    //获取本地缓存数据
    NSString *importCarPath = [NSString stringWithFormat:@"%@%@carSerierModelArrPath%@",[Tool getMechinsId],[Tool getPpName],@"1"];
    NSArray *importCarArr = [Tool unarcheiverWithfileName:importCarPath];
    if (allCarArr.count > 0) {
        _importCarGroupView.mechanisCarModelArr = [NSMutableArray arrayWithArray:importCarArr];
    }
    [_myScrollView addSubview:_importCarGroupView];
    
    _selectCarGroupView=_allCarGroupView;
    
    self.carModelListView = [[LLFCarModelListView alloc]initWithFrame:CGRectMake(kWidth, 0, kWidth , kHeight)];
    self.carModelListView.delegate = self;
    self.carModelListView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewSeriesCarModelList)];
    [self.view addSubview:self.carModelListView];
    self.carModelListView.hidden=YES;
    
    self.carModelDetaileView = [[LLFCarModelDetailView alloc]initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight)];
    self.carModelDetaileView.delegate = self;
    self.carModelDetaileView.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewCarModelList)];
    [self.view addSubview:self.carModelDetaileView];
    

    
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


#pragma mark 底部buttonAction
-(void)WPQBottomButtonBoxAction:(UIButton*)bt{
    if (bt.selected == NO) {
        for (WPQButtonBox* box  in self.view.subviews) {
            if ([box isKindOfClass:[WPQButtonBox class]]) {
                if (box.tag == bt.tag) {
                    switch (bt.tag) {
                        case 1000:{
                            //不做任何操作
                        }
                            
                            break;
                        case 1001:{
                            //客户管理模块
                            SDCCustomerManagerController *customerMangerVC = [[SDCCustomerManagerController alloc]init];
                            YDJRNavigationViewController *customerMangerNC = [[YDJRNavigationViewController alloc]initWithRootViewController:customerMangerVC];
                            [self presentViewController:customerMangerNC animated:YES completion:nil];
                        }
                            break;
                        case 1002:{
                            //知识库模块,先不让点击
                            LLFKnowledgeBaseViewController *knowledgeBaseVC = [[LLFKnowledgeBaseViewController alloc]init];
                            YDJRNavigationViewController *knowledgeBaseNC = [[YDJRNavigationViewController alloc]initWithRootViewController:knowledgeBaseVC];
                            [self presentViewController:knowledgeBaseNC animated:YES completion:nil];
                        }
                            break;
                            
                        case 1003:{
                            //我的
                            LLFPersonCenterPopView *personView = [[LLFPersonCenterPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
                            personView.delegate = self;
                            personView.messageCount = self.messageCount;
                            personView.messageArr = self.messageArr;
                            [personView showViewWithView:self.view];
                        }
                            
                            break;
                        default:
                            break;
                    }
                }
                
            }
        }
    }
}


#pragma mark scrollview移动
-(void)lineViewMove:(CGFloat)offX moveY:(CGFloat)offY buttonActionTag:(NSInteger)Tag{
    
    if (Tag == scrollViewDidScrollTag) {
        //scrollView偏移
        if (offX>=offY) {
            CGFloat offScale=offX/(_myScrollView.contentSize.width/3*2);
            [self.topView moveToScrollviewBorderScale:offScale];
            if (offScale == 0) {
                _selectCarGroupView=_allCarGroupView;
                [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"carSeriesJkhgc"];
                
            }
            else if (offScale == 0.5){
                _selectCarGroupView=_homebredCarGroupView;
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"carSeriesJkhgc"];
            }
            else if (offScale == 1.0){
                _selectCarGroupView=_importCarGroupView;
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"carSeriesJkhgc"];
            }
        }
        else{
            //offy>offx
            _myScrollView.contentOffset=CGPointMake(_myScrollView.contentOffset.x, _myScrollView.contentOffset.y);
            
        }
 
    }
           else {
        _myScrollView.contentOffset=CGPointMake(_myScrollView.contentSize.width/3*Tag, _myScrollView.contentOffset.y);
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    if (_selectCarGroupView.fristLoadData == NO) {
//        [self loadNewMechanismCarModelList];
//    }
    
}
#pragma mark scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    NSLog(@"%f",scrollView.contentOffset.x);
    [self lineViewMove:scrollView.contentOffset.x moveY:scrollView.contentOffset.y buttonActionTag:scrollViewDidScrollTag];
    
}

#pragma mark loadNewMechanismCarModelList回
- (void)loadNewMechanismCarModelList
{
 //   self.view.userInteractionEnabled = NO;
    //(1:进口,0:国产)
    if (self.topView.allButton.selected == YES) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"carSeriesJkhgc"];
    }
    else if(self.topView.homebredButton.selected == YES){
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"carSeriesJkhgc"];
    }
    else if(self.topView.importButton.selected == YES){
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"carSeriesJkhgc"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [LLFCarGroupViewModel getMechanismModelArrWithSuccessBlock:^(NSMutableArray *carModelArr) {
        [_selectCarGroupView.collectionView.mj_header endRefreshing];
        _selectCarGroupView.mechanisCarModelArr = carModelArr;
        _selectCarGroupView.fristLoadData=YES;
      //   self.view.userInteractionEnabled = YES;
    } failedBlock:^(NSError *error) {
        [_selectCarGroupView.collectionView.mj_header endRefreshing];
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.view];
        // self.view.userInteractionEnabled = YES;
    }];
}
#pragma mark 获取车系model列表数据
- (void)queryMechanismCarModelList
{
    //(1:进口,0:国产)
    if (self.topView.allButton.selected == YES) {
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"carSeriesJkhgc"];
    }
    else if(self.topView.homebredButton.selected == YES){
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"carSeriesJkhgc"];
    }
    else if(self.topView.importButton.selected == YES){
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"carSeriesJkhgc"];
    }
    
    [self.phud showHUDSaveAddedTo:self.view];
    [LLFCarGroupViewModel getMechanismModelArrWithSuccessBlock:^(NSMutableArray *carModelArr) {
        [self.phud hideSave];
        [_selectCarGroupView.collectionView.mj_header endRefreshing];
        _selectCarGroupView.mechanisCarModelArr = carModelArr;
        _selectCarGroupView.fristLoadData =YES;
        
    } failedBlock:^(NSError *error) {
        
        [_selectCarGroupView.collectionView.mj_header endRefreshing];
        [self.phud hideSave];
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.view];
    }];
}

- (void)loadNewSeriesCarModelList
{
    [LLFCarGroupViewModel getSerierModelArrWithMechanismModel:self.MechanismModel SuccessBlock:^(NSMutableArray *carModelArr) {
        [self.carModelListView.tableView.mj_header endRefreshing];
        self.carModelListView.seriesCarModelArr = carModelArr;
    } failedBlock:^(NSError *error) {
        [self.carModelListView.tableView.mj_header endRefreshing];
        //        self.carModelListView.seriesCarModelArr = [NSMutableArray array];
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.carModelListView];
    }];
}
#pragma mark 获取车型model列表数据
- (void)querySeriesCarModelList
{
    [self.phud showHUDSaveAddedTo:self.carModelListView];
    [LLFCarGroupViewModel getSerierModelArrWithMechanismModel:self.MechanismModel SuccessBlock:^(NSMutableArray *carModelArr) {
        [self.carModelListView.tableView.mj_header endRefreshing];
        [self.phud hideSave];
        self.carModelListView.seriesCarModelArr = carModelArr;
    } failedBlock:^(NSError *error) {
        [self.carModelListView.tableView.mj_header endRefreshing];
        //        self.carModelListView.seriesCarModelArr = [NSMutableArray array];
        [self.phud hideSave];
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.carModelListView];
    }];
    
    
}
- (void)loadNewCarModelList
{
    [LLFCarGroupViewModel getCarModelArrWithCarSeriesModel:self.carSeriesCarModel SuccessBlock:^(NSMutableDictionary *carModelDic) {
        [self.carModelDetaileView.tableView.mj_header endRefreshing];
        self.carModelDetaileView.carModelDic = carModelDic;
    } failedBlock:^(NSError *error) {
        [self.carModelDetaileView.tableView.mj_header endRefreshing];
        //        self.carModelDetaileView.carModelDic = [NSMutableDictionary dictionary];
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.carModelDetaileView];
    }];
}
#pragma mark 获取销售名称列表数据
- (void)queryCarModelList
{
    [self.phud showHUDSaveAddedTo:self.carModelDetaileView];
    [LLFCarGroupViewModel getCarModelArrWithCarSeriesModel:self.carSeriesCarModel SuccessBlock:^(NSMutableDictionary *carModelDic) {
        [self.carModelDetaileView.tableView.mj_header endRefreshing];
        [self.phud hideSave];
        self.carModelDetaileView.carModelDic = carModelDic;
    } failedBlock:^(NSError *error) {
        [self.carModelDetaileView.tableView.mj_header endRefreshing];
        //        self.carModelDetaileView.carModelDic = [NSMutableDictionary dictionary];
        [self.phud hideSave];
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.carModelDetaileView];
    }];
    
    
}
#pragma mark LLFSeriesListView 代理
- (void)seriesListButtonMechanismModel:(LLFMechanismCarModel *)MechanismModel
{
    self.MechanismModel = MechanismModel;
    if (self.carModelListView.frame.origin.x == CGRectGetMaxX(self.lineView.frame)) {
        self.carModelDetaileView.frame = CGRectMake(0, 0, kWidth ,kHeight);
        [self.view bringSubviewToFront:self.carModelListView];
        [self querySeriesCarModelList];
    }else{
        self.carModelDetaileView.frame = CGRectMake(0, 0, kWidth ,kHeight);
        [self.view bringSubviewToFront:self.carModelListView];
        [UIView animateWithDuration:0.2 animations:^{
            self.carModelListView.frame = CGRectMake(CGRectGetMaxX(self.lineView.frame), 0, kWidth - CGRectGetMaxX(self.lineView.frame), CGRectGetHeight(self.seriesListView.frame));
        } completion:^(BOOL finished) {
            [self querySeriesCarModelList];
        }];
    }
    
}

//更换车系类别
- (void)selectCarTypeWithCarType:(NSString *)carType
{
    [[NSUserDefaults standardUserDefaults] setObject:carType forKey:@"carSeriesJkhgc"];
    
    [self queryMechanismCarModelList];
}
#pragma mark LLFCarGroupView 代理
- (void)carGroupButtonMechanismModel:(LLFMechanismCarModel *)MechanismModel
{
    self.carModelListView.hidden=NO;
    self.MechanismModel = MechanismModel;
    if (self.carModelListView.frame.origin.x == CGRectGetMaxX(self.lineView.frame)) {
        [self querySeriesCarModelList];
    }else{
        //        [UIView animateWithDuration:0.2 animations:^{
        //            self.carModelListView.frame = CGRectMake(0, 0, kWidth,kHeight);
        //        } completion:^(BOOL finished) {
        //            [self querySeriesCarModelList];
        //        }];
        LLFSelectNewCarTypeViewController *selectNewCarVC = [[LLFSelectNewCarTypeViewController alloc]init];
        selectNewCarVC.mechanismCarModel = MechanismModel;
        YDJRNavigationViewController *selectNewCarNC = [[YDJRNavigationViewController alloc]initWithRootViewController:selectNewCarVC];
        [self presentViewController:selectNewCarNC animated:YES completion:nil];
        
    }
}
#pragma mark LLFCarModelListView 代理
- (void)carModelListButtonState:(id)state
{
    self.carSeriesCarModel = state;
    self.carModelDetaileView.frame = CGRectMake(0, 0, kWidth, kHeight);
    [self.view bringSubviewToFront:self.carModelDetaileView];
    if ([state isEqual:@"返回"]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.carModelListView.frame = CGRectMake(kWidth, 0, kWidth , kHeight);
            self.carModelDetaileView.frame=CGRectMake(kWidth, 0, kWidth , kHeight);
        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        //跳转到销售名称界面
        self.carModelDetaileView.carSeriesCarModel = self.carSeriesCarModel;
        [UIView animateWithDuration:0.2 animations:^{
            self.carModelDetaileView.frame =  CGRectMake(0, 0, kWidth, kHeight);
        } completion:^(BOOL finished) {
            [self queryCarModelList];
        }];
        
    }
}
#pragma mark LLFCarModelDetailView 代理
- (void)carModelDetailButtonState:(id)state
{
    if ([state isEqual:@"返回"]) {
        [UIView animateWithDuration:0.2 animations:^{
            self.carModelDetaileView.frame = CGRectMake(kWidth, 0, kWidth , kHeight);
            self.carModelListView.frame = CGRectMake(0, 0, kWidth , kHeight);
        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        LLFCarModel *carModel = state;
        LSCarDetailsViewController *carDetailsVC = [[LSCarDetailsViewController alloc]init];
        carDetailsVC.carModel = carModel;
        [self.navigationController pushViewController:carDetailsVC animated:YES];
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
#pragma mark WPQCarGroupTopViwDelegate
- (void)dafenqiApplyScanButtonAction:(id)state
{
    //判断是否为金融经理
    if ([[UserDataModel sharedUserDataModel] isFinancialManagers]) {
        HGBScanViewController *vc = [HGBScanViewController new];
        
        YDJRNavigationViewController *scanNC = [[YDJRNavigationViewController alloc]initWithRootViewController:vc];
        //    scanNC.navigationBarHidden=YES;
        [self presentViewController:scanNC animated:YES
                         completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有权限进行达分期产品的申请,请确认后重试!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }
    
}
-(void)brandSeletedReload{
//    [_selectCarGroupView.collectionView.mj_header beginRefreshing];
    [self queryMechanismCarModelList];
   // [self loadNewMechanismCarModelList];
           if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"carSeriesJkhgc"] isEqualToString:@"0"]) {
        
                    [LLFCarGroupViewModel getMechanismModelArrWithcarSeriesJkhgc:@"0" SuccessBlock:^(NSMutableArray *carModelArr) {
        
                        [_homebredCarGroupView.collectionView.mj_header endRefreshing];
        
                        _homebredCarGroupView.mechanisCarModelArr = carModelArr;
        
                        self.view.userInteractionEnabled = YES;
        
                    } failedBlock:^(NSError *error) {
        
                        [_homebredCarGroupView.collectionView.mj_header endRefreshing];
        
                        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        
                        [self.phud showHUDResultAddedTo:self.view];
        
                        self.view.userInteractionEnabled = YES;
        
                    }];
        
                }
        
                if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"carSeriesJkhgc"] isEqualToString:@"1"]) {
        
        
        
                    [LLFCarGroupViewModel getMechanismModelArrWithcarSeriesJkhgc:@"1" SuccessBlock:^(NSMutableArray *carModelArr) {
        
                        [_importCarGroupView.collectionView.mj_header endRefreshing];
        
                        _importCarGroupView.mechanisCarModelArr = carModelArr;
        
                        self.view.userInteractionEnabled = YES;
        
                    } failedBlock:^(NSError *error) {
        
                        [_importCarGroupView.collectionView.mj_header endRefreshing];
        
                        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        
                        [self.phud showHUDResultAddedTo:self.view];
        
                        self.view.userInteractionEnabled = YES;
        
                    }];
        
                }
        
                if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"carSeriesJkhgc"] isEqualToString:@"2"]) {
        
                    [LLFCarGroupViewModel getMechanismModelArrWithcarSeriesJkhgc:@"2" SuccessBlock:^(NSMutableArray *carModelArr) {
        
                        [_allCarGroupView.collectionView.mj_header endRefreshing];
        
                        _allCarGroupView.mechanisCarModelArr = carModelArr;
        
                        self.view.userInteractionEnabled = YES;
        
                    } failedBlock:^(NSError *error) {
        
                        [_allCarGroupView.collectionView.mj_header endRefreshing];
        
                        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        
                        [self.phud showHUDResultAddedTo:self.view];
        
                        self.view.userInteractionEnabled = YES;
        
                    }];
        
                }
        
        
    

}
#pragma mark 退出登录
-(void)backAction{
    UserDataModel *userModel = [UserDataModel sharedUserDataModel];
    [userModel logOut];
    LLFLoginViewController *loginVC = [[LLFLoginViewController alloc]init];
    [self presentViewController:loginVC animated:YES completion:^{}];
}
//获取消息
- (void)loadMessageData
{
    NSArray *messageTypeNumArr = [MessageCenterViewModel queryMessageTypesNum];
    if (messageTypeNumArr.count > 3) {
        self.messageCount = messageTypeNumArr[3];
        if (_messageCount) {
            NSInteger messageNum = [_messageCount integerValue];
            if (messageNum > 0) {
                self.iconMessageNumBGImageView.hidden = NO;
                self.iconMessageNumLabel.hidden = NO;
                if (messageNum < 100) {
                    self.iconMessageNumLabel.text = self.messageCount;
                }else{
                    self.iconMessageNumLabel.text = @"99";
                }
            }else{
                self.iconMessageNumBGImageView.hidden = YES;
                self.iconMessageNumLabel.hidden = YES;
            }
        }
    }
}
#pragma mark LLFPersonCenterPopView 代理
- (void)logout
{
    [self backAction];
}
- (void)uploadMessage
{
    [self loadMessageData];
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}

- (UIImageView *)iconMessageNumBGImageView
{
    if (!_iconMessageNumBGImageView) {
        _iconMessageNumBGImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"LLF_Person_messageBG"]];
        _iconMessageNumBGImageView.frame = CGRectMake(67 * wScale, 7 * hScale, 48 * wScale, 32 * hScale);
        
        _iconMessageNumLabel = [[UILabel alloc]initWithFrame:_iconMessageNumBGImageView.bounds];
        _iconMessageNumLabel.font = [UIFont systemFontOfSize:12.0];
        _iconMessageNumLabel.textColor = [UIColor hex:@"#FFFFFFFF"];
        _iconMessageNumLabel.textAlignment = NSTextAlignmentCenter;
        [_iconMessageNumBGImageView addSubview:_iconMessageNumLabel];
    }
    return _iconMessageNumBGImageView;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.topView.brand.alpha = 0;
    } completion:^(BOOL finished) {
        
          [self.topView.brand removeFromSuperview];
    }];
  
}
@end
