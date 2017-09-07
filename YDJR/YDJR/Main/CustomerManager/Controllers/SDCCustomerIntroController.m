//
//  SDCCustomerIntroController.m
//  YDJR
//
//  Created by sundacheng on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//


#import "SDCCMHeader.h"
#import "AppDelegate.h"

#import "SDCCustomerIntroController.h"
#import "MainViewController.h"
#import "SDCOverApplicationController.h"

//功能
#import "CustomerManagerViewModel.h"

//view
#import "SDCCustomerInfoView.h"
#import "SDCBoxViewManager.h"
#import "SDCBoxView.h"
#import "SDCCustomerOrderIntstCell.h"
#import "FinalApprovalView.h"
#import "DafenqiApplyInfoView.h"
//model
#import "SDCCustomerIntrestModel.h"
#import "SDCCustomerContactModel.h"
#import "LLFDafenqiBusinessModel.h"
#import "MessageCenterViewModel.h"
#import "MessageModel.h"
#import "SDCCustomerIntroViewModel.h"
//api
#import "CTTXRequestServer+CustomerManager.h"
#import "CTTXRequestServer+LetterofIntent.h"
#import "CTTXRequestServer+statusCodeCheck.h"


//size
#define VCHeight kHeight - YDMarginTopHeight - TopOffSzie
#define VCWeight kWidth - 578/2
#define LeftSpace 12.5

//tag
#define CustomInfoTag 123
#define Shenqingshu1Tag 124
#define Shenqingshu2Tag 125

static NSString *customerOrderIntstCaridentis = @"SDCCustomerOrderIntstCell";
typedef enum
{
    PRODUCT_Finance,//自营产品
    PRODUCT_Dafenqi,//达分期产品
}PRODUCT_TYPE;
/*
 客户名
 box信息
 */
@interface SDCCustomerIntroController()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate>
/**
 *  客户id
 */
@property (nonatomic, copy) NSString *customerId;

/**
 * 代理产品时修改意向单状态
 */
@property (nonatomic,strong)UIButton *updataStateButton;

//客户视图
@property (nonatomic, strong) UIScrollView *customerView;

//客户列表视图
@property (nonatomic, strong) UITableView *customerListView;

//客户名
@property (nonatomic, strong) UILabel *customNameLabel;

//车型信息
@property (nonatomic, strong) SDCBoxViewManager *carBoxManger;

//详情标题
@property (nonatomic, strong) UILabel *detailTitleLabel;

//客户标签视图
@property (nonatomic, strong) UIView *customLabelView;

//小导航
@property (nonatomic, strong) UIView *smallNavView;

//数据源
@property (nonatomic, copy) NSArray *dataArray;

//身份类型
@property (nonatomic, copy) NSMutableDictionary *idsType;

//融资范围
@property (nonatomic, copy) NSDictionary *financeRange;

//没有数据的View
@property (nonatomic, strong) UIView *noDataView;

//保险视图
@property (nonatomic, strong) UIView *insuView;

//客户意向model
@property (nonatomic, strong) SDCCustomerIntrestModel *customerIntrestModel;
@property (nonatomic,strong)LLFDafenqiBusinessModel *dafenqiBusinessModel;
@property (nonatomic,strong)HGBPromgressHud *phud;

@property (nonatomic,assign)PRODUCT_TYPE productType;

@end

@implementation SDCCustomerIntroController

#pragma mark - life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知,接受新消息通知更新界面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadNewMessage) name:@"loadMessage" object:@"loadMessage"];
    //背景色
    //    UIView *topBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 200)];
    //    topBgView.backgroundColor = [UIColor hex:@"#F2F3F7"];
    //    [self.view addSubview:topBgView];
    
    //数据请求
    //    [self.customerListView didSelectRowAtIndexPath]
    //    NSIndexPath *path = [NSIndexPath indexPathWithIndex:2];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //    NSLog(@"index:%ld  currentSelectIndex:%ld",self.index,self.currentSelectIndex);
    
    if (self.customerId) {
        //刷新数据
        self.customerId = self.customerId;
    }
}
//收到消息后更新界面
- (void)loadNewMessage
{
    if (self.customerId) {
        //刷新数据
        self.customerId = self.customerId;
    }
}
#pragma mark - 获取数据
- (void)setCustomerContactModel:(SDCCustomerContactModel *)customerContactModel
{
    _customerContactModel = customerContactModel;
    self.customerId = customerContactModel.customerID;
}
- (void)setCustomerId:(NSString *)customerId
{
    _customerId = customerId;
    [self.phud showHUDSaveAddedTo:self.view];
    
    __weak typeof(self) weakSelf = self;
    [[CTTXRequestServer shareInstance] customerIntentOrderWithCustomerID:_customerId SuccessBlock:^(NSMutableArray *customerArray) {
        [self.phud hideSave];
        
        [weakSelf.customerListView.mj_header endRefreshing];
        if (customerArray.count == 0) {
            [weakSelf.view addSubview:weakSelf.noDataView];
            return;
        } else {
            [weakSelf.noDataView removeFromSuperview];
        }
        
        weakSelf.dataArray = customerArray;
        
        /*如果是1个显示详情，如果是多个显示列表*/
//        if (customerArray.count == 1) {
//            _isOne = YES;
//            //添加customerView视图
//            [weakSelf addCustomerView];
//        } else {
            //添加customerListView视图
            [weakSelf addCustomerListView];
            //刷新数据
            [weakSelf.customerListView reloadData];
            if (self.customerContactModel.indexForRow != -1) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.customerContactModel.indexForRow inSection:0];
                [self tableView:self.customerListView didSelectRowAtIndexPath:indexPath];
            }
//        }
        
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.view];
        
        [weakSelf.customerListView.mj_header endRefreshing];
    }];
}


