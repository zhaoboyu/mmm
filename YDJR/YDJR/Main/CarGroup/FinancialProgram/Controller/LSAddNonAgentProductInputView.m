//
//  LSAddNonAgentProductInputView.m
//  YDJR
//
//  Created by 李爽 on 2016/12/21.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddNonAgentProductInputView.h"
#import "LSUniversalAlertView.h"
#import "LSAddNonAgentProductInputCollectionViewCell.h"
#import "LSFinancialProductsModel.h"
#import "CTTXRequestServer+LetterofIntent.h"
#import "LSChoosedProductsModel.h"
#import "DetailListCellPopView.h"
#import "LSAddNonAgentProductResultView.h"

#define CELL_ID      @"CELL_ID"
@interface LSAddNonAgentProductInputView ()<UICollectionViewDelegate,UICollectionViewDataSource,DetailListCellPopViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)UICollectionView *inputCollectionView;

/**
 字典编号
 */
@property (nonatomic,copy)NSString *productDict;
/**
 实际价格
 */
@property (nonatomic,copy)NSString *catModelDetailPrice;

/**
 是否选中融购置税按钮
 */
@property (nonatomic,assign,getter=isSelectGzsCheckButton) BOOL selectGzsCheckButton;
/**
 是否选中融保险按钮
 */
@property (nonatomic,assign,getter=isSelectBxCheckButton) BOOL selectBxCheckButton;

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
@property (nonatomic,strong)HGBPromgressHud *phud;

@property (nonatomic,copy)NSMutableArray *contextArr;
@property (nonatomic,copy)NSString *rzzlhgzsbzj;

@property (nonatomic,copy)NSMutableArray *materialModelArr;
@property (nonatomic,assign,getter=isChangeGzs)BOOL changeGzs;
@property (nonatomic,copy)NSMutableDictionary *dict;

/**
 右侧标题数组
 */
@property (nonatomic,strong)NSArray *rightTitlesArray;
/**
 右侧内容数组
 */
@property (nonatomic,strong)NSMutableArray *rightValuesArray;
@property (nonatomic,strong)UIButton *closeButton;

@property (nonatomic,strong)UIButton *countButton;
@property (nonatomic,strong)LSUniversalAlertView *universalAlertView;
@property (nonatomic,strong)UIView *universalAlertSubView;

@property (nonatomic,copy)NSString *retentionRatio;
/**
 除12、36外输入的费率
 */
@property (nonatomic,copy)NSString *inputFl;
@end

@implementation LSAddNonAgentProductInputView

- (instancetype)initWithFrame:(CGRect)frame productModel:(LSFinancialProductsModel *)productModel realPrice:(NSString *)actualPrice productDict:(NSString *)productDict
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

#pragma mark - obtainDataFromNet
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
		[self transitionWithType:@"rippleEffect" WithSubtype:@"kCATransitionFromLeft" ForView:self];
	} failedBlock:^(NSError *error) {
		[self.phud hideSave];
		self.phud.promptStr = @"网络状况不好...请稍后重试!";
		[self.phud showHUDResultAddedTo:self];
	}];
}

