//
//  LSLeftMenuViewController.m
//  YDJR
//
//  Created by 李爽 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSLeftMenuViewController.h"
#import "LSLeftMenuTableViewCell.h"
#import "LSChoosedProductsModel.h"
#import "LSVSFinancialProgramViewController.h"
#define  CELLID @"CELLID"
@interface LSLeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate,LSVSFinancialProgramViewControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LSChoosedProductsModel *choosedProductsModel;
@property (nonatomic,assign,getter=isClear)BOOL clear;
@property (nonatomic,copy)NSMutableArray *recordArr;
@end

@implementation LSLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupView];
}

#pragma mark - lazy load
-(NSMutableArray *)recordArr
{
    if (!_recordArr) {
        _recordArr = [NSMutableArray array];
    }
    return _recordArr;
}

#pragma mark - p_setupView
- (void)p_setupView
{
    self.mainVC.delegate = self;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 496*wScale, 962*hScale)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LSLeftMenuTableViewCell class] forCellReuseIdentifier:CELLID];
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.numberOfRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSLeftMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (indexPath.row == 0) {
        cell.programTitleLabel.text = @"全款购车";
        cell.costAmountLabel.text = self.catModelDetailPrice;
    } else {
        LSChoosedProductsModel *m = self.choosedProductsModelArray[indexPath.row - 1];
        cell.programTitleLabel.text = m.productName;
        cell.costAmountLabel.text = m.khsjgccb;
    }
    
    cell.bgView.layer.borderWidth = 1.0f;
    cell.bgView.layer.borderColor = [UIColor colorWithHexString:@"#FFD9D9D9"].CGColor;
    
    if (self.numberOfRows == 2) {
        [self settingSelectedCellStateWithCell:cell];
    }
    
    if (self.isClear) {
        cell.bgView.backgroundColor = [UIColor colorWithHexString:@"##FFFFFFFF"];
        cell.programTitleLabel.textColor = [UIColor colorWithHexString:@"#FF333333"];
        cell.costOfCarLabel.textColor = [UIColor colorWithHexString:@"#FF999999"];
        cell.costAmountLabel.textColor = [UIColor colorWithHexString:@"#FFFC5A5A"];
    }
    
    if (self.recordArr.count > 0) {
        for (NSIndexPath *i in self.recordArr) {
            if (indexPath == i) {
                [self settingSelectedCellStateWithCell:cell];
            }
        }
    }
    
    return cell;
}

-(void)settingSelectedCellStateWithCell:(LSLeftMenuTableViewCell *)cell
{
    cell.bgView.backgroundColor = [UIColor colorWithHexString:@"#FFFC5A5A"];
    cell.programTitleLabel.textColor = [UIColor colorWithHexString:@"#FFFFFFFF"];
    cell.costOfCarLabel.textColor = [UIColor colorWithHexString:@"#FFFFFFFF"];
    cell.costAmountLabel.textColor = [UIColor colorWithHexString:@"#FFFFFFFF"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240 *hScale;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.numberOfRows == 2) {
        return;
    }
    
    if (self.recordArr.count > 1) {
        [Tool showAlertViewWithString:@"请先清除已选方案" withController:self];
        return;
    }
    
    if (_delegate && ([_delegate respondsToSelector:@selector(deselectLeftMenuWithIndexPath:)])) {
        [_delegate deselectLeftMenuWithIndexPath:indexPath];
    }
    
    [self.recordArr addObject:indexPath];
    [self.tableView reloadData];
}

#pragma mark - LSVSFinancialProgramViewControllerDelegate
-(void)clearSelectedProgram
{
    if (_delegate && ([_delegate respondsToSelector:@selector(clearDetailViewControllerSelectedProgram)])) {
        [_delegate clearDetailViewControllerSelectedProgram];
    }
    self.clear = YES;
    self.recordArr = nil;
    [self.tableView reloadData];
}

@end