#pragma mark - 客户信息视图刷新数据
//客户信息视图刷新数据
- (void)setCustomerInfoWithCustomerIntrestModel:(SDCCustomerIntrestModel *)model {
    self.customerIntrestModel = model;
    
    _detailTitleLabel.text = model.productName;
    
    //融资范围
    NSString *financeRangeStr = [self changeFinanceRangeTypeWithType:model.includeAmountType];
    
    //更新查看申请书的点击状态
    if ([model.state isEqualToString:@"0"]) {
        UIButton *btn = [self.view viewWithTag:Shenqingshu1Tag];
        btn.enabled = NO;
    }else{
        UIButton *btn = [self.view viewWithTag:Shenqingshu1Tag];
        btn.enabled = YES;
    }
    NSString *productState = [NSString stringWithFormat:@"%@",model.productState];
    //代理产品提交后可以更改意向单状态07
    /*
     07:审批通过
     08:审批失败
     09:首付成功
     10:放款成功
     */
    if ([productState isEqualToString:@"2"] && ![model.state isEqualToString:@"0"]) {
        self.updataStateButton.hidden = NO;
    }else{
        self.updataStateButton.hidden = YES;
    }
    //是否可点击
    NSString *isClick;
    if ([model isClickButtonState]) {
        isClick = @"1";
    }else{
        isClick = @"0";
    }
    NSArray *arr1 = @[
                      @{
                          @"title":@"申请信息",
                          @"info":@"开始申请",
                          @"state":model.processState,
                          @"isClick":isClick,
                          @"isShow":@"0",
                          },
                      @{
                          @"title":@"产品名称",
                          @"info":model.productName,
                          },
                      @{
                          @"title":@"车辆品牌",
                          @"info":model.carPpName
                          },
                      @{
                          @"title":@"车辆型号",
                          @"info":model.catModelDetailName
                          },
                      @{
                          @"title":@"车辆指导价",
                          @"info":[model.carPrice cut]
                          },
                      @{
                          @"title":@"开票价",
                          @"info":[model.contractAmount cut]
                          },
                      @{
                          @"title":@"融资范围",
                          @"info": financeRangeStr
                          },
                      @{
                          @"title":@"融资金额",
                          @"info":[model.carrzgm cut]
                          },
                      @{
                          @"title":@"融资期限（月）",
                          @"info":model.instCounts
                          },
                      ];
    
    self.carBoxManger.infoArray = arr1;
    
}
//客户信息视图刷新数据-达分期产品
- (void)setCustomerInfoWithLLFDafenqiBusinessModel:(LLFDafenqiBusinessModel *)model {
    //    NSAttributedString *attStr = [self setText:str index:4 firstColor:@"#21456E" secondColor:@"#FF999999"];
    //    [self.replenLabel setAttributedText:attStr];
    self.dafenqiBusinessModel = model;
    //产品名称
    _detailTitleLabel.text = @"达分期产品";
    
    
    //更新查看申请书的点击状态
    if ([model isCanApplyBook]) {
        UIButton *btn = [self.view viewWithTag:Shenqingshu1Tag];
        btn.enabled = YES;
    }else{
        UIButton *btn = [self.view viewWithTag:Shenqingshu1Tag];
        
        btn.enabled = NO;
        
    }
    self.updataStateButton.hidden = YES;
    //是否可点击
    NSString *isClick;
    if ([model isClickButtonState]) {
        isClick = @"1";
    }else{
        isClick = @"0";
    }
    //是否显示补款状态
    NSString *isShow;
    if ([model isReplenishment]) {
        isShow = @"1";
    }else{
        isShow = @"0";
    }
    NSArray *arr1 = @[
                      @{
                          @"title":@"申请信息",
                          @"info":@"开始申请",
                          @"state":model.state,
                          @"isClick":isClick,
                          @"isShow":isShow,
                          @"replenState":model.changeReplenState,
                          },
                      @{
                          @"title":@"按揭机构",
                          @"info":model.creditInfo.mortgagedOrg,
                          },
                      @{
                          @"title":@"保险按揭期限(月)",
                          @"info":model.creditInfo.mortgagedTerm,
                          },
                      @{
                          @"title":@"车辆品牌",
                          @"info":model.carInfo.carBrand
                          },
                      @{
                          @"title":@"车辆型号",
                          @"info":model.carInfo.carModel
                          },
                      @{
                          @"title":@"被保险人",
                          @"info":model.insuranceInfo.insureObject
                          },
                      @{
                          @"title":@"保险公司名称",
                          @"info": model.insuranceInfo.insuranceOrg
                          },
                      @{
                          @"title":@"保险期限(年)",
                          @"info":model.insuranceInfo.uptoTerm
                          },
                      @{
                          @"title":@"预估保费",
                          @"info":model.insuranceInfo.preInsuranceSum
                          },
                      ];
    
    self.carBoxManger.infoArray = arr1;
    
}
- (NSString *)changeFinanceRangeTypeWithType:(NSString *)Type
{
    NSArray *financeRangeTypeArr = [Type componentsSeparatedByString:@","];
    NSString *financeRangeStr = @"";
    for (NSString *str in financeRangeTypeArr) {
        NSString *tempStr = self.financeRange[str];
        if (![financeRangeStr isEqualToString:@""]) {
            financeRangeStr = [financeRangeStr stringByAppendingFormat:@"-%@",tempStr];
        }else{
            financeRangeStr = tempStr;
        }
        
    }
    if (financeRangeStr && financeRangeStr.length > 0) {
        
    }else{
        financeRangeStr = @" ";
    }
    return financeRangeStr;
}
#pragma mark - 添加视图
//添加customerView视图
- (void)addCustomerView {
    //添加customerView视图
    //删除意向单列表界面
    if ([self.customerListView superview]) {
        [self.customerListView removeFromSuperview];
        self.customerListView = nil;
    }
    if ([self.smallNavView superview]) {
        [self.smallNavView removeFromSuperview];
        self.smallNavView = nil;
    }
    //添加客户信息栏
    if (![self.customLabelView superview]) {
        [self.view addSubview:self.customLabelView];
    }
    //添加意向单详情页面
    if (![self.customerView superview]) {
        [self.view addSubview:self.customerView];
    }
    //刷新数据
    if ([self.dataArray[0] isKindOfClass:[SDCCustomerIntrestModel class]]) {
        self.productType = PRODUCT_Finance;
        [self setCustomerInfoWithCustomerIntrestModel:self.dataArray[0]];
    }else{
        self.productType = PRODUCT_Dafenqi;
        [self setCustomerInfoWithLLFDafenqiBusinessModel:self.dataArray[0]];
    }
    
}

