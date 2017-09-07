//
//  LLFCarGroupViewController.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarGroupViewController.h"
#import "LLFCarGroupView.h"
#import "LLFSeriesListView.h"
#import "LLFCarModelListView.h"
#import "LLFCarModelDetailView.h"
#import "LLFCarGroupViewModel.h"
#import "LSCarDetailsViewController.h"
#import "WPQCarGroupTopViw.h"
@interface LLFCarGroupViewController ()<LLFSeriesListViewDelegate,LLFCarGroupViewDelegate,LLFCarModelListViewDelegate,LLFCarModelDetailViewDelegate>
//@property (nonatomic,strong)LLFCarGroupView *carGroupView;
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

@end

typedef enum{
    allButtonTag,
    homebredButtonTag,
    importButtonTag,
    scrollViewDidScrollTag
}buttonFlag;

@implementation LLFCarGroupViewController

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
}


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    [super viewWillAppear:animated];
    [self creatNativeView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self stepUI];
    [self queryMechanismCarModelList];
    [self creatUI];
    
    
}

-(void)BottomButton{
    NSArray* titleArray=[NSArray arrayWithObjects:@"汽车馆",@"客户管理",@"知识库",@"我的 ",nil];
    NSArray* normolImageArray=[NSArray arrayWithObjects:
                               @"icon_normal_qicheguan",
                               @"icon_normal_kehuguanli",
                               @"icon_normal_zhishiku",
                               @"icon_normal_wode",nil];
    NSArray* selectImageArray=[NSArray arrayWithObjects:
                               @"icon_pressed_qicheguan",
                               @"icon_pressed_kehuguanli"
                               ,@"icon_pressed_zhishiku",
                               @"icon_pressed_wode",nil];
    for (int i=0; i<4; i++) {
        WPQButtonBox* box=[[WPQButtonBox alloc] initWithFrame:CGRectMake(432*wScale+(56+320)*wScale*i, kHeight-(106)*hScale, 92*hScale, 96*hScale)];
        box.titleLable.text=titleArray[i];
        box.tag=1000+i;
        box.button.tag=1000+i;
//        [box.button setImage:[UIImage imageNamed:normolImageArray[i]] forState:UIControlStateNormal];
//        [box.button setImage:[UIImage imageNamed:selectImageArray[i]] forState:UIControlStateSelected];
        [box.button addTarget:self action:@selector(WPQButtonBoxAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [box.imageView setImage:[UIImage imageNamed:normolImageArray[i]]];
        [box.imageView setHighlightedImage:[UIImage imageNamed:selectImageArray[i]]];
        
        [self.view addSubview:box];
        if (i==0) {
            box.imageView.highlighted=YES;
            box.titleLable.highlighted=YES;
        }
    }
}


-(void)stepUI{
    [self BottomButton];
    
    self.topView=[[WPQCarGroupTopViw alloc] initWithFrame:CGRectMake(0, 40*hScale, kWidth, 88*hScale)];
    [self.view addSubview:self.topView];
    
    _myScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), kWidth, kHeight-(96+20)*hScale-CGRectGetMaxY(self.topView.frame))];
    _myScrollView.contentSize=CGSizeMake(kWidth*3,_myScrollView.frame.size.height);
    _myScrollView.pagingEnabled=YES;
    _myScrollView.delegate=self;
    [self.view addSubview:_myScrollView];
    
    
    CGRect bounds=_myScrollView.bounds;
    CGRect _allFrame=CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    _allCarGroupView = [[LLFCarGroupView alloc]initWithFrame:_allFrame];
    _allCarGroupView.delegate = self;
    _allCarGroupView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewMechanismCarModelList)];
    [_myScrollView addSubview:_allCarGroupView];
    
    CGRect _homebredFrame=CGRectMake(bounds.size.width, 0, bounds.size.width, bounds.size.height);
    _homebredCarGroupView=[[LLFCarGroupView alloc] initWithFrame:_homebredFrame];
    _homebredCarGroupView.delegate = self;
    _homebredCarGroupView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewMechanismCarModelList)];
    [_myScrollView addSubview:_homebredCarGroupView];
    
    CGRect _importFrame=CGRectMake(bounds.size.width*2, 0, bounds.size.width, bounds.size.height);
    _importCarGroupView=[[LLFCarGroupView alloc] initWithFrame:_importFrame];
    _importCarGroupView.delegate = self;
    _importCarGroupView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewMechanismCarModelList)];
    [_myScrollView addSubview:_importCarGroupView];
    
    _selectCarGroupView=_allCarGroupView;
    
}


