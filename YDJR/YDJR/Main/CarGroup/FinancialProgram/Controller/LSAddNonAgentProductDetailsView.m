//
//  LSAddNonAgentProductDetailsView.m
//  YDJR
//
//  Created by 李爽 on 2016/11/30.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddNonAgentProductDetailsView.h"
#import "LSTextField.h"
#import "LSAddNonAgentProductCustomView.h"
#import "LSAddNonAgentProductTableViewCell.h"
#import "LSAddNonAgentProductTableViewFooter.h"
#import "LSFinancialProductsModel.h"
#import "CTTXRequestServer+LetterofIntent.h"
#import "LSChoosedProductsModel.h"
#import "DetailListCellPopView.h"

#define CELL_ID      @"CELL_ID"
#define FOOTER_ID      @"FOOTER_ID"
@interface LSAddNonAgentProductDetailsView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,DetailListCellPopViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)HGBPromgressHud *phud;
@property (nonatomic,copy)NSString *productDict;
@property (nonatomic,copy)NSMutableArray *contextArr;
@property (nonatomic,copy)NSMutableArray *materialModelArr;
/**
 右侧标题数组
 */
@property (nonatomic,strong)NSArray *rightTitlesArray;
/**
 右侧内容数组
 */
@property (nonatomic,strong)NSMutableArray *rightValuesArray;
/**
 右侧customView数组
 */
@property (nonatomic,strong)NSMutableArray *rightCustomViewsArray;
/**
 左侧标题数组
 */
@property (nonatomic,strong)NSArray *leftTitlesArray;
/**
 白色背景
 */
@property (nonatomic, strong)UIView *backgroundView;

@property (nonatomic,copy)NSString *rzgm;/** 融资规模*/
@property (nonatomic,copy)NSString *gzs;/** 购置税*/

@property (nonatomic,copy)NSString *lx;/** 利息*/
@property (nonatomic,copy)NSString *sf;/** 首付*/
@property (nonatomic,copy)NSString *dkfwf;/** 贷款服务费*/

@property (nonatomic,copy)NSString *bmzzc;/** 表面总支出*/
@property (nonatomic,copy)NSString *ntzhbl;/** 年投资回报率*/
@property (nonatomic,copy)NSString *snzjly;/** 三年资金利用*/

@property (nonatomic,copy)NSString *ncpi;/** 年cpi*/
@property (nonatomic,copy)NSString *cjrl;/** 车价让利*/

@property (nonatomic,copy)NSString *tzhb;/** 投资回报*/
@property (nonatomic,copy)NSString *by;/** 保养*/
@property (nonatomic,copy)NSString *gskds;/** 公司可抵税*/

@property (nonatomic,copy)NSString *nbz;/** 年贬值*/
@property (nonatomic,copy)NSString *bzj;/** 保证金*/
@property (nonatomic,copy)NSString *yg;/** 月供*/

@property (nonatomic,copy)NSString *khsjgccb;/** 客户实际购车车本*/
@property (nonatomic,copy)NSString *bx;/** 保险金额*/
@property (nonatomic,copy)NSString *cz;/** 残值*/

@property (nonatomic,copy)NSString *qs;/** 期数*/
@property (nonatomic,copy)NSString *fl;/** 费率*/
@property (nonatomic,copy)NSString *sfbl;/** 首付比例*/

@property (nonatomic,copy)NSString *lgj;/** 留购价*/
@property (nonatomic,copy)NSString *lgbl;/** 留购比例*/

@property (nonatomic,copy)NSString *bzjbl;/** 保证金比例*/
@property (nonatomic,copy)NSString *sxfl;/** 手续费比例*/
@property (nonatomic,copy)NSString *sxf;/** 手续费*/

@property (nonatomic,copy)NSString *gccb;/** 购车成本*/
@property (nonatomic,copy)NSString *kpz;/** 抗膨胀*/
@property (nonatomic,copy)NSMutableDictionary *dict;

@property (nonatomic,assign,getter=isChangeGzs)BOOL changeGzs;
@property (nonatomic,assign,getter=isSelectGzsCheckButton) BOOL selectGzsCheckButton;

@property (nonatomic,assign,getter=isSelectBxCheckButton) BOOL selectBxCheckButton;
@property (nonatomic,copy)NSString *gzsString;
@property (nonatomic,copy)NSString *rzzlhgzsbzj;

@property (nonatomic,copy)NSString *rzzlhgzsrzgm;
@property (nonatomic,copy)NSString *kxcsnzjly;
@property (nonatomic,copy)NSString *kxclx;
@property (nonatomic,copy)NSString *kxcyg;
@end
@implementation LSAddNonAgentProductDetailsView