//添加customerListView视图
- (void)addCustomerListView {
    
    //删除意向单详情界面
    if ([self.customerView superview]) {
        [self.customerView removeFromSuperview];
        self.customerView = nil;
    }
    if ([self.smallNavView superview]) {
        [self.smallNavView removeFromSuperview];
        self.smallNavView = nil;
    }
    //添加客户信息栏
    if (![self.customLabelView superview]) {
        [self.view addSubview:self.customLabelView];
    }
    if (![self.customerListView superview]) {
        [self.view addSubview:self.customerListView];
    }
}

#pragma mark - UI

- (UIView *)titleMsgView:(NSString *)msgInfo {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VCWeight, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 12)];
    [view addSubview:titleLb];
    titleLb.centerY = 44/2;
    titleLb.left = 16;
    titleLb.text = msgInfo;
    titleLb.textColor = [UIColor hex:@"#21456E"];
    titleLb.font = [UIFont systemFontOfSize:13];
    if ([msgInfo isEqualToString:@"车辆及融资信息"]) {
        self.updataStateButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.updataStateButton.frame = CGRectMake(VCWeight - 200 * wScale, 0, 200 * wScale, 44);
        [self.updataStateButton setTitle:@"状态变更" forState:(UIControlStateNormal)];
        [self.updataStateButton setTitleColor:[UIColor redColor]];
        [self.updataStateButton addTarget:self action:@selector(updataStateButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        //    self.updataStateButton.hidden = NO;
        [view addSubview:self.updataStateButton];
        
    }
    
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, msgInfo.length*13.5, 1)];
    [view addSubview:line];
    line.backgroundColor = [UIColor hex:@"#21456E"];
    line.left = 14;
    line.bottom = 44;
    return view;
}

- (UIView *)accessView:(NSString *)msg tag:(NSInteger)tag{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VCWeight, 44)];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(VCWeight - 110, 0, 100, 44)];
    [view addSubview:button];
    
    button.centerY = 44/2;
    button.tag = tag;
    
    [button setTitle:msg forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor hex:@"#FC5A5A"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [button setImage:[UIImage imageNamed:@"red"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"lightgray"] forState:UIControlStateDisabled];
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.bounds.size.width - 5,0, -5)];
    
    [button addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44 + 12;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VCWeight, 10)];
    view.backgroundColor = [UIColor hex:@"#F2F3F7"];
    
    UIView *titleView = [self titleMsgView:@"融资申请"];
    [view addSubview:titleView];
    titleView.top = 12;
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.customerContactModel.indexForRow = indexPath.row;
    
    [self.view addSubview:self.customerView];
    [self.view addSubview:self.smallNavView];
    if ([self.dataArray[indexPath.row] isKindOfClass:[SDCCustomerIntrestModel class]]) {
        self.productType = PRODUCT_Finance;
        //刷新数据
        [self setCustomerInfoWithCustomerIntrestModel:self.dataArray[indexPath.row]];
        
    }else{
        self.productType = PRODUCT_Dafenqi;
        [self setCustomerInfoWithLLFDafenqiBusinessModel:self.dataArray[indexPath.row]];
        
    }
    
}

