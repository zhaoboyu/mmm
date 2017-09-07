//
//  LLFSelectNewCarTypeViewController.m
//  YDJR
//
//  Created by 吕利峰 on 2016/12/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFSelectNewCarTypeViewController.h"
#import "LLFSelectNewCarTypeView.h"
#import "LLFMechanismCarModel.h"
#import "LLFSelectNewCarTypeViewModel.h"
#import "LSCarDetailsViewController.h"
#import "LLFCarModel.h"

@interface LLFSelectNewCarTypeViewController ()<LLFSelectNewCarTypeViewDelegate>
@property (nonatomic,strong)LLFSelectNewCarTypeView *selectCarTypeView;
@property (nonatomic,strong)LLFCarModel *carDetailModel;
@property (nonatomic,strong)HGBPromgressHud *phud;
@end

@implementation LLFSelectNewCarTypeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self creatNativeView];
}
- (void)loadView
{
    [super loadView];
    self.selectCarTypeView = [[LLFSelectNewCarTypeView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.selectCarTypeView.delegate = self;
    self.selectCarTypeView.mechanismCarModel = self.mechanismCarModel;
    self.view = self.selectCarTypeView;
}
- (void)creatNativeView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"LLF_TouMing_Navbar"] forBarMetrics:UIBarMetricsDefault];
//    self.tabBarController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"LLF_icon_normal_back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonItemAction:)];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor hexString:@"#FFFFFFFF"]];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"LLF_TouMing_Navbar"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"LLF_TouMing_Navbar"];
    
}
//返回
- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     简单点说就是automaticallyAdjustsScrollViewInsets根据按所在界面的status bar，navigationbar，与tabbar的高度，自动调整scrollview的 inset,设置为no，不让viewController调整。
     
     注：自己代码的问题在于自定义了一个navigationbar,因而系统自己判定并适配，设置 self.automaticallyAdjustsScrollViewInsets = NO 才达到了效果。
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self creatNativeView];
    
    [self queryCarBuyList];
    [self creatUI];
    
    //加载本地缓存数据
    NSString *carModelDetailPath = [NSString stringWithFormat:@"%@carModelDetailPath%@%@",[Tool getMechinsId],self.mechanismCarModel.carSeriesCode,[[NSUserDefaults standardUserDefaults] objectForKey:@"carSeriesJkhgc"]];
    NSArray *localArr = [Tool unarcheiverWithfileName:carModelDetailPath];
    if (localArr.count > 0) {
        NSMutableDictionary *carModelDic = localArr[0];
        self.selectCarTypeView.carBuyTypeDic = carModelDic;
        NSArray *keyArr = [Tool sortWithArr:[carModelDic allKeys] sort:@"0"];
        NSArray *valueArr = [carModelDic objectForKey:keyArr[0]];
        self.carDetailModel = valueArr[0];
    }
}
- (void)creatUI{
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(24 * wScale, 33, 36 * wScale, 36 * wScale)];
    iconImageView.image = [UIImage imageNamed:@"LLF_SelectNewCarType_icon_normal_back"];
    [self.selectCarTypeView addSubview:iconImageView];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame), 34.5, 84 * wScale, 30 * hScale)];
    backLabel.text = @"返回";
    backLabel.textColor = [UIColor hex:@"#FFFFFFFF"];
    backLabel.textAlignment = NSTextAlignmentCenter;
    backLabel.font = [UIFont systemFontOfSize:15.0];
    [self.selectCarTypeView addSubview:backLabel];
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [backButton addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    backButton.backgroundColor = [UIColor redColor];
    backButton.frame = CGRectMake(0, 20, 132 * wScale, 88 * hScale);
    [self.selectCarTypeView addSubview:backButton];
//    [self.selectCarTypeView addSubview:backButton];
    
    [self.selectCarTypeView.customizedFinancialPlanButton addTarget:self action:@selector(customizedFinancialPlanButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)setMechanismCarModel:(LLFMechanismCarModel *)mechanismCarModel
{
    _mechanismCarModel = mechanismCarModel;
}
/**
 获取销售名称数据列表
 */
- (void)queryCarBuyList
{
    [self.phud showHUDSaveAddedTo:self.selectCarTypeView];
    [LLFSelectNewCarTypeViewModel getCarModelArrWithCarSeriesModel:self.mechanismCarModel SuccessBlock:^(NSMutableDictionary *carModelDic) {
        [self.phud hideSave];
        self.selectCarTypeView.carBuyTypeDic = carModelDic;
        NSArray *keyArr = [Tool sortWithArr:[carModelDic allKeys] sort:@"0"];
        NSArray *valueArr = [carModelDic objectForKey:keyArr[0]];
        self.carDetailModel = valueArr[0];
        
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.selectCarTypeView];
    }];
}
/**
 定制金融方案按钮响应事件
 
 @param sender 定制金融方案按钮
 */
- (void)customizedFinancialPlanButtonAction:(UIButton *)sender
{
    LSCarDetailsViewController *carDetailsVC = [[LSCarDetailsViewController alloc]init];
    carDetailsVC.carModel = self.carDetailModel;
    [self.navigationController pushViewController:carDetailsVC animated:YES];
}
#pragma mark LLFSelectNewCarTypeViewDelegate
- (void)clickCarBuyListWith:(LLFCarModel *)carModel
{
    self.carDetailModel = carModel;
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
