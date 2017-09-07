//
//  SDCCustomerGroupController.m
//  YDJR
//
//  Created by sundacheng on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDCCustomerGroupController.h"
#import "SDCCustomerIntroController.h"
#import "SDCCMHeader.h"

#import "SDCCustomerContactCell.h"

#import "HCSortString.h"

#define AddressListW 578/2

static NSString *customerContactCellCaridentis = @"customerContactCellCaridentis";

@interface SDCCustomerGroupController ()<UITableViewDelegate,UITableViewDataSource>

//通讯录
@property (nonatomic, strong) UITableView *addressListView;
//排序前的整个数据源
@property (strong, nonatomic) NSArray *dataSource;
//排序后的整个数据源
@property (strong, nonatomic) NSDictionary *allDataSource;
//搜索结果数据源
//@property (strong, nonatomic) NSMutableArray *searchDataSource;
//索引数据源
@property (strong, nonatomic) NSArray *indexDataSource;

//未选中时的view
@property (nonatomic, strong) UIView *noSelectShowView;

//用户介绍
@property (nonatomic, strong) SDCCustomerIntroController *customIntroController;

@end

@implementation SDCCustomerGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self.view addSubview:self.addressListView];
    [self.view addSubview:self.noSelectShowView];
    [self addChildVc];
}

#pragma mark - Init
- (void)initData {
    _dataSource = @[@"九寨沟",@"鼓浪屿",@"香格里拉",@"千岛湖",@"西双版纳",@"+-*/",@"故宫",@"上海科技馆",@"东方明珠",@"外滩",@"CapeTown",@"The Grand Canyon",@"4567.com",@"长江",@"长江1号",@"&*>?",@"弯弯月亮",@"that is it ?",@"山水之间",@"倩女幽魂",@"疆土无边",@"荡秋千"];
    
    _allDataSource = [HCSortString sortAndGroupForArray:_dataSource PropertyName:@"name"];
    _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
}

#pragma mark - 添加客户简介控制器
- (void)addChildVc {
    _customIntroController = [[SDCCustomerIntroController alloc] init];
    _customIntroController.view.frame = CGRectMake(AddressListW,0, kWidth, kHeight);
    _customIntroController.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:_customIntroController];
    [self.view addSubview:_customIntroController.view];
    _customIntroController.view.hidden = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _indexDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *value = [_allDataSource objectForKey:_indexDataSource[section]];
    return value.count;
}

//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _indexDataSource[section];
}

//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _indexDataSource;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDCCustomerContactCell *cell = [tableView dequeueReusableCellWithIdentifier:customerContactCellCaridentis];
    if (!cell) {
        cell = [[SDCCustomerContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customerContactCellCaridentis tableView:tableView];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
    cell.customName.text = value[indexPath.row];
    
    return cell;
}

//索引点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
    
    _customIntroController.view.hidden = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

#pragma mark - getter and setter
- (UITableView *)addressListView {
    if (_addressListView == nil) {
        _addressListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, AddressListW, kHeight - YDMarginTopHeight - TopOffSzie) style:UITableViewStylePlain];
        _addressListView.delegate = self;
        _addressListView.dataSource = self;
        [_addressListView setTableHeaderView:nil];
//        [_addressListView setSectionIndexColor:[UIColor hex:@"#333333"]];
//        _addressListView.sectionIndexBackgroundColor = [UIColor hex:@"#F2F2F2"];
    }
    return _addressListView;
}

- (UIView *)noSelectShowView {
    if (_noSelectShowView == nil) {
        _noSelectShowView = [[UIView alloc] initWithFrame:CGRectMake(AddressListW, 0, kWidth - AddressListW, self.view.bounds.size.height - YDMarginTopHeight - TopOffSzie)];
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

@end
