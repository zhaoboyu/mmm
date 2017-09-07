//
//  SDCCustomerSearchController.m
//  YDJR
//
//  Created by sundacheng on 16/10/11.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDCCustomerSearchController.h"
#import "SDC_CMSearchBar.h"
#import "ZYPinYinSearch.h"
#import "HCSortString.h"
#import "SDCCMHeader.h"
#import "SDCCustomerContactModel.h"

#define AddressListW 578/2

@interface SDCCustomerSearchController ()<UISearchBarDelegate,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *allDataSource;//搜索数据源

@end

@implementation SDCCustomerSearchController
{
    SDC_CMSearchBar *_searchBar;
}

#pragma life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //数据源
    _allDataSource = [self.dataSource mutableCopy];

    //设置导航条
    [self setNavigation];
    
    //重写获取数据
//    [self getData];
    
    //移除下拉刷新
//    [self.addressListView.mj_header removeFromSuperview];
}

#pragma mark - get data

//- (void)getData {
//    [self addChildControllersWithCount:self.dataSource.count];
//}

#pragma mark - setNavigation
- (void)setNavigation {
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [backBtn setTitle:@"取消" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor hex:@"#FFFFFF"] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [backBtn addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _searchBar = [[SDC_CMSearchBar alloc] initWithFrame:CGRectMake(0, 0, 215, 28)];
    _searchBar.delegate = self;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:_searchBar];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItems = @[item2,item1];
}

#pragma mark - UISearchBarDelegate
//点击搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.view insertSubview:self.noSelectShowView atIndex:self.childViewControllers.count + 2];
    
    //搜索后结果
    NSArray *array;
    if (searchText.length == 0) {
        array = [_allDataSource mutableCopy];
    } else {
//        array = [ZYPinYinSearch searchWithOriginalArray:_allDataSource andSearchText:searchBar.text andSearchByPropertyName:@"customerName"];
        array = [self searchWithOriginalArray:_allDataSource keyStr:searchBar.text];
    }
    
    self.dataSource = [array mutableCopy];
    
    [self.addressListView reloadData];
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [super dids ]
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SDCCustomerContactModel *model = self.dataSource[indexPath.row];
    self.rightVC.customerContactModel = model;
//    [self showChildVcWithCustomerId:model.customerID];
    
    [_searchBar resignFirstResponder];
}

#pragma mark - action
//返回
- (void)leftBarButtonItemAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 赛选
- (NSMutableArray *)searchWithOriginalArray:(NSArray *)originalArray keyStr:(NSString *)keyStr
{
    NSMutableArray *soutArr = [NSMutableArray array];
    //匹配客户姓名//手机号//证件号
    for (SDCCustomerContactModel *model in originalArray) {
        if ([model.customerName containsString:keyStr] || [model.customerPhone containsString:keyStr] || [model.idsNumber containsString:keyStr]) {
            [soutArr addObject:model];
        }
    }
    
    return soutArr;
}
@end
