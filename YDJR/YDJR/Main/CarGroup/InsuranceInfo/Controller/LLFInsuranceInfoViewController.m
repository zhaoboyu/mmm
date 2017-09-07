//
//  LLFInsuranceInfoViewController.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFInsuranceInfoViewController.h"
#import "LLFInsuranceInfoView.h"
#import "LLFInsuranceInfoViewModel.h"
#import "LLFInsuranceInfoPopView.h"
@interface LLFInsuranceInfoViewController ()<LLFInsuranceInfoViewDelegate>
@property (nonatomic,strong)LLFInsuranceInfoView *insuranceInfoView;
@property (nonatomic,strong)HGBPromgressHud *phud;
@end

@implementation LLFInsuranceInfoViewController
- (void)loadView{
    [super loadView];
    self.insuranceInfoView = [[LLFInsuranceInfoView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 128 * hScale - 64)];
    self.insuranceInfoView.delegate = self;
    self.view = self.insuranceInfoView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.insuranceInfoView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self queryInsuranceInfo];
    // Do any additional setup after loading the view.
}
- (void)loadNewData
{
    [LLFInsuranceInfoViewModel getInsuranceInfoModelArrWithSuccessBlock:^(NSMutableDictionary *insuranceInfoModelDic) {
        [self.insuranceInfoView.collectionView.mj_header endRefreshing];
        self.insuranceInfoView.insuranceInfoModelDic = insuranceInfoModelDic;
    } failedBlock:^(NSError *error) {
        [self.insuranceInfoView.collectionView.mj_header endRefreshing];
        //        self.insuranceInfoView.insuranceInfoModelDic = [NSMutableDictionary dictionary];
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.insuranceInfoView];
    }];
}
#pragma mark 获取保险信息列表
- (void)queryInsuranceInfo
{
    [self.phud showHUDSaveAddedTo:self.insuranceInfoView];
    [LLFInsuranceInfoViewModel getInsuranceInfoModelArrWithSuccessBlock:^(NSMutableDictionary *insuranceInfoModelDic) {
        [self.insuranceInfoView.collectionView.mj_header endRefreshing];
        [self.phud hideSave];
        self.insuranceInfoView.insuranceInfoModelDic = insuranceInfoModelDic;
    } failedBlock:^(NSError *error) {
        [self.insuranceInfoView.collectionView.mj_header endRefreshing];
        [self.phud hideSave];
//        self.insuranceInfoView.insuranceInfoModelDic = [NSMutableDictionary dictionary];
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.insuranceInfoView];
    }];
}
#pragma mark LLFInsuranceInfoViewDelegate
- (void)insuranceInfoButtonstate:(NSString *)state modelArr:(NSMutableArray *)modelArr insuranceNum:(NSString *)insuranceNum
{
    if ([state isEqualToString:@"花费对比"]) {
        LLFInsuranceInfoPopView *insuranceInfoPopView = [[LLFInsuranceInfoPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        [insuranceInfoPopView showView];
        
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(insuranceInfoModelstate:modelArr:insuranceNum:)]) {
            [_delegate insuranceInfoModelstate:state modelArr:modelArr insuranceNum:insuranceNum];
        }
    }
}
- (void)sendSumInsuranceMoney:(NSString *)sumMoney
{
    //花费对比
    LLFInsuranceInfoPopView *insuranceInfoPopView = [[LLFInsuranceInfoPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    insuranceInfoPopView.sumInsurance = sumMoney;
    [insuranceInfoPopView showView];

}
- (void)sendIsByDaFenQi:(BOOL)isBy
{
    if (_delegate && [_delegate respondsToSelector:@selector(sendIsByDaFenQi:)]) {
        [_delegate sendIsByDaFenQi:isBy];
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
