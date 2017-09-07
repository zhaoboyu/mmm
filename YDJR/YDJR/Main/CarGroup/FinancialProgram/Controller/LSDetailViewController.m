//
//  LSDetailViewController.m
//  YDJR
//
//  Created by 李爽 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSDetailViewController.h"
#import "LSDetailTableViewCell.h"
#import "LSMasterViewController.h"
#import "LSChoosedProductsModel.h"
#import "LSVSFinancialProgramViewController.h"
#define  CELLID @"CELLID"

@interface LSDetailViewController ()<UITableViewDataSource,UITableViewDelegate,LSMasterViewControllerDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)NSArray *fullPaymentArr;//全款
@property (nonatomic,strong)LSChoosedProductsModel *choosedProductsModel;
@property (nonatomic,copy)NSMutableArray *transferArr;
@property (nonatomic,copy)NSMutableArray *headerTitleArr;
@end

@implementation LSDetailViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self p_setupView];
}
#pragma mark - p_setupView
- (void)p_setupView
{
	self.leftVC.delegate = self;
	self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 24 * hScale, 1160 * wScale, 1232 * hScale)];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	self.tableView.separatorColor = [UIColor hexString:@"#FFE3E3E3"];
	[self.tableView registerClass:[LSDetailTableViewCell class] forCellReuseIdentifier:CELLID];
	[self.view addSubview:self.tableView];
}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 16;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LSDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
	cell.categoryTitleLabel.text = self.titleArray[indexPath.row];
	if (self.choosedProductsModelArray.count == 1) {
		self.choosedProductsModel = self.choosedProductsModelArray[0];
		NSArray *tempArr = [self refreshDataWithChoosedProductsModel:self.choosedProductsModel];
		cell.fullPaymentLabel.text = self.fullPaymentArr[indexPath.row];
		cell.bankLoanLabel.text = tempArr[indexPath.row];
		NSString *fullPaymentString = self.fullPaymentArr[indexPath.row];
		NSString *banklLoanString = tempArr[indexPath.row];
		if (indexPath.row <= 6) {
			if ([fullPaymentString floatValue] > [banklLoanString floatValue]) {
				cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
				cell.bankLoanLabel.textColor = [UIColor greenColor];
			}else if ([fullPaymentString floatValue] == [banklLoanString floatValue]){
				cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
				cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
			}else{
				cell.fullPaymentLabel.textColor = [UIColor greenColor];
				cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
			}
		}else{
			if (indexPath.row == 15) {
				if ([fullPaymentString floatValue] > [banklLoanString floatValue]) {
					cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
					cell.bankLoanLabel.textColor = [UIColor greenColor];
				}else if ([fullPaymentString floatValue] == [banklLoanString floatValue]){
					cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
					cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
				}else{
					cell.fullPaymentLabel.textColor = [UIColor greenColor];
					cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
				}
			}else{
				if ([fullPaymentString floatValue] > [banklLoanString floatValue]) {
					cell.fullPaymentLabel.textColor = [UIColor greenColor];
					cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
				}else if ([fullPaymentString floatValue] == [banklLoanString floatValue]){
					cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
					cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
				}else{
					cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
					cell.bankLoanLabel.textColor = [UIColor greenColor];
				}

			}
		}
	}else{
		cell.fullPaymentLabel.text = @"";
		cell.bankLoanLabel.text = @"";
		if (self.transferArr.count > 0) {
			NSArray *tempArr = self.transferArr[0];
			cell.fullPaymentLabel.text = tempArr[indexPath.row];
			if (self.transferArr.count > 1) {
				NSArray *tempArr = self.transferArr[1];
				cell.bankLoanLabel.text = tempArr[indexPath.row];
				
				NSString *fullPaymentString = self.transferArr[0][indexPath.row];
				NSString *banklLoanString = self.transferArr[1][indexPath.row];
				if (indexPath.row <= 6) {
					if ([fullPaymentString floatValue] > [banklLoanString floatValue]) {
						cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
						cell.bankLoanLabel.textColor = [UIColor greenColor];
					}else if ([fullPaymentString floatValue] == [banklLoanString floatValue]){
						cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
						cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
					}else{
						cell.fullPaymentLabel.textColor = [UIColor greenColor];
						cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
					}
				}else{
					if (indexPath.row == 15) {
						if ([fullPaymentString floatValue] > [banklLoanString floatValue]) {
							cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
							cell.bankLoanLabel.textColor = [UIColor greenColor];
						}else if ([fullPaymentString floatValue] == [banklLoanString floatValue]){
							cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
							cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
						}else{
							cell.fullPaymentLabel.textColor = [UIColor greenColor];
							cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
						}
					}else{
						if ([fullPaymentString floatValue] > [banklLoanString floatValue]) {
							cell.fullPaymentLabel.textColor = [UIColor greenColor];
							cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
						}else if ([fullPaymentString floatValue] == [banklLoanString floatValue]){
							cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
							cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
						}else{
							cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
							cell.bankLoanLabel.textColor = [UIColor greenColor];
						}
					}
				}

			}
		}
	}
	
	if (indexPath.row == 6|| indexPath.row == 15) {
		cell.backgroundColor = [UIColor hexString:@"#FF333333"];
		cell.categoryTitleLabel.textColor = [UIColor whiteColor];
//		cell.fullPaymentLabel.textColor = [UIColor whiteColor];
//		cell.bankLoanLabel.textColor = [UIColor whiteColor];
	}else{
		cell.backgroundColor = [UIColor clearColor];
		cell.categoryTitleLabel.textColor = [UIColor hexString:@"#FF000000"];
//		cell.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
//		cell.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
	}
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 112 * hScale;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 24 * hScale, self.tableView.width, 94 * hScale)];
	bgView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
	UILabel *fullPaymentLabel = [[UILabel alloc]initWithFrame:CGRectMake(380 * wScale, 41 * hScale, 308 * wScale, 30 *hScale)];
	if (self.choosedProductsModelArray.count == 1) {
		fullPaymentLabel.text = @"全款购车";
	}else{
		if (self.headerTitleArr.count > 0) {
			fullPaymentLabel.text = self.headerTitleArr[0];
		}else{
			fullPaymentLabel.text = @"";
		}
	}
	fullPaymentLabel.font = [UIFont systemFontOfSize:15];
	fullPaymentLabel.textAlignment = NSTextAlignmentRight;
	fullPaymentLabel.textColor = [UIColor hexString:@"#FF999999"];
	[bgView addSubview:fullPaymentLabel];
	
	UILabel *bankLoanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(fullPaymentLabel.frame), 41 * hScale, 376 * wScale, 30 * hScale)];
	if (self.choosedProductsModelArray.count == 1) {
		self.choosedProductsModel = self.choosedProductsModelArray[0];
		bankLoanLabel.text = self.choosedProductsModel.productName;
	}else{
		if (self.headerTitleArr.count > 1) {
			bankLoanLabel.text = self.headerTitleArr[1];
		}else{
			bankLoanLabel.text = @"";
		}
	}
	bankLoanLabel.font = [UIFont systemFontOfSize:15];
	bankLoanLabel.textAlignment = NSTextAlignmentRight;
	bankLoanLabel.textColor = [UIColor hexString:@"#FF999999"];
	[bgView addSubview:bankLoanLabel];
	
	UIView *cuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 93 * hScale, self.tableView.width, hScale)];
	cuttingLine.backgroundColor = [UIColor hexString:@"#FFE3E3E3"];
	[bgView addSubview:cuttingLine];
	return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 72*hScale;
}

