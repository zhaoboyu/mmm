//
//  LLFAgencyListTableView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/5/25.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFAgencyListTableView.h"
#import "LLFWorkBenchModel.h"
#import "LLFAgencyListTableViewCell.h"
#define kCell @"LLFAgencyListTableViewCell"
#import "FinalApprovalView.h"
#import "CTTXRequestServer+CustomerManager.h"
@interface LLFAgencyListTableView ()<UITableViewDelegate,UITableViewDataSource,LLFAgencyListTableViewCellDelegate>

@property (nonatomic,strong)HGBPromgressHud *phud;
@end

@implementation LLFAgencyListTableView
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
    self.tableView = [[UITableView alloc]initWithFrame:self.bounds style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LLFAgencyListTableViewCell class] forCellReuseIdentifier:kCell];
    [self addSubview:self.tableView];
}
#pragma mark 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLFAgencyListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    cell.workBenchModel = [self.modelArr objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}
- (void)clickButtonWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickButtonWithWorkBenchModel:)]) {
        [_delegate clickButtonWithWorkBenchModel:workBenchModel];
    }
}
#pragma mark 私有方法
- (void)setModelArr:(NSMutableArray *)modelArr
{
    if (modelArr) {
        [modelArr sortUsingComparator:^NSComparisonResult(LLFWorkBenchModel *obj1, LLFWorkBenchModel *obj2) {
            return [obj2.createDate compare:obj1.createDate];
        }];
    }
    _modelArr = modelArr;
    [self.tableView reloadData];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      LLFWorkBenchModel* workBenchModel = [self.modelArr objectAtIndex:indexPath.row];
    if([workBenchModel.state isEqualToString:@"13"]){
        //终审

      }

}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}
@end
