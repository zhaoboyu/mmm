//
//  LLFSeriesListView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFSeriesListView.h"
#import "LLFSeriesListTableViewCell.h"
#import "LLFMechanismCarModel.h"
#import "LLFSelectCarTypeDIYView.h"
#define kCell @"LLFSeriesListTableViewCell"
@interface LLFSeriesListView ()<UITableViewDelegate,UITableViewDataSource,LLFSelectCarTypeDIYViewDelegate>
@property (nonatomic,strong)UIImageView *nullImageView;
@end


@implementation LLFSeriesListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupViewWithFrame:frame];
    }
    return self;
}

- (void)p_setupViewWithFrame:(CGRect)frame
{
    LLFSelectCarTypeDIYView *selectView = [[LLFSelectCarTypeDIYView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 88 * hScale)];
    selectView.delegate = self;
    [self addSubview:selectView];
    
    CGRect tableViewCgrect = CGRectMake(0, CGRectGetMaxY(selectView.frame), frame.size.width, frame.size.height);
    self.tableView = [[UITableView alloc]initWithFrame:tableViewCgrect style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    [self.tableView registerClass:[LLFSeriesListTableViewCell class] forCellReuseIdentifier:kCell];
    
}
- (void)setMechanisCarModelArr:(NSMutableArray *)mechanisCarModelArr
{
    _mechanisCarModelArr = mechanisCarModelArr;
    [_tableView reloadData];
}
#pragma tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mechanisCarModelArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98 * hScale;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 88 * hScale;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLFSeriesListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    LLFMechanismCarModel *mechanismCarModel = self.mechanisCarModelArr[indexPath.row];
    cell.seriesNameLabel.text = mechanismCarModel.carSeriesName;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 480 * wScale, 88 * hScale)];
    bgView.backgroundColor = [UIColor hexString:@"#FFF0F1F5"];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 32 * hScale, 448 * wScale, 24 * hScale)];
    titleLabel.text = @"车系";
    titleLabel.textColor = [UIColor hexString:@"#FF666666"];
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    [bgView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame) + 6 * hScale, 52 * wScale, 2 * hScale)];
    lineView.backgroundColor = [UIColor hexString:@"#FF666666"];
    [bgView addSubview:lineView];
    return bgView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(seriesListButtonMechanismModel:)]) {
        LLFMechanismCarModel *mechanismCarModel = self.mechanisCarModelArr[indexPath.row];
        [self.delegate seriesListButtonMechanismModel:mechanismCarModel];
    }
}
#pragma mark LLFSelectCarTypeDIYViewDelegate
- (void)selectIndexWithCarType:(NSString *)carType
{
    if (_delegate && [_delegate respondsToSelector:@selector(selectCarTypeWithCarType:)]) {
        [self.delegate selectCarTypeWithCarType:carType];
    }
}
@end
