//
//  LLFCarBuyTypeListView.m
//  YDJR
//
//  Created by 吕利峰 on 2016/12/20.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarBuyTypeListView.h"
#import "LLFCarBuyTypeListTableViewCell.h"
#import "LLFCarModel.h"
#define kCell @"LLFCarBuyTypeListTableViewCell"
@interface LLFCarBuyTypeListView ()<UITableViewDelegate,UITableViewDataSource>

/**
 销售名称列表
 */
@property (nonatomic,strong)UITableView *tableView;

@end


@implementation LLFCarBuyTypeListView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.backgroundColor = [UIColor hex:@"#4DFFFFFF"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(10 * wScale, 10 * hScale, 520 * wScale, 600 * hScale) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LLFCarBuyTypeListTableViewCell class] forCellReuseIdentifier:kCell];
    [self addSubview:self.tableView];
    
    

}
- (void)setCarBuyTypeDic:(NSMutableDictionary *)carBuyTypeDic
{
    _carBuyTypeDic = carBuyTypeDic;
    [self.tableView reloadData];
    if ([[carBuyTypeDic allKeys] count] > 0) {
        //设置默认选中cell
        NSInteger selectedIndex = 0;
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        [self tableView:self.tableView didSelectRowAtIndexPath:selectedIndexPath];
    }
    
}
#pragma tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.carBuyTypeDic allKeys] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *keyArr = [Tool sortWithArr:[self.carBuyTypeDic allKeys] sort:@"0"];
    NSString *key = keyArr[section];
    NSArray *valueArr = [self.carBuyTypeDic objectForKey:key];
    return valueArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98 * hScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 64 * hScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLFCarBuyTypeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    [cell labelTextColorWithColor:@"#FF000000"];
    NSArray *keyArr = [Tool sortWithArr:[self.carBuyTypeDic allKeys] sort:@"0"];
    NSArray *valueArr = [self.carBuyTypeDic objectForKey:keyArr[indexPath.section]];
    LLFCarModel *carModel = valueArr[indexPath.row];
    cell.carBuyTypeNameLabel.text = carModel.catModelDetailName;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 520 * wScale, 64 * hScale)];
    bgView.backgroundColor = [UIColor hex:@"#D9FFFFFF"];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(32 * wScale, 24 * hScale, 101 * wScale, 40 * hScale)];
    bgImageView.image = [UIImage imageNamed:@"LLF_SelectNewCarType_tag_ninakuan"];
    [bgView addSubview:bgImageView];
    
    NSArray *keyArr = [Tool sortWithArr:[self.carBuyTypeDic allKeys] sort:@"0"];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:bgImageView.bounds];
    NSString *yearStr = keyArr[section];
    titleLabel.text = yearStr;
    titleLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:titleLabel];
    return bgView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *keyArr = [Tool sortWithArr:[self.carBuyTypeDic allKeys] sort:@"0"];
    NSArray *valueArr = [self.carBuyTypeDic objectForKey:keyArr[indexPath.section]];
    LLFCarModel *carModel = valueArr[indexPath.row];
    if (_delegate && [_delegate respondsToSelector:@selector(clickCarBuyListWith:)]) {
        [self.delegate clickCarBuyListWith:carModel];
    }
}
@end
