//
//  LLFDIYInsuranceInfoListView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/12.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFDIYInsuranceInfoListView.h"
#import "LLFDIYTopTitleView.h"
#import "LLFDIYInsuranceInfoListTableViewCell.h"
#define kCell @"LLFDIYInsuranceInfoListTableViewCell"
@interface LLFDIYInsuranceInfoListView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation LLFDIYInsuranceInfoListView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
- (void)setupView
{
    CGRect tableFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.tableView = [[UITableView alloc]initWithFrame:tableFrame style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    [self.tableView registerClass:[LLFDIYInsuranceInfoListTableViewCell class] forCellReuseIdentifier:kCell];
    
}
- (void)setInfoListModelArr:(NSMutableArray *)infoListModelArr
{
    _infoListModelArr = infoListModelArr;
    [self.tableView reloadData];
}
#pragma tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoListModelArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88 * hScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 72 * hScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLFDIYInsuranceInfoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    NSMutableArray *modelArr = self.infoListModelArr[indexPath.row];
    cell.modelArr = modelArr;

    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 72 * hScale)];
    
    bgView.image = [UIImage imageNamed:@"label_title"];
    
//    LLFDIYTopTitleView *topTitleOneView = [LLFDIYTopTitleView initWithFrame:CGRectMake(0, 0, 452 * wScale, 72 * hScale)];
//    [bgView addSubview:topTitleOneView];
//    LLFDIYTopTitleView *topTitleTwoView = [LLFDIYTopTitleView initWithFrame:CGRectMake(CGRectGetMaxX(topTitleOneView.frame), 0, 452 * wScale, 72 * hScale)];
//    [bgView addSubview:topTitleTwoView];
//    LLFDIYTopTitleView *topTitleThreeView = [LLFDIYTopTitleView initWithFrame:CGRectMake(CGRectGetMaxX(topTitleTwoView.frame), 0, 452 * wScale, 72 * hScale)];
//    [bgView addSubview:topTitleThreeView];
    return bgView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(InsuranceInfoListButtonstate:)]) {
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