#pragma mark - LSMasterViewControllerDelegate
-(void)deselectLeftMenuWithIndexPath:(NSIndexPath *)indexPath
{
	
	if (indexPath.row == 0) {
		[self.transferArr addObject:self.fullPaymentArr];
		[self.headerTitleArr addObject:@"全款购车"];
	}else{
		self.choosedProductsModel = self.choosedProductsModelArray[indexPath.row - 1];
		NSArray *tempArr = [self refreshDataWithChoosedProductsModel:self.choosedProductsModel];
		[self.transferArr addObject:tempArr];
		[self.headerTitleArr addObject:self.choosedProductsModel.productName];
	}
	[self.tableView reloadData];
}

-(NSArray *)refreshDataWithChoosedProductsModel:(LSChoosedProductsModel *)choosedProductsModel
{
	if (IS_STRING_EMPTY(self.choosedProductsModel.sf)) {
		self.choosedProductsModel.sf = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.bzj)) {
		self.choosedProductsModel.bzj = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.rzgm)) {
		self.choosedProductsModel.rzgm = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.lgj)) {
		self.choosedProductsModel.wk = @"-";
	}
	//if (IS_STRING_EMPTY(self.choosedProductsModel.interestrate)) {
	//	self.choosedProductsModel.interestrate = @"0";
	//}
	//if (IS_STRING_EMPTY(self.choosedProductsModel.lx)) {
	//	self.choosedProductsModel.lx = @"-";
	//}
	if (IS_STRING_EMPTY(self.choosedProductsModel.yg)) {
		self.choosedProductsModel.yg = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.dkfwf)) {
		self.choosedProductsModel.dkfwf = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.bmzzc)) {
		self.choosedProductsModel.bmzzc = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.cjrl)) {
		self.choosedProductsModel.cjrl = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.by)) {
		self.choosedProductsModel.by = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.snzjly)) {
		self.choosedProductsModel.snzjly = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.ntzhbl)) {
		self.choosedProductsModel.ntzhbl = @"0";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.tzhb)) {
		self.choosedProductsModel.tzhb = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.ncpi)) {
		self.choosedProductsModel.ncpi = @"0";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.nbz)) {
		self.choosedProductsModel.nbz = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.gskds)) {
		self.choosedProductsModel.gskds = @"-";
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.khsjgccb)) {
		self.choosedProductsModel.khsjgccb = @"-";
	}
	
	NSArray *tempArr = @[[self.choosedProductsModel.sf cut],
						 [self.choosedProductsModel.bzj cut],
						 [self.choosedProductsModel.rzgm cut],
						 [self.choosedProductsModel.lgj cut],
						 // [self.choosedProductsModel.interestrate stringByAppendingString:@"%"],
						 // self.choosedProductsModel.lx,
						 [[self.choosedProductsModel.yg cutOutStringContainsDot]cut],
						 [self.choosedProductsModel.dkfwf cut],
						 [self.choosedProductsModel.bmzzc cut],
						 [self.choosedProductsModel.cjrl cut],
						 [self.choosedProductsModel.by cut],
						 [self.choosedProductsModel.snzjly cut],
						 [[[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ntzhbl floatValue]*100]cutOutStringContainsDot]stringByAppendingString:@"%"],
						 [self.choosedProductsModel.tzhb cut],
						 [[[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ncpi floatValue]*100] cutOutStringContainsDot]stringByAppendingString:@"%"],
						 [self.choosedProductsModel.nbz cut],
						 [self.choosedProductsModel.gskds cut],
						 [self.choosedProductsModel.khsjgccb cut]];
	return tempArr;
}

