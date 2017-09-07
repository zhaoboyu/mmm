
//
//  SDCCustomerManagerController.m
//  YDJR
//
//  Created by sundacheng on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//


#import "SDCCMHeader.h"
#import "SDCCustomerManagerController.h"
#import "SDCCustomerSearchController.h"

#import "SDCCustomerContactCell.h"
#import "LSCarDetailsViewController.h"

#import "MJRefresh.h"

//model
#import "SDCCustomerContactModel.h"

//视图
#import "SDCSelectCMBtn.h"
#import "SDC_CMSearchBar.h"

//api
#import "CTTXRequestServer+CustomerManager.h"


//tag
#define SelectCMBtnTag 200

//size
#define TopSelectViewH (128)/2

#define SelectBtnW 208/2
#define SelectBtnH 72/2
#define SelectBtnCenterX 144/2

#define AddressListW 578/2

static NSString *customerContactCellCaridentis = @"customerContactCellCaridentis";

@interface SDCCustomerManagerController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

//显示字典
@property (nonatomic, strong) NSMutableDictionary *selectDict;

@property (nonatomic,strong)HGBPromgressHud *phud;

@end

@implementation SDCCustomerManagerController

#pragma mark - life circle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigation];
    //加载数据
    [self updataData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.customerId = [[NSUserDefaults standardUserDefaults] objectForKey:@"SDDcustomCardNumId"]?[[NSUserDefaults standardUserDefaults] objectForKey:@"SDDcustomCardNumId"]:self.customerId;
//    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"SDDcustomCardNumId"];
    //设置导航条
    [self setNavigation];
    
    
    
    //添加视图
    [self.view addSubview:self.addressListView];
    [self.view addSubview:self.noSelectShowView];
}
- (void)setCustomerId:(NSString *)customerId
{
    _customerId = customerId;
    
    [self.phud showHUDSaveAddedTo:self.view];
    [[CTTXRequestServer shareInstance] searchCustomerInfoWithSuccessBlock:^(NSMutableArray *customerArray) {
        [self.phud hideSave];
        
        self.dataSource = customerArray;
        
        //        [self addChildControllersWithCount:self.dataSource.count];
        
        [self.addressListView.mj_header endRefreshing];
        [self.addressListView reloadData];
        if (self.dataSource.count > 0) {
            NSInteger row = -1;
            for (NSInteger i = 0; i < self.dataSource.count; i++) {
                SDCCustomerContactModel *model = self.dataSource[i];
                if ([model.customerID isEqualToString:_customerId]) {
                    row = i;
                    break;
                }
            }
            if (!(row == -1)) {
                NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
                [self.addressListView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                
                [self tableView:self.addressListView didSelectRowAtIndexPath:selectedIndexPath];
            }
            
        }
        

        
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        
        [self.addressListView.mj_header endRefreshing];
        
        self.phud.promptStr = @"服务器异常...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.view];
    }];

    
//    SDCCustomerContactModel *model = self.dataSource[indexPath.row];
}
#pragma mark - get data
- (void)getData {
//    [self.phud showHUDSaveAddedTo:self.view];
    [[CTTXRequestServer shareInstance] searchCustomerInfoWithSuccessBlock:^(NSMutableArray *customerArray) {
//        [self.phud hideSave];
        
        self.dataSource = customerArray;
        
//        [self addChildControllersWithCount:self.dataSource.count];
        
        [self.addressListView.mj_header endRefreshing];
        [self.addressListView reloadData];
        
//        if (self.navigationController.childViewControllers.count >= 2) {
//            //如果是从LSCarDetailsViewController过来的，那么选中刚刚加入的客户
//            UIViewController *fromVc = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 2];
//            if ([fromVc isKindOfClass:[LSCarDetailsViewController class]]) {
//                if (self.customerId) {
//                    //取
//                    NSString *indexString = [_selectDict valueForKey:self.customerId];
//                    
//                    NSLog(@"%@",self.customerId);
//                    
//                    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:indexString.integerValue inSection:0];
//                    [self.addressListView.delegate tableView:self.addressListView didSelectRowAtIndexPath:indexPath];
//                    [self.addressListView selectRowAtIndexPath:indexPath animated:NO scrollPosition:(UITableViewScrollPositionTop)];
//                }
//            }
//        }
        
    } failedBlock:^(NSError *error) {
//        [self.phud hideSave];

        [self.addressListView.mj_header endRefreshing];
        
        self.phud.promptStr = @"服务器异常...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.view];
    }];
}
#pragma mark - get data
- (void)updataData {
    [self.phud showHUDSaveAddedTo:self.view];
    [[CTTXRequestServer shareInstance] searchCustomerInfoWithSuccessBlock:^(NSMutableArray *customerArray) {
        [self.phud hideSave];
        
        self.dataSource = customerArray;
        
        //        [self addChildControllersWithCount:self.dataSource.count];
        
//        [self.addressListView.mj_header endRefreshing];
        [self.addressListView reloadData];
        
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        
        [self.addressListView.mj_header endRefreshing];
        
        self.phud.promptStr = @"服务器异常...请稍后重试!";
        [self.phud showHUDResultAddedTo:self.view];
    }];
}
#pragma mark - set navigation
- (void)setNavigation {
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back_Nav"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
//    self.navigationItem.rightBarButtonItem =nil;
//    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
//    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor hex:@"#FFFFFFFF"]];
//    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_Nav"] forBarMetrics:UIBarMetricsDefault];
    
    UIImage *oimge = [[UIImage imageNamed:@"icon_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:oimge style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction:)];
    
    self.navigationItem.title = @"客户管理";
    NSMutableDictionary *titleAttributesDic = [NSMutableDictionary dictionary];
    [titleAttributesDic setObject:[UIColor hex:@"#FFFFFFFF"] forKey:NSForegroundColorAttributeName];
    [titleAttributesDic setObject:[UIFont systemFontOfSize:18.0] forKey:NSFontAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributesDic];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 添加客户简介控制器
//- (void)addChildControllersWithCount:(NSInteger)count {
//    
//    _selectDict = [[NSMutableDictionary alloc] init];
//    for (NSInteger i = 0; i < count; i++) {
//        SDCCustomerIntroController *customIntroController = [[SDCCustomerIntroController alloc] init];
//        
//        SDCCustomerContactModel *model = self.dataSource[i];
//        
//        //客户id作为key，idex作为值
//        [_selectDict setObject:[NSString stringWithFormat:@"%ld",(long)i] forKey:model.customerID];
//        
//        customIntroController.customerId = model.customerID;
//        customIntroController.customerContactModel = model;
//        
//        [self addChildViewController:customIntroController];
//    }
//}

#pragma mark - 显示客户简介控制器
//- (void)showChildVcWithCustomerId:(NSString *)customerId{
//    //取
//    NSString *indexString = [_selectDict valueForKey:customerId];
//    
//    SDCCustomerIntroController *cvc = self.childViewControllers[indexString.intValue];
//    
//    cvc.isSelected = YES;
//    
//    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
//        SDCCustomerIntroController *cvc = self.childViewControllers[i];
//        if (i == indexString.integerValue) {
//            cvc.isSelected = YES;
//        } else {
//            cvc.isSelected = NO;
//        }
//    }
//    
//    cvc.view.frame = CGRectMake(AddressListW,0, kWidth, kHeight);
//    cvc.view.backgroundColor = [UIColor whiteColor];
//    
//    [self.view insertSubview:cvc.view atIndex:self.childViewControllers.count + 2];
//}

#pragma mark - Action
//返回
//- (void)leftBarButtonItemAction:(UIButton *)sender
//{
//    [self.phud hideSave];
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

//客户搜索
- (void)rightBarButtonItemAction:(UIButton *)sender {
    SDCCustomerSearchController *svc = [[SDCCustomerSearchController alloc] init];
    
    svc.dataSource = self.dataSource;
    
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDCCustomerContactCell *cell = [tableView dequeueReusableCellWithIdentifier:customerContactCellCaridentis];
    if (!cell) {
        cell = [[SDCCustomerContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customerContactCellCaridentis tableView:tableView];
    }
    
    SDCCustomerContactModel *model = self.dataSource[indexPath.row];
    
    [cell reloadDataWithModel:model];
    
    return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SDCCustomerContactModel *model = self.dataSource[indexPath.row];
    self.rightVC.customerContactModel = model;
//    [self showChildVcWithCustomerId:model.customerID];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

#pragma mark - getter and setter

- (UITableView *)addressListView {
    if (_addressListView == nil) {
        _addressListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, AddressListW - 1, kHeight - YDMarginTopHeight - TopOffSzie) style:UITableViewStyleGrouped];
        _addressListView.delegate = self;
        _addressListView.dataSource = self;
        _addressListView.backgroundColor = [UIColor whiteColor];

        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(AddressListW - 1, 0, 1, kHeight)];
        [self.view addSubview:line];
        line.backgroundColor = [UIColor hex:@"#FFCCCCCC"];
        
        __weak typeof(self) weakSelf = self;
        _addressListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf getData];
        }];
    }
    return _addressListView;
}