#pragma mark - tableviewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDCCustomerOrderIntstCell *cell = [tableView dequeueReusableCellWithIdentifier:customerOrderIntstCaridentis];
    if (!cell) {
        cell = [[SDCCustomerOrderIntstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customerOrderIntstCaridentis tableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    SDCCustomerIntrestModel *model = self.dataArray[indexPath.row];
    [cell reloadDataWithModel:self.dataArray[indexPath.row]];
    
    return cell;
}

#pragma mark - Action
- (void)pushAction:(UIButton *)btn {
    switch (btn.tag) {
        case CustomInfoTag:
        {
            SDCCustomerInfoView *customerInfoView = [[SDCCustomerInfoView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
            
            customerInfoView.customerContactModel = self.customerContactModel;
            
            NSLog(@"idsType %@",self.customerContactModel.idsType);
            
            NSDictionary*dic=self.idsType;
            NSLog(@"%@",dic);
            NSString *idType = self.idsType[self.customerContactModel.idsType];
            if (!idType) {
                idType = @"";
            }
            NSString *customerType;
            NSArray *array;
            if ([Tool isCustomerPersonTypeWithCustomerType:self.customerContactModel.customerType]) {
                customerType = @"企业客户";
                array = @[
                          @{
                              @"title":@"企业联系人",
                              @"content":self.customerContactModel.customerLxr
                              },
                          @{
                              @"title":@"性别",
                              @"content":self.customerContactModel.customerSex
                              },
                          @{
                              @"title":@"证件类型",
                              @"content":idType
                              },
                          @{
                              @"title":@"证件号",
                              @"content":self.customerContactModel.idsNumber
                              },
                          @{
                              @"title":@"联系电话",
                              @"content":self.customerContactModel.customerPhone
                              },
                          @{
                              @"title":@"客户类型",
                              @"content":customerType
                              },
                          //                          @{
                          //                              @"title":@"客户地址",
                          //                              @"content":self.customerContactModel.address
                          //                              },
                          @{
                              @"title":@"单位名称",
                              @"content":self.customerContactModel.customerName
                              }
                          ];
                
            } else {
                customerType = @"个人客户";
                array = @[
                          @{
                              @"title":@"客户名称",
                              @"content":self.customerContactModel.customerName
                              },
                          @{
                              @"title":@"性别",
                              @"content":self.customerContactModel.customerSex
                              },
                          @{
                              @"title":@"证件类型",
                              @"content":idType
                              },
                          @{
                              @"title":@"证件号",
                              @"content":self.customerContactModel.idsNumber
                              },
                          @{
                              @"title":@"联系电话",
                              @"content":self.customerContactModel.customerPhone
                              },
                          @{
                              @"title":@"客户类型",
                              @"content":customerType
                              },
                          //                          @{
                          //                              @"title":@"客户地址",
                          //                              @"content":self.customerContactModel.address
                          //                              }
                          ];
                
            }
            
            
            [customerInfoView reloadDataWithCustomerArray:array outsideflag:1];
            
            [self.parentViewController.view addSubview:customerInfoView];
            
        }
            break;
        case Shenqingshu1Tag:
        {
            if (self.productType == PRODUCT_Finance) {
                //自营及代理产品的查看申请书
                //是否自营
                NSNumber *isSelfRun = self.customerIntrestModel.productState;
                if (!isSelfRun) {
                    isSelfRun = @(-1);
                }
                NSString *productState = [NSString stringWithFormat:@"%@",isSelfRun];
                //是否是金融经理
                UserDataModel *userDataModel = [UserDataModel sharedUserDataModel];
                NSNumber *isFinanceManager = [NSNumber numberWithBool:userDataModel.isFinancialManagers];
                //转借状态 0非转接  1转借
                NSNumber *zhuanjieState;
                if ([self.customerIntrestModel.state isEqualToString:@"06"]) {
                    zhuanjieState = @(1);
                } else {
                    zhuanjieState = @(0);
                }
                //0、车辆品牌、1、达分期产品id、2、客户id、3、开票价、4、达芬奇产品名称、5、角色权限(1:金融经理,0:销售经理)、6、是否自营(是否自营 1自营 2代理 3达分期)、7、转借状态(0非转接  1转借)、8、意向单id、9、客户类型(01:企业,02:个人) 10.车辆销售名称，11.车辆指导价,12.购置税,13.保险费
                NSMutableArray *paramArray = [NSMutableArray arrayWithObjects:self.customerIntrestModel.carPpName,self.customerIntrestModel.productID,self.customerIntrestModel.customerID,self.customerIntrestModel.contractAmount,self.customerIntrestModel.productName,isFinanceManager,productState,zhuanjieState,self.customerIntrestModel.intentID,self.customerContactModel.customerType,self.customerIntrestModel.catModelDetailName,self.customerIntrestModel.carPrice,self.customerIntrestModel.purchasetax,self.customerIntrestModel.insurance,nil];
                
                //存储本地
                [Tool saveIntentValueWithValueArr:paramArray];
                
                //存储当前客户信息
                NSDictionary *customerInfo = [self.customerContactModel yy_modelToJSONObject];
                
                [[NSUserDefaults standardUserDefaults] setObject:customerInfo forKey:@"customerInfo"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                //查看申请书
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:self.customerIntrestModel.intentID forKey:@"intentID"];
                [dic setObject:self.customerIntrestModel.productID forKey:@"productID"];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:dic forKey:@"lookApply"];
                [defaults synchronize];
                MainViewController *oavc = [[MainViewController alloc] init];
                
                oavc.startPage = [Tool getWWWPackAddressWithIndexName:@"application_informationT.html"];
                oavc.isApplyTop = YES;
                oavc.isHaveTop = NO;
                oavc.intentID = self.customerIntrestModel.intentID;
                oavc.productID = self.customerIntrestModel.productID;
                oavc.productstate = [NSString stringWithFormat:@"%@",self.customerIntrestModel.productState];
                YDJRNavigationViewController *oaNC = [[YDJRNavigationViewController alloc]initWithRootViewController:oavc];
                [self presentViewController:oaNC animated:YES completion:nil];
            }else if (self.productType == PRODUCT_Dafenqi){
                __weak typeof(self) weakSelf = self;
                //达分期产品的查看申请书
                CGRect rect = weakSelf.view.bounds;
                rect.origin.x = rect.size.width;
                DafenqiApplyInfoView *dafenqiApplyInfoView = [[DafenqiApplyInfoView alloc]initWithFrame:rect];
                dafenqiApplyInfoView.dafenqiBusinessModel = self.dafenqiBusinessModel;
                dafenqiApplyInfoView.back = ^(){
                    if (weakSelf.customerId) {
                        //刷新数据
                        weakSelf.customerId = weakSelf.customerId;
                    }
                };
                [weakSelf.view addSubview:dafenqiApplyInfoView];
                [UIView animateWithDuration:0.2 animations:^{
                    CGRect frame = dafenqiApplyInfoView.frame;
                    frame.origin.x = 0;
                    dafenqiApplyInfoView.frame = frame;
                } completion:^(BOOL finished) {
                    
                }];
                
            }
            
        }
            
            break;
        default:
            break;
    }
    
}

//内嵌导航返回按钮
- (void)smallBackAction {
    [self.customerView removeFromSuperview];
    [self.smallNavView removeFromSuperview];
}

#pragma mark - createCustomerView
- (void)createCustomerView {
    //车辆及融资信息
    UIView *carShapTitleView = [self titleMsgView:@"车辆及融资信息"];
    [_customerView addSubview:carShapTitleView];
    carShapTitleView.top = 12;
    
    self.carBoxManger = [[SDCBoxViewManager alloc] init];
    UIView *carMsgBoxView = [self.carBoxManger creatBoxeslineMaxNum:3 totalNum:9 andSViewWidth:VCWeight];
    carMsgBoxView.left = 0;
    carMsgBoxView.top = carShapTitleView.bottom;
    [_customerView addSubview:carMsgBoxView];
    
    
    //金融点击申请
    __weak typeof(self) weakSelf = self;
    self.carBoxManger.boxView.applyTyple = ^(void){
        //自营及代理产品的点击响应事件
        if (self.productType == PRODUCT_Finance) {
            [weakSelf customerIntrestStateButtonAction];
        }else if (self.productType == PRODUCT_Dafenqi){
            //达分期产品的点击响应事件
            [weakSelf dafenqiProcessStateButtonAction];
        }
        
    };
    
    UIView *acesss1 = [self accessView:@"查看申请书" tag:Shenqingshu1Tag];
    [_customerView addSubview:acesss1];
    acesss1.top = carMsgBoxView.bottom;
    
    
    self.insuView.frame = CGRectMake(0, acesss1.bottom + 12, VCWeight, 207);
    [_customerView addSubview:self.insuView];
}
#pragma mark 意向单产品的点击响应事件
- (void)customerIntrestStateButtonAction
{
    if ([self.customerIntrestModel.state isEqualToString:@"16"] || [self.customerIntrestModel.patchState isEqualToString:@"01"] || [self.customerIntrestModel.state isEqualToString:@"00"]) {
        if ([self.customerIntrestModel.state isEqualToString:@"16"]) {
            [self.phud showHUDSaveAddedTo:self.view];
            [[CTTXRequestServer shareInstance] checkZhongShenWithIntentID:self.customerIntrestModel.intentID SuccessBlock:^(LLFFinalApprovalModel *finalApprovalModel) {
                [self.phud hideSave];
                //查看终审批复文档
                CGRect rect = self.view.bounds;
                rect.origin.x = rect.size.width;
                FinalApprovalView *finalApprovalView = [[FinalApprovalView alloc]initWithFrame:rect finalApprovalModel:finalApprovalModel from:NO];
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
            [SDCCustomerIntroViewModel checkMessageWithCustomerIntresModel:self.customerIntrestModel SuccessBlock:^(MessageModel *messageModel) {
                [self.phud hideSave];
                NSDictionary *StatusCodeRM = [messageModel yy_modelToJSONObject];
                NSMutableDictionary *mStatusCodeRM = [StatusCodeRM mutableCopy];
//                [mStatusCodeRM setObject:[NSString stringWithFormat:@"%@.pdf",self.dafenqiBusinessModel.loanContractNo] forKey:@"loanContractNo"];
//                [mStatusCodeRM setObject:[NSString stringWithFormat:@"%@.pdf",self.dafenqiBusinessModel.insuranceContractNo] forKey:@"insuranceContractNo"];
                [[NSUserDefaults standardUserDefaults]setObject:mStatusCodeRM forKey:@"StatusCodeRM"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                MainViewController *mainVC = [MainViewController new];
                mainVC.isHaveTop = NO;
                
                mainVC.startPage = [Tool getWWWPackAddressWithIndexName:@"imageData.html"];
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
        if ([self.customerIntrestModel.state isEqualToString:@"06"]) {
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
        NSNumber *isSelfRun = self.customerIntrestModel.productState;
        if (!isSelfRun) {
            isSelfRun = @(-1);
        }
        //如果是达分期，那么
        //        if (weakSelf.customerIntrestModel.isInsFq.intValue == 1) {
        //            isSelfRun = @(3);
        //        }
        
        
        //0、车辆品牌、1、达分期产品id、2、客户id、3、开票价、4、达芬奇产品名称、5、角色权限(1:金融经理,0:销售经理)、6、是否自营(是否自营 1自营 2代理 3达分期)、7、转借状态(0非转接  1转借)、8、意向单id、9、客户类型(01:企业,02:个人) 10.车辆销售名称，11.车辆指导价,12.购置税,13.保险费
        NSString *productState = [NSString stringWithFormat:@"%@",isSelfRun];
        NSMutableArray *paramArray = [NSMutableArray arrayWithObjects:self.customerIntrestModel.carPpName,self.customerIntrestModel.productID,self.customerIntrestModel.customerID,self.customerIntrestModel.contractAmount,self.customerIntrestModel.productName,isFinanceManager,productState,zhuanjieState,self.customerIntrestModel.intentID,self.customerContactModel.customerType,self.customerIntrestModel.catModelDetailName,self.customerIntrestModel.carPrice,self.customerIntrestModel.purchasetax,self.customerIntrestModel.insurance, nil];
        
        //存储本地
        [Tool saveIntentValueWithValueArr:paramArray];
        
        //存储当前客户信息
        NSDictionary *customerInfo = [self.customerContactModel yy_modelToJSONObject];
        
        [[NSUserDefaults standardUserDefaults] setObject:customerInfo forKey:@"customerInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //        [NSFileManager saveArrayToPath:DirectoryTypeDocuments withFilename:@"customIntrestInfo" array:paramArray];
        
        //如果是金融经理+转借中 跳application_informationB.html
        //如果不是金融经理+转借中 跳index
        if (isinformationTWeb) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.customerIntrestModel.intentID forKey:@"intentID"];
            [dic setObject:self.customerIntrestModel.productID forKey:@"productID"];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:dic forKey:@"lookApply"];
            [defaults synchronize];
            MainViewController *mainVC = [MainViewController new];
            
            mainVC.startPage = [Tool getWWWPackAddressWithIndexName:@"application_informationB.html"];
            mainVC.isHaveTop = NO;
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.mainVC = mainVC;
            
            [self presentViewController:mainVC animated:YES completion:nil];
            
            
            
        }else {
            MainViewController *mainVC = [MainViewController new];
            mainVC.isHaveTop = NO;
            //之后删除
            
            mainVC.startPage = [Tool getWWWPackAddressWithIndexName:@"index.html"];
            //mainVC.startPage = @"toStaging.html";
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.mainVC = mainVC;
            
            [self presentViewController:mainVC animated:YES completion:nil];
            
        }
    }
    
}
#pragma mark 达分期产品的点击响应事件
/**
 达分期产品的点击响应事件
 */
- (void)dafenqiProcessStateButtonAction
{
    [self.phud showHUDSaveAddedTo:self.view];
    [SDCCustomerIntroViewModel checkMessageWithDafenqiBusinessModel:self.dafenqiBusinessModel SuccessBlock:^(MessageModel *messageModel, NSDictionary *responseDict) {
        [self.phud hideSave];
        if (responseDict) {
            //客户拒绝-进行重启流程
            [self dafenqiRestartButtonActionWithMessageModel:messageModel respoonseDict:responseDict];
        }else{
            NSDictionary *StatusCodeRM = [messageModel yy_modelToJSONObject];
            NSMutableDictionary *mStatusCodeRM = [StatusCodeRM mutableCopy];
            [mStatusCodeRM setObject:[NSString stringWithFormat:@"%@.pdf",self.dafenqiBusinessModel.loanContractNo] forKey:@"loanContractNo"];
            [mStatusCodeRM setObject:[NSString stringWithFormat:@"%@.pdf",self.dafenqiBusinessModel.insuranceContractNo] forKey:@"insuranceContractNo"];
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
    /**
     跳转类型
     *01:一次影像资料采集
     *02:补件
     *03:二次进件
     *04:补保单
     *05:重启
     */
    //	NSString *stateStr;
    //	if ([self.dafenqiBusinessModel.patchState isEqualToString:@"01"]) {
    //		//补件
    //		stateStr = @"02";
    //
    //	}else{
    //		if ([self.dafenqiBusinessModel.processState isEqualToString:@"04"]) {
    //			//客户拒绝-进行重启流程
    //			[self dafenqiRestartButtonAction];
    //			return;
    //
    //		}else if ([self.dafenqiBusinessModel.processState isEqualToString:@"06"]){
    //			//审批通过,二次进件
    //			stateStr = @"03";
    //
    //		}else if ([self.dafenqiBusinessModel.processState isEqualToString:@"12"]){
    //			//需补保单
    //			stateStr = @"04";
    //
    //		}else if ([self.dafenqiBusinessModel.processState isEqualToString:@"13"]){
    //			//一次进件
    //			stateStr = @"01";
    //
    //		}
    //	}
    //	MessageModel *messageModel = [MessageCenterViewModel queryMessageModelWithBusinessID:self.dafenqiBusinessModel.businessID jumpType:stateStr];
    //	//一次影像资料采集 补件 二次进件 补保单
    //	NSDictionary *StatusCodeRM = [messageModel yy_modelToJSONObject];
    //	[[NSUserDefaults standardUserDefaults]setObject:StatusCodeRM forKey:@"StatusCodeRM"];
    //	[[NSUserDefaults standardUserDefaults] synchronize];
    //	MainViewController *mainVC = [MainViewController new];
    //	mainVC.isHaveTop = NO;
    //	mainVC.startPage = @"imageData.html";
    //	mainVC.isDaFenQiApply = YES;
    //	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //	appDelegate.mainVC = mainVC;
    //	[[UIViewController currentViewController] presentViewController:mainVC animated:YES completion:nil];
    
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
    
    //	MessageModel *messageModel = [MessageCenterViewModel queryMessageModelWithBusinessID:self.dafenqiBusinessModel.businessID jumpType:@"05"];
    //	[self.phud showHUDSaveAddedTo:self.view];
    //	//H5界面
    //	[[CTTXRequestServer shareInstance]checkCustomerWithCustomerID:messageModel.customerID SuccessBlock:^(NSDictionary *responseDict) {
    //		[self.phud hideSave];
    //		NSMutableDictionary *transferDict = [responseDict[@"res"] mutableCopy];
    //		//是否是扫描
    //		[transferDict setValue:@"1" forKey:@"isScan"];
    //        [transferDict setValue:messageModel.messageId forKey:@"messageId"];
    //		[[NSUserDefaults standardUserDefaults]setObject:transferDict forKey:@"dafenqiDic"];
    //		[[NSUserDefaults standardUserDefaults] synchronize];
    //
    //		MainViewController *applyMainVC = [[MainViewController alloc]init];
    //		applyMainVC.startPage = @"toStaging.html";
    //		applyMainVC.isDaFenQiApply = YES;
    //
    //		AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //		appDelegate.mainVC = applyMainVC;
    //		[[UIViewController currentViewController] presentViewController:applyMainVC animated:YES completion:nil];
    //	} failedBlock:^(NSError *error) {
    //		[self.phud hideSave];
    //		self.phud.promptStr = @"网络请求失败,请稍后重试";
    //		[self.phud showHUDResultAddedTo:self.view];
    //	}];
}

#pragma mark - getter and setter

- (UIScrollView *)customerView {
    if (_customerView == nil) {
        _customerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, VCWeight, VCHeight - 44)];
        _customerView.contentSize = CGSizeMake(_customerView.width, _customerView.height + 50);
        _customerView.backgroundColor = [UIColor hex:@"#F2F3F7"];
        [self createCustomerView];
    }
    return _customerView;
}

- (UITableView *)customerListView {
    if (_customerListView == nil) {
        _customerListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, VCWeight, VCHeight - 44) style:UITableViewStyleGrouped];
        _customerListView.delegate = self;
        _customerListView.dataSource = self;
        
        _customerListView.backgroundColor = [UIColor clearColor];
        
        __weak typeof(self) weakSelf = self;
        _customerListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //            [weakSelf getDataWithCustomerID:weakSelf.customerId];
            weakSelf.customerId = weakSelf.customerId;
        }];
    }
    return _customerListView;
}

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}

- (UIView *)smallNavView {
    if (_smallNavView == nil) {
        _smallNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VCWeight, 44)];
        [self.view addSubview:_smallNavView];
        _smallNavView.backgroundColor = [UIColor whiteColor];
        
        _detailTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
        [_smallNavView addSubview:_detailTitleLabel];
        _detailTitleLabel.centerX = _smallNavView.centerX;
        _detailTitleLabel.textColor = [UIColor hex:@"#333333"];
        
        _detailTitleLabel.font = [UIFont systemFontOfSize:18];
        
        _detailTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 50, 44)];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_smallNavView addSubview:btn];
        
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [btn setTitleColor:[UIColor hex:@"#274A72"] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(smallBackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smallNavView;
}

- (UIView *)customLabelView {
    if (_customLabelView == nil) {
        //客户标签视图
        _customLabelView= [self accessView:@"客户信息" tag:CustomInfoTag];
        _customLabelView.top = 0;
        
        _customNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        _customNameLabel.font = [UIFont systemFontOfSize:18];
        _customNameLabel.textColor = [UIColor hex:@"#333333"];
        
        _customNameLabel.left = 15;
        _customNameLabel.centerY = 53/2;
        [_customLabelView addSubview:_customNameLabel];
    }
    _customNameLabel.text = self.customerContactModel.customerName;
    return _customLabelView;
}

- (NSMutableDictionary *)idsType {
    //    if (_idsType == nil) {
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *cardTypeDic = tempArr[0];
    //获取客户类型列表
    NSArray *cardTypeArr;
    if ([Tool isCustomerPersonTypeWithCustomerType:self.customerContactModel.customerType]) {
        cardTypeArr = [cardTypeDic objectForKey:@"IDFS000322"];
    }else{
        cardTypeArr = [cardTypeDic objectForKey:@"IDFS000210"];
    }
    //        NSArray *cardTypeArr = [cardTypeDic objectForKey:@"IDFS000210"];
    _idsType = [NSMutableDictionary dictionary];
    for (NSDictionary *tempDic in cardTypeArr) {
        NSString *cardType = [tempDic objectForKey:@"dictname"];
        NSString *cardTypeCode = [tempDic objectForKey:@"dictvalue"];
        [_idsType setObject:cardType forKey:cardTypeCode];
    }
    //    }
    return _idsType;
}
- (NSDictionary *)financeRange {
    if (_financeRange == nil) {
        _financeRange = @{
                          @"01":@"车",
                          @"02":@"购置税",
                          @"03":@"保险"
                          };
    }
    return _financeRange;
}

- (UIView *)noDataView {
    if (_noDataView == nil) {
        _noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VCWeight, VCHeight)];
        _noDataView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 114/2, 101/2)];
        imgView.image = [UIImage imageNamed:@"icon_wushuju"];
        
        imgView.center = CGPointMake(_noDataView.width/2, _noDataView.height/2);
        
        [_noDataView addSubview:imgView];
    }
    return _noDataView;
}