- (instancetype)initWithFrame:(CGRect)frame productModel:(id)productModel actualPrice:(NSString *)actualPrice productDict:(NSString *)productDict
{
	self = [super initWithFrame:frame];
	if (self) {
		self.productsModel = productModel;
		self.productDict = productDict;
		self.catModelDetailPrice = actualPrice;
		self.selectGzsCheckButton = self.productsModel.isGzsSelected;
		self.selectBxCheckButton = self.productsModel.isBxSelected;
		self.bx = self.productsModel.insurance;
		[self obtainDataFromNet];
	}
	return self;
}

/**
 从网络上获取数据
 */
-(void)obtainDataFromNet
{
	[self.phud showHUDSaveAddedTo:self];
	[[CTTXRequestServer shareInstance]checkMaterialWithDictitem:self.productDict WithType:100 SuccessBlock:^(NSMutableArray *materialModelArr) {
		[self.phud hideSave];
		self.materialModelArr = materialModelArr;
		for (LSMaterialModel *m in materialModelArr) {
			[self calculationWithDictName:m];
		}
		[self p_setupView];
	} failedBlock:^(NSError *error) {
		[self.phud hideSave];
		self.phud.promptStr = @"网络状况不好...请稍后重试!";
		[self.phud showHUDResultAddedTo:self];
	}];
}