#pragma mark - p_setupView
- (void)p_setupView
{
	//[UIColor colorWithColor:[UIColor hexString:@"#FFFFFFFF"] alpha:0.3];
	UIView *universalAlertBackgroungView = [[UIView alloc]initWithFrame:CGRectMake(160 * wScale, 76 * hScale, 1728 * wScale, 1384 * hScale)];
	universalAlertBackgroungView.backgroundColor = [UIColor colorWithColor:[UIColor hexString:@"#FFFFFFFF"] alpha:0.3];
	LSUniversalAlertView *universalAlertView = [[LSUniversalAlertView alloc]initWithFrame:CGRectMake(176 * wScale, 92 * hScale, 1696 * wScale, 1352 * hScale)];
	[universalAlertView.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
	universalAlertView.titleLabel.text = @"添加金融方案";
	[universalAlertView.rightButton setTitle:@"计算方案" forState:UIControlStateNormal];
	if ([self.productsModel.productID isEqualToString:@"2"]) {
		if (kStringIsEmpty(self.productsModel.retentionRatio)) {
			[universalAlertView.rightButton setTitleColor:[UIColor hexString:@"#FF999999"]];
		}
	}
	[universalAlertView.closeButton addTarget:self action:@selector(closeTheAddNonAgentProductInputView) forControlEvents:UIControlEventTouchUpInside];
	self.closeButton = universalAlertView.closeButton;
	[universalAlertView.rightButton addTarget:self action:@selector(deselectCountButton) forControlEvents:UIControlEventTouchUpInside];
	self.countButton = universalAlertView.rightButton;
	[self addSubview:universalAlertBackgroungView];
	[self addSubview:universalAlertView];
	self.universalAlertView = universalAlertView;
	
	UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
	layOut.sectionInset = UIEdgeInsetsMake(24 * wScale, 32 * hScale, 24 * wScale, 32 * hScale);
	layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
	self.inputCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 98 * hScale, 1696 * wScale, 1256 * hScale) collectionViewLayout:layOut];
	self.inputCollectionView.delegate = self;
	self.inputCollectionView.dataSource = self;
	[self.inputCollectionView registerClass:[LSAddNonAgentProductInputCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
	self.inputCollectionView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
	
	UIView *grayStickView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1696 * wScale, 24 * hScale)];
	grayStickView.backgroundColor = [UIColor hexString:@"#FFF3F3F3"];
	[self.inputCollectionView addSubview:grayStickView];
	
	[universalAlertView addSubview:self.inputCollectionView];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	if ([self.productsModel.productID isEqualToString:@"2"]) {
		return 12;
	}else{
		return 13;
	}
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	[self refreshinputCollectionViewTitleAndInitContent];
	LSAddNonAgentProductInputCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
	cell.L_titleLabel.text = self.rightTitlesArray[indexPath.row];
	cell.L_contentTextField.text = self.rightValuesArray[indexPath.row];
	if (indexPath.row == 1 || indexPath.row == 2) {
		cell.L_contentTextField.enabled = NO;
		cell.selectBoxButton.hidden = NO;
		cell.selectBoxButton.tag = indexPath.row;
		if (indexPath.row == 1) {
			cell.selectBoxButton.selected = self.selectGzsCheckButton;
		}
		if (indexPath.row == 2) {
			cell.selectBoxButton.selected = self.selectBxCheckButton;
		}
		[cell.selectBoxButton addTarget:self action:@selector(deselectSelectBoxButton:) forControlEvents:UIControlEventTouchUpInside];
	}else{
		cell.L_contentTextField.enabled = YES;
		cell.selectBoxButton.hidden = YES;
	}
	if (indexPath.row == 6) {
		cell.loanYearButton.hidden = NO;
		[cell.loanYearButton setTitle:self.choosedProductsModel.qs forState:UIControlStateNormal];
		[cell.loanYearButton addTarget:self action:@selector(deselectLoanYearButton:) forControlEvents:UIControlEventTouchUpInside];
	}else{
		cell.loanYearButton.hidden = YES;
	}
	cell.L_contentTextField.delegate = self;
	cell.L_contentTextField.tag = indexPath.row;
	//if ([self.productsModel.productID isEqualToString:@"20"]||[self.productsModel.productID isEqualToString:@"23"]||[self.productsModel.productID isEqualToString:@"24"]) {
	//	cell.selectBoxButton.enabled = NO;
	//}else{
	//	cell.selectBoxButton.enabled = YES;
	//}
	cell.selectBoxButton.enabled = YES;
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake(384 * wScale,130 * hScale);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	
}