- (UIView *)insuView {
    if (_insuView == nil) {
        _insuView = [[UIView alloc] init];
        _insuView.hidden = YES;
    }
    return _insuView;
}

/**
 变更代理产品的意向单状态
 
 @param sender 状态变更
 */
- (void)updataStateButtonAction:(UIButton *)sender
{
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *cardTypeDic = tempArr[0];
    //获取客户类型列表
    NSArray *productStateArr = [cardTypeDic objectForKey:@"IDFS000339"];
    
//    NSMutableArray *arr = [NSMutableArray array];
//    for (NSDictionary *tempDic in productStateArr) {
//        NSString *dictdesc = [tempDic objectForKey:@"dictdesc"];
//        if (dictdesc && dictdesc.length > 0 && [dictdesc isEqualToString:@"1"]) {
//            [arr addObject:tempDic];
//        }
//    }
    /*
     07:审批通过
     08:审批失败
     09:首付成功
     10:放款成功
     */
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择要修改的状态!" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:cancelAction];
    for (NSDictionary *tempDic in productStateArr) {
        NSString *dictdesc = [tempDic objectForKey:@"dictdesc"];
        if (dictdesc && dictdesc.length > 0 && [dictdesc isEqualToString:@"1"]) {
            NSString *dictname = [tempDic objectForKey:@"dictname"];
            NSString *dictvalue = [tempDic objectForKey:@"dictvalue"];
            UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:dictname style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [weakSelf updataProductState:dictvalue];
            }];
            [alertController addAction:deleteAction];
        }
    }