#pragma mark - p_setupView
- (void)p_setupView
{
	self.backgroundColor = [UIColor hexString:@"#FFF0F1F5"];
	
	UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 24 * hScale, self.width, self.height - 24 * hScale)];
	//backgroundView.contentSize = backgroundView.bounds.size;
	backgroundView.backgroundColor = [UIColor whiteColor];
	
	self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 912 * wScale, self.height - 24 * hScale) style:UITableViewStylePlain];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.tableView registerClass:[LSAddNonAgentProductTableViewCell class] forCellReuseIdentifier:CELL_ID];
	[self.tableView registerClass:[LSAddNonAgentProductTableViewFooter class] forCellReuseIdentifier:FOOTER_ID];
	[backgroundView addSubview:self.tableView];
	
	UIView *cuttingLine = [[UIView alloc]initWithFrame:CGRectMake(912 * wScale, 0, 1 * wScale, backgroundView.height)];
	cuttingLine.backgroundColor = [UIColor hexString:@"#FFF0F1F5"];
	[backgroundView addSubview:cuttingLine];
	
	if ([self.productsModel.productID isEqualToString:@"2"]) {
		self.rightValuesArray = [NSMutableArray arrayWithObjects:self.choosedProductsModel.cj,self.choosedProductsModel.gzs,self.choosedProductsModel.bx,self.productsModel.paymentradio,self.productsModel.marginradio,self.productsModel.retentionRatio,self.choosedProductsModel.qs,self.choosedProductsModel.dkfwf,self.choosedProductsModel.cjrl,self.choosedProductsModel.by,[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ntzhbl floatValue] * 100],[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ncpi floatValue] * 100],nil];
	}else{
		if ([self.choosedProductsModel.qs isEqualToString:@"12"]) {
			self.rightValuesArray = [NSMutableArray arrayWithObjects:self.choosedProductsModel.cj,self.choosedProductsModel.gzs,self.choosedProductsModel.bx,self.productsModel.paymentradio,self.productsModel.marginradio,self.productsModel.retentionRatio,self.choosedProductsModel.qs,[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.sxfl floatValue] * 100],self.choosedProductsModel.dkfwf,self.choosedProductsModel.cjrl,self.choosedProductsModel.by,[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ntzhbl floatValue] * 100],[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ncpi floatValue] * 100],nil];
		}else{
			self.rightValuesArray = [NSMutableArray arrayWithObjects:self.choosedProductsModel.cj,self.choosedProductsModel.gzs,self.choosedProductsModel.bx,self.productsModel.paymentradio,self.productsModel.marginradio,self.productsModel.retentionRatio,self.choosedProductsModel.qs,[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.fl floatValue] * 100],self.choosedProductsModel.dkfwf,self.choosedProductsModel.cjrl,self.choosedProductsModel.by,[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ntzhbl floatValue] * 100],[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ncpi floatValue] * 100],nil];
		}
	}
	UIScrollView *rightBackgrondView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.width - 496 * wScale, 0, 496 * wScale, self.height - 24 * hScale)];
	rightBackgrondView.contentSize = CGSizeMake(496 * wScale, 132 *hScale * self.rightValuesArray.count + 24 * hScale);
	for (int i = 0; i < self.rightValuesArray.count; i ++) {
		LSAddNonAgentProductCustomView*customView = [[LSAddNonAgentProductCustomView alloc]initWithFrame:CGRectMake(0, 132 *hScale * i, 496 * wScale, 132 *hScale)];
		customView.L_TitleLable.text = self.rightTitlesArray[i];
		if (i == 6) {
			customView.periodsButton.hidden = NO;
			[customView.periodsButton setTitle:self.choosedProductsModel.qs forState:UIControlStateNormal];
			[customView.periodsButton addTarget:self action:@selector(deselectPeriodsButton:) forControlEvents:UIControlEventTouchUpInside];
		}else{
			customView.periodsButton.hidden = YES;
			if (i == 1 || i == 2) {
				customView.checkButton.hidden = NO;
				if (i == 1) {
					customView.checkButton.selected = self.productsModel.isGzsSelected;
				}
				if (i == 2) {
					customView.checkButton.selected = self.productsModel.isBxSelected;
				}
				customView.checkButton.tag = i;
				[customView.checkButton addTarget:self action:@selector(deselectCustomViewCheckButton:) forControlEvents:UIControlEventTouchUpInside];
			}
			customView.contentTextField.placeholder = @"请输入";
			customView.contentTextField.tag = i;
			customView.contentTextField.delegate = self;
			customView.contentTextField.text = self.rightValuesArray[i];
		}
		[self.rightCustomViewsArray addObject:customView];
		[rightBackgrondView addSubview:customView];
	}
	[backgroundView addSubview:rightBackgrondView];
	self.backgroundView = backgroundView;
	[self addSubview:backgroundView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 7;
	}else{
		return 6;
	}
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		LSAddNonAgentProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
		cell.L_TitleLable.text = self.leftTitlesArray[indexPath.section][indexPath.row];
		cell.L_ContentLable.textColor = [UIColor hexString:@"#FFFC5A5A"];
		if (indexPath.row == 0) {
			cell.L_DescLable.hidden = NO;
			cell.L_DescLable.text = @"表面支出";
			cell.L_ContentLable.text = self.choosedProductsModel.cj;
		}else{
			cell.L_DescLable.hidden = YES;
			if (indexPath.row == 1) {
				cell.L_ContentLable.text = [self.choosedProductsModel.gzs cut];
			}
			if (indexPath.row == 2) {
				//cell.L_ContentLable.text = [self.choosedProductsModel.bx cut];
				cell.L_ContentLable.text = self.rightValuesArray[2];
			}
			if (indexPath.row == 3) {
				cell.L_ContentLable.text = [self.choosedProductsModel.yg cut];
			}
			if (indexPath.row == 4) {
				cell.L_ContentLable.text = [self.choosedProductsModel.dkfwf cut];
			}
			if (indexPath.row == 5) {
				cell.L_ContentLable.text = [self.choosedProductsModel.qs cut];
			}
			if (indexPath.row == 6) {
				cell.L_ContentLable.text = [self.choosedProductsModel.lgj cut];
			}
		}
		return cell;
	}else{
		if (indexPath.row == 5) {
			LSAddNonAgentProductTableViewFooter *cell = [tableView dequeueReusableCellWithIdentifier:FOOTER_ID];
			cell.L_TitleLable.text = @"实际购车成本";
			cell.L_ContentLable.text = [self.choosedProductsModel.khsjgccb cut];
			return cell;
		}else{
			LSAddNonAgentProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
			cell.L_TitleLable.text = self.leftTitlesArray[indexPath.section][indexPath.row];
			//cell.L_ContentLable.text = @"305,328";
			cell.L_ContentLable.textColor = [UIColor hexString:@"#FF1DBA35"];
			if (indexPath.row == 0) {
				cell.L_DescLable.hidden = NO;
				cell.L_DescLable.text = @"政策优惠";
				cell.L_ContentLable.text = [self.choosedProductsModel.cjrl cut];
			}else{
				cell.L_DescLable.hidden = YES;
				if (indexPath.row == 1) {
					cell.L_ContentLable.text = [self.choosedProductsModel.by cut];
				}
				if (indexPath.row == 2) {
					cell.L_ContentLable.text = [self.choosedProductsModel.tzhb cut];
				}
				if (indexPath.row == 3) {
					cell.L_ContentLable.text = [self.choosedProductsModel.kpz cut];
				}
				if (indexPath.row == 4) {
					cell.L_ContentLable.text = [self.choosedProductsModel.gskds cut];
				}
			}
			return cell;
		}
	}
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 112 * hScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (section == 1) {
		return 16 *hScale;
	}else{
		return 0;
	}
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 16 * hScale)];
	view.backgroundColor = [UIColor hexString:@"#FFF0F1F5"];
	return view;
}

/**
 点击了期数按钮
 */