-(void)refreshinputCollectionViewTitleAndInitContent{
	if ([self.productsModel.productID isEqualToString:@"2"]) {
		self.rightTitlesArray = @[@"车价金额",@"购置税金额",@"保险金额",@"首付比例(%)",@"保证金比例(%)",@"留购比例(%)",@"期限",@"贷款服务费",@"车价让利",@"保养赠送",@"年投资回报率(%)",@"年CPI(%)"];
	}else{
		if ([self.choosedProductsModel.qs isEqualToString:@"12"]) {
			self.rightTitlesArray = @[@"车价金额",@"购置税金额",@"保险金额",@"首付比例(%)",@"保证金比例(%)",@"留购比例(%)",@"期限",@"手续费率(%)",@"贷款服务费",@"车价让利",@"保养赠送",@"年投资回报率(%)",@"年CPI(%)"];
		}else{
			self.rightTitlesArray = @[@"车价金额",@"购置税金额",@"保险金额",@"首付比例(%)",@"保证金比例(%)",@"留购比例(%)",@"期限",@"费率(%)",@"贷款服务费",@"车价让利",@"保养赠送",@"年投资回报率(%)",@"年CPI(%)"];
		}
	}
	
	if ([self.productsModel.productID isEqualToString:@"2"]) {
		self.rightValuesArray = [NSMutableArray arrayWithObjects:self.choosedProductsModel.cj,self.choosedProductsModel.gzs,self.choosedProductsModel.bx,self.productsModel.paymentradio,self.productsModel.marginradio,self.productsModel.retentionRatio,self.choosedProductsModel.qs,self.choosedProductsModel.dkfwf,self.choosedProductsModel.cjrl,self.choosedProductsModel.by,[[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ntzhbl floatValue] * 100] cutOutStringContainsDot],[[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ncpi floatValue] * 100] cutOutStringContainsDot],nil];
	}else{
		if ([self.choosedProductsModel.qs isEqualToString:@"12"]) {
			self.rightValuesArray = [NSMutableArray arrayWithObjects:self.choosedProductsModel.cj,self.choosedProductsModel.gzs,self.choosedProductsModel.bx,self.productsModel.paymentradio,self.productsModel.marginradio,self.productsModel.retentionRatio,self.choosedProductsModel.qs,[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.sxfl floatValue] * 100],self.choosedProductsModel.dkfwf,self.choosedProductsModel.cjrl,self.choosedProductsModel.by,[[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ntzhbl floatValue] * 100] cutOutStringContainsDot],[[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ncpi floatValue] * 100] cutOutStringContainsDot],nil];
		}else{
			if ([self.choosedProductsModel.qs isEqualToString:@"36"]){
				self.rightValuesArray = [NSMutableArray arrayWithObjects:self.choosedProductsModel.cj,self.choosedProductsModel.gzs,self.choosedProductsModel.bx,self.productsModel.paymentradio,self.productsModel.marginradio,self.productsModel.retentionRatio,self.choosedProductsModel.qs,[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.fl floatValue] * 100],self.choosedProductsModel.dkfwf,self.choosedProductsModel.cjrl,self.choosedProductsModel.by,[[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ntzhbl floatValue] * 100] cutOutStringContainsDot],[[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ncpi floatValue] * 100] cutOutStringContainsDot],nil];
			}else{
				self.rightValuesArray = [NSMutableArray arrayWithObjects:self.choosedProductsModel.cj,self.choosedProductsModel.gzs,self.choosedProductsModel.bx,self.productsModel.paymentradio,self.productsModel.marginradio,self.productsModel.retentionRatio,self.choosedProductsModel.qs,@"",self.choosedProductsModel.dkfwf,self.choosedProductsModel.cjrl,self.choosedProductsModel.by,[[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ntzhbl floatValue] * 100] cutOutStringContainsDot],[[NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ncpi floatValue] * 100] cutOutStringContainsDot],nil];
			}
		}
	}
}

#pragma mark - 是否融购置税或是保险的点击事件
-(void)deselectSelectBoxButton:(UIButton *)button
{
	button.selected = !button.selected;
	if (button.tag == 1) {
		self.selectGzsCheckButton = button.selected;
		//购置税
	}
	if (button.tag == 2) {
		self.selectBxCheckButton = button.selected;
		//保险
		self.bx = self.rightValuesArray[2];
	}
	[self.contextArr removeAllObjects];
	for (LSMaterialModel *m in self.materialModelArr) {
		[self calculationWithDictName:m];
	}
}

#pragma mark - 期数的点击事件
-(void)deselectLoanYearButton:(UIButton *)button
{
	button.selected = !button.selected;
	NSArray *tempArr = @[@"12",@"18",@"24",@"36",@"48",@"60"];
	CGRect originInSuperview = [self.inputCollectionView.window convertRect:button.bounds fromView:button];
	DetailListCellPopView *detailListCellPopView = [[DetailListCellPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds] ListFrame:originInSuperview listArr:tempArr isOtherTitle:NO];
	detailListCellPopView.delegate = self;
	[detailListCellPopView showPopView];
}

