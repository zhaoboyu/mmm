//
//  LLFCarDetailInfoView.m
//  YDJR
//
//  Created by 吕利峰 on 2016/12/21.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarDetailInfoView.h"
#import "LLFCarDetailInfoTableViewCell.h"
#define kCell @"LLFCarDetailInfoTableViewCell."
@interface LLFCarDetailInfoView ()<UITableViewDelegate,UITableViewDataSource>
/**
 左侧销售名称信息列表
 */
@property (nonatomic,strong)UITableView *tableView;
/**
 右侧销售名称信息列表
 */
@property (nonatomic,strong)UITableView *rightTableView;
@end


@implementation LLFCarDetailInfoView


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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(80 * wScale, 40 * hScale, 640 * wScale, 560 * hScale) style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[LLFCarDetailInfoTableViewCell class] forCellReuseIdentifier:kCell];
    [self addSubview:self.tableView];
    
    self.rightTableView = [[UITableView alloc]initWithFrame:CGRectMake(160 * wScale + CGRectGetMaxX(self.tableView.frame), CGRectGetMinY(self.tableView.frame), CGRectGetWidth(self.tableView.frame), CGRectGetHeight(self.tableView.frame)) style:(UITableViewStylePlain)];
    self.rightTableView.backgroundColor = [UIColor clearColor];
    self.rightTableView.delegate = self;
    self.rightTableView.dataSource = self;
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.scrollEnabled = NO;
    [self.rightTableView registerClass:[LLFCarDetailInfoTableViewCell class] forCellReuseIdentifier:kCell];
    [self addSubview:self.rightTableView];
    
    
}

/**
 更新左侧列表

 @param leftDetailDic 左侧数据源
 */
- (void)setLeftDetailDic:(NSMutableDictionary *)leftDetailDic
{
    _leftDetailDic = leftDetailDic;
    [self.tableView reloadData];
}

/**
 右侧列表

 @param rightDetailDic 右侧数据源
 */
- (void)setRightDetailDic:(NSMutableDictionary *)rightDetailDic
{
    _rightDetailDic = rightDetailDic;
    [self.rightTableView reloadData];
}
#pragma tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        return [self.leftDetailDic allKeys].count;
    }else{
        return [self.rightDetailDic allKeys].count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98 * hScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLFCarDetailInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    if ([tableView isEqual:self.tableView]) {
        NSString *key = [self.leftDetailDic allKeys][indexPath.row];
        cell.titleNameLabel.text = key;
        cell.titleDetailLabel.text = [self.leftDetailDic objectForKey:key];
    }else{
        NSString *key = [self.rightDetailDic allKeys][indexPath.row];
        cell.titleNameLabel.text = key;
        cell.titleDetailLabel.text = [self.rightDetailDic objectForKey:key];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (_delegate && [_delegate respondsToSelector:@selector(seriesListButtonMechanismModel:)]) {
    //        LLFMechanismCarModel *mechanismCarModel = self.mechanisCarModelArr[indexPath.row];
    //        [self.delegate seriesListButtonMechanismModel:mechanismCarModel];
    //    }
}
@end