-(void)deselectPeriodsButton:(UIButton *)button
{
	NSArray *tempArr = @[@"12",@"18",@"24",@"36",@"48",@"60"];
	CGRect originInSuperview = [self.backgroundView.window convertRect:button.bounds fromView:button];
	DetailListCellPopView *detailListCellPopView = [[DetailListCellPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds] ListFrame:originInSuperview listArr:tempArr isOtherTitle:NO];
	detailListCellPopView.delegate = self;
	[detailListCellPopView showPopView];
}

- (void)sendMessageWithMessage:(NSString *)messge
{
	LSAddNonAgentProductCustomView *customView = self.rightCustomViewsArray[6];
	LSAddNonAgentProductCustomView *flView = self.rightCustomViewsArray[7];
	if (![self.productsModel.productID isEqualToString:@"2"]) {
		if ([messge isEqualToString:@"12"]) {
			flView.L_TitleLable.text = @"手续费率(%)";
			flView.contentTextField.text =  self.productsModel.counterFeeRatio;
		}else{
			flView.L_TitleLable.text = @"费率(%)";
			flView.contentTextField.text =  self.productsModel.interestrate;
		}
	}
	[customView.periodsButton setTitle:messge forState:UIControlStateNormal];
	[self.rightValuesArray replaceObjectAtIndex:6 withObject:messge];
	
	self.productsModel.loanyear = messge;
	[self.contextArr removeAllObjects];
	for (LSMaterialModel *m in self.materialModelArr) {
		[self calculationWithDictName:m];
	}
	[self.tableView reloadData];
}

-(void)deselectCustomViewCheckButton:(UIButton *)button
{
	if (button.tag == 1) {
		self.selectGzsCheckButton = button.selected;
		//self.choosedProductsModel.isGzsSelected = button.selected;
		//购置税
		//if (button.selected) {
		//	self.gzs = self.rightValuesArray[1];
		//}else{
		//	self.gzs = @"0";
		//}
	}
	if (button.tag == 2) {
		self.selectBxCheckButton = button.selected;
		//self.choosedProductsModel.isBxSelected = button.selected;
		//保险
		self.bx = self.rightValuesArray[2];
		//		if (button.selected) {
		//			self.bx = self.rightValuesArray[2];
		//		}else{
		//			self.bx = @"0";
		//		}
	}
	[self.contextArr removeAllObjects];
	for (LSMaterialModel *m in self.materialModelArr) {
		[self calculationWithDictName:m];
	}
	[self.tableView reloadData];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
	[self.rightValuesArray replaceObjectAtIndex:textField.tag withObject:textField.text];
	LSAddNonAgentProductCustomView *customView = self.rightCustomViewsArray[textField.tag];
	customView.contentTextField.text = textField.text;
	
	if (textField.tag == 0) {
		self.catModelDetailPrice = textField.text;
	}
	if (textField.tag == 1) {
		self.changeGzs = YES;
		//if (self.isSelectGzsCheckButton) {
		//	self.gzs = textField.text;
		//}
		//self.gzsString = textField.text;
		self.gzs = textField.text;
	}
	if (textField.tag == 2) {
		//if (self.isSelectBxCheckButton) {
		self.bx = textField.text;
		//}
	}
	if (textField.tag == 3) {
		self.productsModel.paymentradio = textField.text;
	}
	if (textField.tag == 4) {
		self.productsModel.marginradio = textField.text;
	}
	if (textField.tag == 5) {
		self.productsModel.retentionRatio = textField.text;
	}
	if (![self.productsModel.productID isEqualToString:@"2"]) {
		if (textField.tag == 7) {
			if ([self.choosedProductsModel.qs isEqualToString:@"12"]) {
				self.productsModel.counterFeeRatio = textField.text;
			}else{
				self.productsModel.interestrate = textField.text;
			}
		}
		if (textField.tag == 8) {
			self.productsModel.servicecharge = textField.text;
		}
		if (textField.tag == 9) {
			self.productsModel.carlet = textField.text;
		}
		if (textField.tag == 10) {
			self.productsModel.cargive = textField.text;
		}
		if (textField.tag == 11) {
			self.productsModel.investret = textField.text;
		}
		if (textField.tag == 12) {
			self.productsModel.cpi = textField.text;
		}
	}else{
		//if (textField.tag == 7) {
		//	if ([self.choosedProductsModel.qs isEqualToString:@"12"]) {
		//		self.productsModel.interestrate = textField.text;
		//	}else{
		//		self.productsModel.counterFeeRatio = textField.text;
		//	}
		//}
		if (textField.tag == 7) {
			self.productsModel.servicecharge = textField.text;
		}
		if (textField.tag == 8) {
			self.productsModel.carlet = textField.text;
		}
		if (textField.tag == 9) {
			self.productsModel.cargive = textField.text;
		}
		if (textField.tag == 10) {
			self.productsModel.investret = textField.text;
		}
		if (textField.tag == 11) {
			self.productsModel.cpi = textField.text;
		}
	}
	[self.contextArr removeAllObjects];
	for (LSMaterialModel *m in self.materialModelArr) {
		[self calculationWithDictName:m];
	}
	[self.tableView reloadData];
}

