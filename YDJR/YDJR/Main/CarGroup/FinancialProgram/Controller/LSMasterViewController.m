//
//  LSMasterViewController.m
//  YDJR
//
//  Created by 李爽 on 2016/11/14.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSMasterViewController.h"
#import "LSMasterTableViewCell.h"
#import "LSChoosedProductsModel.h"
#import "LSVSFinancialProgramViewController.h"
#define  CELLID @"CELLID"
@interface LSMasterViewController ()<UITableViewDataSource,UITableViewDelegate,LSVSFinancialProgramViewControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)LSChoosedProductsModel *choosedProductsModel;
@property (nonatomic,assign,getter=isClear)BOOL clear;
@property (nonatomic,copy)NSMutableArray *recordArr;
@property (nonatomic,strong)NSArray *ProductsBGImageNameArr;
@end

@implementation LSMasterViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self p_setupView];
}

#pragma mark - p_setupView
- (void)p_setupView
{
	self.mainVC.delegate = self;
	self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 24 * hScale, 536 * wScale, 1232 * hScale)];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.tableView registerClass:[LSMasterTableViewCell class] forCellReuseIdentifier:CELLID];
	[self.view addSubview:self.tableView];
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.numberOfRows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LSMasterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    NSString *imageName = [self.ProductsBGImageNameArr objectAtIndex:indexPath.row % 8];
    cell.pictuerImageView.image = [UIImage imageNamed:imageName];
	if (indexPath.row == 0) {
		cell.programTitleLabel.text = @"全款购车";
		cell.costAmountLabel.text = self.fullPaymentRealPrice;
//		cell.pictuerImageView.image = [UIImage imageNamed:@"bg_pressed_quankuangouche"];
	} else {
		LSChoosedProductsModel *m = self.choosedProductsModelArray[indexPath.row - 1];
		cell.programTitleLabel.text = m.productName;
		cell.costAmountLabel.text = m.khsjgccb;
//		if ([m.productID isEqualToString:@"1"]) {
//			cell.pictuerImageView.image = [UIImage imageNamed:@"bg_pressed_rongzizulinbiaozhunchanpin"];
//		}
//		if ([m.productID isEqualToString:@"2"]) {
//			cell.pictuerImageView.image = [UIImage imageNamed:@"bg_pressed_kaixinche"];
//		}
//		if ([m.productID isEqualToString:@"20"]) {
//			cell.pictuerImageView.image = [UIImage imageNamed:@"bg_pressed_yinhangdaikuan"];
//		}
//		if ([m.productID isEqualToString:@"21"]) {
//			cell.pictuerImageView.image = [UIImage imageNamed:@"bg_pressed_rongzizulinbaozhengjinchanpin"];
//		}
//		if ([m.productID isEqualToString:@"22"]) {
//			cell.pictuerImageView.image = [UIImage imageNamed:@"bg_pressed_rongzizulintiexichanpin"];
//		}
//		if ([m.productID isEqualToString:@"23"]) {
//			cell.pictuerImageView.image = [UIImage imageNamed:@"bg_pressed_baomajinrongtiexi"];
//		}
//		if ([m.productID isEqualToString:@"24"]) {
//			cell.pictuerImageView.image = [UIImage imageNamed:@"bg_pressed_baomaweikuantiexi"];
//		}
	}
	
	if (self.numberOfRows == 2) {
		[self settingSelectedCellStateWithCell:cell];
	}
	
	if (self.isClear) {
		cell.bgView.backgroundColor = [UIColor hex:@"#CCFFFFFF"];
		cell.programTitleLabel.textColor = [UIColor hex:@"#FF333333"];
		cell.costOfCarLabel.textColor = [UIColor colorWithColor:[UIColor hexString:@"#FF333333"] alpha:0.65];
		cell.costAmountLabel.textColor = [UIColor colorWithColor:[UIColor hexString:@"#FF333333"] alpha:0.65];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 232 *hScale;
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

/**
 设置选中的cell的状态
 
 @param cell LSMasterTableViewCell
 */
-(void)settingSelectedCellStateWithCell:(LSMasterTableViewCell *)cell
{
	cell.bgView.backgroundColor = [UIColor hexString:@"#99000000"];
	cell.programTitleLabel.textColor = [UIColor hex:@"#FFFFFFFF"];
	cell.costOfCarLabel.textColor = [UIColor colorWithColor:[UIColor hexString:@"#FFFFFFFF"] alpha:0.65];
	cell.costAmountLabel.textColor = [UIColor colorWithColor:[UIColor hexString:@"#FFFFFFFF"] alpha:0.65];
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

#pragma mark - lazy load
-(NSMutableArray *)recordArr
{
	if (!_recordArr) {
		_recordArr = [NSMutableArray array];
	}
	return _recordArr;
}
- (NSArray *)ProductsBGImageNameArr
{
    if (!_ProductsBGImageNameArr) {
        _ProductsBGImageNameArr = @[@"bg_pressed_quankuangouche",@"bg_pressed_rongzizulinbiaozhunchanpin",@"bg_pressed_kaixinche",@"bg_pressed_yinhangdaikuan",@"bg_pressed_rongzizulinbaozhengjinchanpin",@"bg_pressed_rongzizulintiexichanpin",@"bg_pressed_baomajinrongtiexi",@"bg_pressed_baomaweikuantiexi"];
    }
    return _ProductsBGImageNameArr;
}
@end