//    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"审批通过" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [weakSelf updataProductState:@"07"];
//    }];
//    UIAlertAction *applyFileAction = [UIAlertAction actionWithTitle:@"审批失败" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [weakSelf updataProductState:@"08"];
//    }];
//    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"首付成功" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        [weakSelf updataProductState:@"09"];
//    }];
//    UIAlertAction *openMoneyAction = [UIAlertAction actionWithTitle:@"放款成功" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        [weakSelf updataProductState:@"10"];
//    }];
    
//    [alertController addAction:deleteAction];
//    [alertController addAction:applyFileAction];
//    [alertController addAction:archiveAction];
//    [alertController addAction:openMoneyAction];
//    [alertController addAction:cancelAction];
    //    UIPopoverPresentationController *ppc = alertController.popoverPresentationController;
    //    ppc.delegate = self;
    //    ppc.sourceView = self.view;
    //    // 仔细看苹果文档，sourceRect是要与sourceView结合起来使用的。
    //    ppc.sourceRect = CGRectMake(kWidth / 2, kHeight / 2, self.view.frame.size.width, 100);// 显示在中心位置
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)updataProductState:(NSString *)state
{
    [self.phud showHUDSaveAddedTo:self.view];
    self.customerIntrestModel.state = state;
    NSDictionary *reqinfoDic = [self.customerIntrestModel yy_modelToJSONObject];
    [[CTTXRequestServer shareInstance] updateIntentWithInfoDict:reqinfoDic SuccessBlock:^(NSDictionary *responseObject) {
        [self.phud hideSave];
        BOOL result = [responseObject objectForKey:@"result"];
        if (result) {
            //            [self refreshDataWithCustomerID:self.customerId];
            self.customerId = self.customerId;
        }else{
            self.phud.promptStr = @"状态更新失败...请稍后重试!";
            [self.phud showHUDResultAddedTo:self.view];
        }
        
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        self.phud.promptStr = @"状态更新失败...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.view];
    }];
}
- (NSMutableAttributedString *)setText:(NSString *)text index:(NSUInteger)index firstColor:(NSString *)firstColor secondColor:(NSString *)secondColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor hex:firstColor] range:NSMakeRange(0,index)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor hex:secondColor] range:NSMakeRange(index,text.length - index)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(0, index)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0] range:NSMakeRange(index, text.length - index)];
    return str;
    
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}
@end