#pragma mark - 计算
-(void)calculationWithDictName:(LSMaterialModel *)m
{
	if ([m.dictvalue isEqualToString:@"gzs"]) {
		//if (self.isChangeGzs) {
		//	if (kStringIsEmpty(self.gzs)) {
		//		self.gzs = @"0";
		//	}
		//}else{
		//	if (kStringIsEmpty(self.gzs)) {
		//		NSString *gzs = [self calculationWithAlgorithm:m.dictname];
		//		//NSLog(@"购置税%@",gzs);
		//		self.gzsString = gzs;
		//		self.gzs = gzs;
		//		if (!self.isSelectGzsCheckButton) {
		//			self.gzs = @"0";
		//		}
		//	}
		//}
		if (self.isChangeGzs) {
			if (kStringIsEmpty(self.gzs)) {
				self.gzs = @"0";
			}
		}else{
			if (kStringIsEmpty(self.gzs)) {
				NSString *gzs = [self calculationWithAlgorithm:m.dictname];
				//NSLog(@"购置税%@",gzs);
				self.gzs = gzs;
				//if (!self.isSelectGzsCheckButton) {
				//	self.gzs = @"0";
				//}
			}
		}
		[self.contextArr addObject:self.gzs];
	}
	if ([m.dictvalue isEqualToString:@"bx"]) {
		if (kStringIsEmpty(self.bx)) {
			NSString *bx = [self calculationWithAlgorithm:m.dictname];
			//NSLog(@"保险%@",bx);
			self.bx = bx;
		}
		[self.contextArr addObject:self.bx];
	}
	if ([m.dictvalue isEqualToString:@"sf"]) {
		NSString *sf = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"首付%@",sf);
		self.sf = sf;
		[self.contextArr addObject:sf];
	}
	//	if ([m.dictvalue isEqualToString:@"rzzlhgzsbzj"]) {
	//		NSString *rzzlhgzsbzj = [self calculationWithAlgorithm:m.dictname];
	//		//NSLog(@"保证金%@",bzj);
	//		self.rzzlhgzsbzj = rzzlhgzsbzj;
	//		[self.contextArr addObject:rzzlhgzsbzj];
	//	}
	//	if ([m.dictvalue isEqualToString:@"rzzlhgzsrzgm"]) {
	//		NSString *tempString = @"";
	//		if (self.isSelectBxCheckButton) {
	//			tempString = [m.dictname stringByAppendingString:@",+,bx"];
	//		}else{
	//			tempString = m.dictname;
	//		}
	//		NSString *rzzlhgzsrzgm = [self calculationWithAlgorithm:tempString];
	//		//NSLog(@"融资规模%@",rzgm);
	//		self.rzzlhgzsrzgm = rzzlhgzsrzgm;
	//		[self.contextArr addObject:rzzlhgzsrzgm];
	//	}
	if ([m.dictvalue isEqualToString:@"bzj"]) {
		//NSString *bzj = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"保证金%@",bzj);
		NSString *tempString = @"";
		if (self.isSelectGzsCheckButton){
			tempString = [m.dictname  stringByReplacingOccurrencesOfString:@"cj" withString:@"(,cj,+,gzs,)"];
		}else{
			tempString = m.dictname;
		}
		NSString *bzj = [self calculationWithAlgorithm:tempString];
		self.bzj = bzj;
		[self.contextArr addObject:bzj];
	}
	if ([m.dictvalue isEqualToString:@"rzgm"]) {
		//NSString *tempString = [m.dictname stringByAppendingString:@",+,bx"];
		NSString *tempString = @"";
		if (self.isSelectBxCheckButton && self.isSelectGzsCheckButton) {
			tempString = [m.dictname stringByAppendingString:@",+,bx"];
			tempString = [tempString stringByReplacingOccurrencesOfString:@"cj" withString:@"(,cj,+,gzs,)"];
		}else if (self.isSelectBxCheckButton){
			tempString = [m.dictname stringByAppendingString:@",+,bx"];
		}else if (self.isSelectGzsCheckButton){
			tempString = [m.dictname  stringByReplacingOccurrencesOfString:@"cj" withString:@"(,cj,+,gzs,)"];
		}else{
			tempString = m.dictname;
		}
		NSString *rzgm = [self calculationWithAlgorithm:tempString];
		//NSLog(@"融资规模%@",rzgm);
		self.rzgm = rzgm;
		[self.contextArr addObject:rzgm];
	}
	if ([m.dictvalue isEqualToString:@"bzjbl"]) {
		NSString *bzjbl = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"保证金比例%@",bzj);
		self.bzjbl = bzjbl;
		[self.contextArr addObject:bzjbl];
	}
	if ([m.dictvalue isEqualToString:@"fl"]) {
		NSString *fl = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"费率%@",fl);
		self.fl = fl;
		[self.contextArr addObject:fl];
	}
	if ([m.dictvalue isEqualToString:@"lx"]) {
		NSString *lx = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"利息%@",lx);
		self.lx = lx;
		[self.contextArr addObject:lx];
	}
	if ([m.dictvalue isEqualToString:@"yg"]) {
		NSString *yg = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"月供%@",yg);
		if ([self.productsModel.productID isEqualToString:@"2"]) {
			self.yg = [NSString stringWithFormat:@"%.2f",[self pmtWithRate:[self.productsModel.interestRate1 doubleValue]/100 term:[self.productsModel.loanyear doubleValue] financeAmount:[yg doubleValue]]+[self pmtWithRate:[self.productsModel.interestRate2 doubleValue]/100  term:[self.productsModel.loanyear doubleValue] financeAmount:[self.lgj doubleValue]]];
		}else{
			self.yg = yg;
		}
		[self.contextArr addObject:yg];
	}
	if ([m.dictvalue isEqualToString:@"dkfwf"]) {
		NSString *dkfwf = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"贷款服务费%@",dkfwf);
		self.dkfwf = dkfwf;
		[self.contextArr addObject:dkfwf];
	}
	if ([m.dictvalue isEqualToString:@"bmzzc"]) {
		NSString *bmzzc = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"表面总支出%@",bmzzc);
		self.bmzzc = bmzzc;
		[self.contextArr addObject:bmzzc];
	}
	
	if ([m.dictvalue isEqualToString:@"cjrl"]) {
		NSString *cjrl = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"车价让利%@",cjrl);
		self.cjrl = cjrl;
		[self.contextArr addObject:cjrl];
	}
	if ([m.dictvalue isEqualToString:@"by"]) {
		NSString *by = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"保养精品赠送%@",by);
		self.by = by;
		[self.contextArr addObject:by];
	}
	if ([m.dictvalue isEqualToString:@"snzjly"]) {
		NSString *snzjly = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"三年资金利用%@",snzjly);
		self.snzjly = snzjly;
		[self.contextArr addObject:snzjly];
	}
	if ([m.dictvalue isEqualToString:@"ntzhbl"]) {
		NSString *ntzhbl = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"年投资回报率%@",ntzhbl);
		self.ntzhbl = ntzhbl;
		[self.contextArr addObject:ntzhbl];
	}
	if ([m.dictvalue isEqualToString:@"tzhb"]) {
		NSString *tzhb = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"投资回报%@",tzhb);
		self.tzhb = tzhb;
		[self.contextArr addObject:tzhb];
	}
	if ([m.dictvalue isEqualToString:@"ntzhbl"]) {
		NSString *ntzhbl = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"年投资回报率%@",tzhb);
		self.ntzhbl = ntzhbl;
		[self.contextArr addObject:ntzhbl];
	}
	if ([m.dictvalue isEqualToString:@"ncpi"]) {
		NSString *ncpi = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"年cpi%@",ncpi);
		self.ncpi = ncpi;
		[self.contextArr addObject:ncpi];
	}
	if ([m.dictvalue isEqualToString:@"nbz"]) {
		NSString *nbz = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"年贬值%@",nbz);//snzjly,*,ncpi,*,loanyear,/,12
		self.nbz = nbz;
		[self.contextArr addObject:nbz];
	}
	if ([m.dictvalue isEqualToString:@"gskds"]) {
		NSString *gskds = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"公司可抵税%@",gskds);
		self.gskds = gskds;
		[self.contextArr addObject:gskds];
	}
	if ([m.dictvalue isEqualToString:@"qs"]) {
		NSString *qs = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"期数%@",khrhcsjzc);
		self.qs = qs;
		[self.contextArr addObject:qs];
	}
	if ([m.dictvalue isEqualToString:@"sfbl"]) {
		NSString *sfbl = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"首付比例%@",sfbl);
		self.sfbl = sfbl;
		[self.contextArr addObject:sfbl];
	}
	if ([m.dictvalue isEqualToString:@"lgj"]) {
		NSString *lgj = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"首付比例%@",lgj);
		self.lgj = lgj;
		[self.contextArr addObject:lgj];
	}
	if ([m.dictvalue isEqualToString:@"lgbl"]) {
		NSString *lgbl = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"留购比例%@",lgj);
		self.lgbl = lgbl;
		[self.contextArr addObject:lgbl];
	}
	if ([m.dictvalue isEqualToString:@"sxfl"]) {
		NSString *sxfl = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"手续费比例%@",lgj);
		self.sxfl = sxfl;
		[self.contextArr addObject:sxfl];
	}
	if ([m.dictvalue isEqualToString:@"sxf"]) {
		NSString *sxf = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"手续费%@",lgj);
		self.sxf = sxf;
		[self.contextArr addObject:sxf];
	}
	if ([m.dictvalue isEqualToString:@"gccb"]) {
		NSString *gccb = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"购车成本%@",lgj);
		self.gccb = gccb;
		[self.contextArr addObject:gccb];
	}
	if ([m.dictvalue isEqualToString:@"khsjgccb"]) {
		NSString *khsjgccb = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"客户实际购车车本%@",khsjgccb);
		self.khsjgccb = khsjgccb;
		[self.contextArr addObject:khsjgccb];
	}
	if ([m.dictvalue isEqualToString:@"kpz"]) {
		NSString *kpz = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"抗膨胀%@",lgj);
		self.kpz = kpz;
		[self.contextArr addObject:kpz];
	}
	if ([m.dictvalue isEqualToString:@"rzzlhgzsbzj"]) {
		NSString *rzzlhgzsbzj = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"保证金%@",bzj);
		self.rzzlhgzsbzj = rzzlhgzsbzj;
		[self.contextArr addObject:rzzlhgzsbzj];
	}
}