-(void)clearDetailViewControllerSelectedProgram
{
	[self.headerTitleArr removeAllObjects];
	[self.transferArr removeAllObjects];
	[self.tableView reloadData];
}

#pragma mark - lazy load
-(NSArray *)titleArray
{
	if (!_titleArray) {
		_titleArray = [NSArray arrayWithObjects:@"首付",@"保证金",@"融资规模",@"尾款",@"月供",@"贷款服务费",@"表面总支出",@"车价让利",@"保养/精品赠送",@"三年资金利用", @"年投资回报率",@"投资回报",@"年CPI",@"年贬值",@"公司可抵税(仅融资租赁增加)",@"客户实际购车车本",nil];
	}
	return _titleArray;
}

-(NSArray *)fullPaymentArr
{
	if (!_fullPaymentArr) {
		_fullPaymentArr = [NSArray arrayWithObjects:self.fullPaymentRealPrice,@"-",@"-",@"-",@"-",@"-",self.fullPaymentRealPrice,@"-",@"-",@"-", @"-",@"-",@"-",@"-",@"-",self.fullPaymentRealPrice,nil];
	}
	return _fullPaymentArr;
}

-(NSMutableArray *)transferArr
{
	if (!_transferArr) {
		_transferArr = [NSMutableArray array];
	}
	return _transferArr;
}

-(NSMutableArray *)headerTitleArr
{
	if (!_headerTitleArr) {
		_headerTitleArr = [NSMutableArray array];
	}
	return _headerTitleArr;
}
@end