- (void)sendMessageWithMessage:(NSString *)messge
{
	self.productsModel.loanyear = messge;
	[self.contextArr removeAllObjects];
	for (LSMaterialModel *m in self.materialModelArr) {
		[self calculationWithDictName:m];
	}
	[self.inputCollectionView reloadData];
}

#pragma mark - textFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
	[self.rightValuesArray replaceObjectAtIndex:textField.tag withObject:textField.text];
	//LSAddNonAgentProductCustomView *customView = self.rightCustomViewsArray[textField.tag];
	//customView.contentTextField.text = textField.text;
	
	if (textField.tag == 0) {
		self.catModelDetailPrice = textField.text;
	}
	if (textField.tag == 1) {
		self.changeGzs = YES;
		self.gzs = textField.text;
	}
	if (textField.tag == 2) {
		self.bx = textField.text;
	}
	if (textField.tag == 3) {
		self.productsModel.paymentradio = textField.text;
	}
	if (textField.tag == 4) {
		self.productsModel.marginradio = textField.text;
	}
	if (textField.tag == 5) {
		self.retentionRatio = textField.text;
		self.productsModel.retentionRatio = textField.text;
		if ([self.productsModel.productID isEqualToString:@"2"]) {
			if (kStringIsEmpty(textField.text)) {
				[self.universalAlertView.rightButton setTitleColor:[UIColor hexString:@"#FF999999"]];
			}else{
				[self.universalAlertView.rightButton setTitleColor:[UIColor hexString:@"#FF000000"]];
			}
		}
	}
	if (![self.productsModel.productID isEqualToString:@"2"]) {
		if (textField.tag == 7) {
			if ([self.choosedProductsModel.qs isEqualToString:@"12"]) {
				self.productsModel.counterFeeRatio = textField.text;
			}else{
				self.productsModel.interestrate = textField.text;
				self.inputFl = textField.text;
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
}

#pragma mark - 关闭AddNonAgentProductInputView
-(void)closeTheAddNonAgentProductInputView
{
	if ([self.closeButton.titleLabel.text isEqualToString:@"关闭"]) {
		if (_delegate && ([_delegate respondsToSelector:@selector(removeAddNonAgentProductInputView)])) {
			[_delegate removeAddNonAgentProductInputView];
			[self removeFromSuperview];
		}else{
			[self removeFromSuperview];
		}
	} else {
		[self.universalAlertView sendSubviewToBack:self.universalAlertSubView];
		[self.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
		[self.countButton setTitle:@"计算方案" forState:UIControlStateNormal];
	}
}

#pragma mark - 计算方案的点击事件
-(void)deselectCountButton
{
	if ([self.countButton.titleLabel.text isEqualToString:@"计算方案"]) {
		[self.inputCollectionView endEditing:YES];
		if ([self.productsModel.productID isEqualToString:@"2"]) {
			if (kStringIsEmpty(self.productsModel.retentionRatio)) {
				if ([self.choosedProductsModel.lgbl isEqualToString:@"0"]) {
					return;
				}
			}
		}else{
			if (![self.productsModel.loanyear isEqualToString:@"12"]) {
				if ([self.productsModel.loanyear isEqualToString:@"36"]) {
					if (kStringIsEmpty(self.productsModel.interestrate)) {
						self.phud.promptStr = @"请输入费率";
						[self.phud showHUDResultAddedTo:self];
						return;
					}
				}else{
					if (kStringIsEmpty(self.inputFl)) {
						self.phud.promptStr = @"请输入费率";
						[self.phud showHUDResultAddedTo:self];
						return;
					}
				}
			}
		}
		LSAddNonAgentProductResultView *resultView = [[LSAddNonAgentProductResultView alloc]initWithFrame:CGRectMake(0, 98 * hScale, 1696 * wScale, 1256 * hScale) productModel:self.choosedProductsModel];
		[self.universalAlertView addSubview:resultView];
		self.universalAlertSubView = resultView;
		[self.closeButton setTitle:@"返回" forState:UIControlStateNormal];
		[self.countButton setTitle:@"确认方案" forState:UIControlStateNormal];
	} else {
		if (_delegate && ([_delegate respondsToSelector:@selector(removeAddProgramViewAfterAddNonAgentProductInputViewDisAppear)])) {
			[_delegate removeAddProgramViewAfterAddNonAgentProductInputViewDisAppear];
			[self removeFromSuperview];
		}
	}
}

#pragma mark - 计算
-(void)calculationWithDictName:(LSMaterialModel *)m
{
	if ([m.dictvalue isEqualToString:@"gzs"]) {
		if (self.isChangeGzs) {
			if (kStringIsEmpty(self.gzs)) {
				self.gzs = @"0";
			}
		}else{
			if (kStringIsEmpty(self.gzs)) {
				NSString *gzs = [self calculationWithAlgorithm:m.dictname];
				//NSLog(@"购置税%@",gzs);
				self.gzs = gzs;
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
	if ([m.dictvalue isEqualToString:@"bzj"]) {
		//NSString *bzj = [self calculationWithAlgorithm:m.dictname];
		//NSLog(@"保证金%@",bzj);
		NSString *tempString = @"";
		if (self.isSelectBxCheckButton && self.isSelectGzsCheckButton) {
			tempString = [m.dictname  stringByReplacingOccurrencesOfString:@"cj" withString:@"(,cj,+,gzs,+,bx,)"];
		}else if (self.isSelectBxCheckButton){
			tempString = [m.dictname  stringByReplacingOccurrencesOfString:@"cj" withString:@"(,cj,+,bx,)"];
		}else if (self.isSelectGzsCheckButton){
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
			self.yg = [NSString stringWithFormat:@"%.2f",[self pmtWithRate:[self.productsModel.interestRate1 doubleValue]/100 term:[self.productsModel.loanyear doubleValue] financeAmount:[yg doubleValue]]+[self.productsModel.interestRate2 doubleValue]/100 * [self.lgj doubleValue]/12];
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
	[dict setValue:self.rzgm forKey:@"rzgm"];
	[dict setValue:self.bzj forKey:@"bzj"];
	[dict setValue:self.gzs forKey:@"gzs"];
	[dict setValue:self.dkfwf forKey:@"dkfwf"];
	[dict setValue:self.bmzzc forKey:@"bmzzc"];
	[dict setValue:self.cjrl forKey:@"cjrl"];
	[dict setValue:self.by forKey:@"by"];
	[dict setValue:self.ntzhbl forKey:@"ntzhbl"];
	[dict setValue:self.tzhb forKey:@"tzhb"];
	[dict setValue:self.ncpi forKey:@"ncpi"];
	[dict setValue:self.nbz forKey:@"nbz"];
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
	
	if ([self.productsModel.productID isEqualToString:@"1"]||[self.productsModel.productID isEqualToString:@"21"]||[self.productsModel.productID isEqualToString:@"22"]) {
		[dict setValue:self.gskds forKey:@"gskds"];
	}else{
		[dict setValue:@"0" forKey:@"gskds"];
	}
	
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
			if ([self.productsModel.productID isEqualToString:@"2"]) {
				if ([tempStr isEqualToString:@"retentionRatio"]) {
					if (kStringIsEmpty(self.productsModel.retentionRatio)) {
						s = @"0";
					}
				}
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

#define DURATION 0.7f
#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
	//创建CATransition对象
	CATransition *animation = [CATransition animation];
	
	//设置运动时间
	animation.duration = DURATION;
	
	//设置运动type
	animation.type = type;
	if (subtype != nil) {
		
		//设置子类
		animation.subtype = subtype;
	}
	
	//设置运动速度
	animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
	
	[view.layer addAnimation:animation forKey:@"animation"];
}

#pragma UIView实现动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition
{
	[UIView animateWithDuration:DURATION animations:^{
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationTransition:transition forView:view cache:YES];
	}];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)strin
{
	return YES;
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
		_rightTitlesArray = [NSMutableArray array];
	}
	return _rightTitlesArray;
}

- (NSMutableArray *)rightValuesArray
{
	if (!_rightValuesArray) {
		_rightValuesArray = [NSMutableArray array];
	}
	return _rightValuesArray;
}

@end