-(NSString *)calculationWithAlgorithm:(NSString *)algorithm
{
	NSMutableDictionary *dict = [self.productsModel yy_modelToJSONObject];
	
	[dict setValue:self.catModelDetailPrice forKey:@"cj"];
	[dict setValue:self.sf forKey:@"sf"];
	//	if (self.isSelectGzsCheckButton) {
	//		if ([self.productsModel.productName containsString:@"融资租赁"]||[self.productsModel.productName containsString:@"开心车"]) {
	//			[dict setValue:self.rzzlhgzsrzgm forKey:@"rzgm"];
	//			[dict setValue:self.rzzlhgzsbzj forKey:@"bzj"];
	//		} else {
	//			[dict setValue:self.rzgm forKey:@"rzgm"];
	//			[dict setValue:self.bzj forKey:@"bzj"];
	//		}
	//}else{
	[dict setValue:self.rzgm forKey:@"rzgm"];
	[dict setValue:self.bzj forKey:@"bzj"];
	//}
	[dict setValue:self.gzs forKey:@"gzs"];
	[dict setValue:self.dkfwf forKey:@"dkfwf"];
	[dict setValue:self.bmzzc forKey:@"bmzzc"];
	[dict setValue:self.cjrl forKey:@"cjrl"];
	[dict setValue:self.by forKey:@"by"];
	[dict setValue:self.ntzhbl forKey:@"ntzhbl"];
	[dict setValue:self.tzhb forKey:@"tzhb"];
	[dict setValue:self.ncpi forKey:@"ncpi"];
	[dict setValue:self.nbz forKey:@"nbz"];
	if ([self.productsModel.productName containsString:@"融资租赁"]) {
		[dict setValue:self.gskds forKey:@"gskds"];
	}else{
		[dict setValue:@"0" forKey:@"gskds"];
	}
	[dict setValue:self.bx forKey:@"bx"];
	[dict setValue:self.qs forKey:@"qs"];
	[dict setValue:self.fl forKey:@"fl"];
	[dict setValue:self.sfbl forKey:@"sfbl"];
	[dict setValue:self.lgj forKey:@"lgj"];
	[dict setValue:self.lgbl forKey:@"lgbl"];
	[dict setValue:self.bzjbl forKey:@"bzjbl"];
	[dict setValue:self.sxfl forKey:@"sxfl"];
	[dict setValue:self.sxf forKey:@"sxf"];
	[dict setValue:self.gccb forKey:@"gccb"];
	[dict setValue:self.kpz forKey:@"kpz"];
	[dict setValue:self.khsjgccb forKey:@"khsjgccb"];
	if (self.selectGzsCheckButton) {
		[dict setValue:@"1" forKey:@"isGzsSelected"];
	}else{
		[dict setValue:@"0" forKey:@"isGzsSelected"];
	}
	if (self.selectBxCheckButton) {
		[dict setValue:@"1" forKey:@"isBxSelected"];
	}else{
		[dict setValue:@"0" forKey:@"isBxSelected"];
	}
	
	[dict setValue:self.yg forKey:@"yg"];
	[dict setValue:self.lx forKey:@"lx"];
	[dict setValue:self.snzjly forKey:@"snzjly"];
	self.dict = dict;
	
	NSArray *transferArr=[algorithm componentsSeparatedByString:@","];
	NSString *newAlgorithmstr=@"";
	for(NSString *tempStr in transferArr){
		if ([tempStr isEqualToString:@"0"]) {
			newAlgorithmstr = tempStr;
		}else{
			NSString *s=[dict objectForKey:tempStr];
			if ([tempStr isEqualToString:@"paymentradio"]||[tempStr isEqualToString:@"marginradio"]||[tempStr isEqualToString:@"interestrate"]||[tempStr isEqualToString:@"investret"]||[tempStr isEqualToString:@"cpi"]||[tempStr isEqualToString:@"residualrate"]||[tempStr isEqualToString:@"retentionRatio"]) {//retentionRatio
				s = [NSString stringWithFormat:@"%.4f",[s floatValue]/100];
			}
			if(s!=nil&&s.length!=0){
				newAlgorithmstr=[newAlgorithmstr stringByAppendingFormat:@"%@",s];
			}
			else{
				newAlgorithmstr=[newAlgorithmstr stringByAppendingFormat:@"%@",tempStr];
			}
		}
	}
	NSLog(@"gsh=%@",newAlgorithmstr);
	NSString *str= [[[UIWebView alloc]init]stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"eval(%@)",newAlgorithmstr]];
	self.choosedProductsModel = [LSChoosedProductsModel yy_modelWithDictionary:self.dict];
	self.choosedProductsModel.productState = self.productsModel.productState;
	self.choosedProductsModel.intentID = self.productDict;
	self.choosedProductsModel.mechanismID = self.productsModel.mechanismID;
	self.choosedProductsModel.productCode = self.productsModel.productCode;
	self.choosedProductsModel.dataDictP = self.productsModel.dataDictP;
	self.choosedProductsModel.dataDictQ = self.productsModel.dataDictQ;
	self.choosedProductsModel.inputPrice = self.catModelDetailPrice;
	if ([str floatValue] < 1) {
		return [str cutOutStringContainsDotSupplement];
	}else{
		return [str cutOutStringContainsDot];
	}
}