- (UIView *)noSelectShowView {
    if (_noSelectShowView == nil) {
        _noSelectShowView = [[UIView alloc] initWithFrame:CGRectMake(AddressListW, 0, kWidth - AddressListW, self.view.bounds.size.height - YDMarginTopHeight - TopOffSzie)];
        _noSelectShowView.backgroundColor = [UIColor whiteColor];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 54, 71.5)];
        img.image = [UIImage imageNamed:@"icon_default_head portrait"];
        img.center = CGPointMake(_noSelectShowView.width/2, _noSelectShowView.height/2 - 110);
        [_noSelectShowView addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.centerX = img.centerX;
        label.centerY = img.bottom + 30;
        [_noSelectShowView addSubview:label];
        label.textColor = [UIColor hex:@"#D9D9D9"];
        label.text = @"请选择相关客户";
        label.font = [UIFont systemFontOfSize:15];
    }
    return _noSelectShowView;
}
- (SDCCustomerIntroController *)rightVC{
    if (!_rightVC) {
        _rightVC = [SDCCustomerIntroController new];
        [self addChildViewController:_rightVC];
        _rightVC.view.frame = CGRectMake(AddressListW,0, kWidth - AddressListW, kHeight - 64);
        _rightVC.view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_rightVC.view];
    }
    return _rightVC;
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}
@end