- (void)creatNativeView
{
    [self.tabBarController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_Nav"] forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.navigationItem.rightBarButtonItem =nil;
    [self.tabBarController.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self.tabBarController.navigationItem.leftBarButtonItem setTintColor:[UIColor hexString:@"#FFFFFFFF"]];
    NSString *ppName = [[UserDataModel sharedUserDataModel] ppName];
    ppName = [NSString stringWithFormat:@"%@ 汽车馆",ppName];
    self.tabBarController.navigationItem.title = ppName;
    NSMutableDictionary *titleAttributesDic = [NSMutableDictionary dictionary];
    [titleAttributesDic setObject:[UIColor hexString:@"#FFFFFFFF"] forKey:NSForegroundColorAttributeName];
    [titleAttributesDic setObject:[UIFont systemFontOfSize:18.0] forKey:NSFontAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributesDic];
    
}
- (void)creatUI
{
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

#pragma mark WPQButtonBoxAction
-(void)WPQButtonBoxAction:(UIButton*)bt{
    if (bt.selected == NO) {
        for (WPQButtonBox* box  in self.view.subviews) {
            if ([box isKindOfClass:[WPQButtonBox class]]) {
                if (box.tag == bt.tag) {
                    //                    box.button.selected=YES;
                    //                    box.titleLable.highlighted=YES;
                    switch (bt.tag) {
                        case 1000:{
                            //不做任何操作
                        }
                            
                            break;
                        case 1001:{
                            //客户管理模块
                            //                            NSLog(@"客户管理模块");
                            SDCCustomerManagerController *customerMangerVC = [[SDCCustomerManagerController alloc]init];
                            //                            [self.navigationController pushViewController:customerMangerVC animated:YES];
                            [self presentViewController:customerMangerVC animated:YES completion:nil];
                        }
                            
                            break;
                        case 1002:{
                            //知识库模块
//                            LLFKnowledgeBaseViewController *knowledgeBaseVC = [[LLFKnowledgeBaseViewController alloc]init];
//                            //                            [self.navigationController pushViewController:knowledgeBaseVC animated:YES];
//                            [self presentViewController:knowledgeBaseVC animated:YES completion:nil];
                        }
                            
                            break;
                            
                        case 1003:{
                            //我的
                           
                        }
                            
                            break;
                        default:
                            break;
                    }
                    
                }
                else{
//                    box.button.selected=NO;
//                    box.titleLable.highlighted=NO;
                }
            }
        }
    }
}


#pragma mark button-lineView-ScrollView-Animation
-(void)lineViewMove:(CGFloat)offX moveY:(CGFloat)offY buttonActionTag:(NSInteger)Tag{
    
    if (Tag == scrollViewDidScrollTag) {
        //scrollView偏移
        CGFloat offScale=offX/(_myScrollView.contentSize.width/3*2);
        if (offScale == 0 ||offScale == 0.5 ||offScale == 1.0) {
            [self.topView moveToScrollviewBorderScale:offScale];
        }
        if (offScale == 0) {
            _selectCarGroupView=_allCarGroupView;
        }
        else if (offScale == 0.5){
            _selectCarGroupView=_homebredCarGroupView;
        }
        else if (offScale == 1.0){
            _selectCarGroupView=_importCarGroupView;
        }
    }
    else {
        _myScrollView.contentOffset=CGPointMake(_myScrollView.contentSize.width/3*Tag, _myScrollView.contentOffset.y);
    }
    
    if (_selectCarGroupView.fristLoadData == NO) {
        [self loadNewMechanismCarModelList];
    }
    
}
#pragma mark scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    NSLog(@"%f",scrollView.contentOffset.x);
    [self lineViewMove:scrollView.contentOffset.x moveY:scrollView.contentOffset.y buttonActionTag:scrollViewDidScrollTag];
    
}

#pragma mark loadNewMechanismCarModelList回
- (void)loadNewMechanismCarModelList
{
    self.view.userInteractionEnabled = NO;
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
    [LLFCarGroupViewModel getMechanismModelArrWithSuccessBlock:^(NSMutableArray *carModelArr) {
          self.view.userInteractionEnabled = YES;
        [_selectCarGroupView.collectionView.mj_header endRefreshing];
        _selectCarGroupView.mechanisCarModelArr = carModelArr;
        _selectCarGroupView.fristLoadData=YES;
        
    } failedBlock:^(NSError *error) {
          self.view.userInteractionEnabled = YES;
        [_selectCarGroupView.collectionView.mj_header endRefreshing];
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.view];
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
        [UIView animateWithDuration:0.2 animations:^{
            self.carModelListView.frame = CGRectMake(0, 0, kWidth,kHeight);
        } completion:^(BOOL finished) {
            [self querySeriesCarModelList];
        }];
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

-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
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