- (double)pmtWithRate:(double)rate term:(double)term financeAmount:(double)financeAmount
{
	double v = (1+(rate/12));
	double t = (-(term/12)*12);
	double result=(financeAmount*(rate/12))/(1-pow(v, t));
	return result;
}

#pragma mark - lazy load
-(HGBPromgressHud *)phud
{
	if(_phud == nil){
		_phud = [[HGBPromgressHud alloc]init];
	}
	return _phud;
}

-(NSMutableArray *)contextArr
{
	if (!_contextArr) {
		_contextArr = [NSMutableArray array];
	}
	return _contextArr;
}

- (NSArray *)rightTitlesArray
{
	if (!_rightTitlesArray) {
		if ([self.productsModel.productID isEqualToString:@"2"]) {
			_rightTitlesArray = @[@"车价金额",@"购置税金额",@"保险金额",@"首付比例(%)",@"保证金比例(%)",@"留购比例(%)",@"期限",@"贷款服务费",@"车价让利",@"保养赠送",@"年投资回报率(%)",@"年CPI(%)"];
		}else{
			if ([self.choosedProductsModel.qs isEqualToString:@"12"]) {
				_rightTitlesArray = @[@"车价金额",@"购置税金额",@"保险金额",@"首付比例(%)",@"保证金比例(%)",@"留购比例(%)",@"期限",@"手续费率(%)",@"贷款服务费",@"车价让利",@"保养赠送",@"年投资回报率(%)",@"年CPI(%)"];
			}else{
				_rightTitlesArray = @[@"车价金额",@"购置税金额",@"保险金额",@"首付比例(%)",@"保证金比例(%)",@"留购比例(%)",@"期限",@"费率(%)",@"贷款服务费",@"车价让利",@"保养赠送",@"年投资回报率(%)",@"年CPI(%)"];
			}
		}
	}
	return _rightTitlesArray;
}

- (NSArray *)leftTitlesArray
{
	if (!_leftTitlesArray) {
		_leftTitlesArray = @[@[@"车价:",@"购置税:",@"保险:",@"月供:",@"贷款服务费:",@"期数:",@"留购价:"],@[@"车价让利:",@"保养赠送:",@"投资回报:",@"抗通货膨胀:",@"抵稅:"]];
	}
	return _leftTitlesArray;
}

- (NSMutableArray *)rightValuesArray
{
	if (!_rightValuesArray) {
		_rightValuesArray = [NSMutableArray array];
	}
	return _rightValuesArray;
}

- (NSMutableArray *)rightCustomViewsArray
{
	if (!_rightCustomViewsArray) {
		_rightCustomViewsArray = [NSMutableArray array];
	}
	return _rightCustomViewsArray;
}
@end
