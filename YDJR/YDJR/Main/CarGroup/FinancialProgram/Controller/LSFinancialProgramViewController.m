//
//  LSFinancialProgramViewController.m
//  YDJR
//
//  Created by 李爽 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFinancialProgramViewController.h"
#import "LSFinancialProgramCollectionViewCell.h"
#import "LSAddProgramViewController.h"
#import "LSVSFinancialProgramViewController.h"
#import "LLFCarModel.h"
#import "LSChoosedProductsModel.h"
#import "LSFinancialProductsModel.h"
#import "LSTextField.h"
#import "LSUniversalAlertView.h"
#import "LSAgentProductsTemplateModel.h"
#import "UIAlertController+HCAdd.h"
#import "LSAddNonAgentProductInputView.h"
#import "CTTXRequestServer+uploadContract.h"

#define CELL_ID      @"CELL_ID"
@interface LSFinancialProgramViewController ()<LSAddProgramViewDelegate,UITextFieldDelegate,LSAddNonAgentProductInputViewDelegate>
@property (nonatomic,strong)UIView *rightSideBarBgView;
@property (nonatomic,strong)UIView *rightSidebar;//右侧边栏

@property (nonatomic,strong)UIButton *addFinancialProgramBtn;//添加金融方案按钮
@property (nonatomic,strong)UIButton *vsFinancialProgramBtn;//对比金融方案按钮
@property (nonatomic,strong)UIButton *deleteFinancialProgramBtn;//删除金融方案按钮

@property (nonatomic,assign)int numberOfRows;
@property (nonatomic,strong)LSChoosedProductsModel *choosedProductsModel;
@property (nonatomic,assign)NSInteger selectedProgramTag;
/**
 选中的金融产品按钮tag
 */
@property (nonatomic,assign)NSInteger selectedProductTag;
@property (nonatomic,strong)UIView *backgroundView;
@property (nonatomic,assign)NSInteger editButtonTag;
@property (nonatomic)BOOL isNeedReload;
@property (nonatomic, strong) LSFinancialProductsModel *productsModel;
@property (nonatomic)BOOL isNeedStop;
/**
 编辑提示框
 */
@property (nonatomic, strong)UIAlertController *editAlertController;
/**
 自营产品详情View
 */
@property (nonatomic,strong) LSAddNonAgentProductInputView *inputView ;
/**
 是否删除金融方案
 */
@property (nonatomic)BOOL isNeedDelete;
@property (nonatomic,copy) NSString *fullPaymentRealPrice;
@property (nonatomic,strong)NSArray *ProductsBGImageNameArr;
@end;
@implementation LSFinancialProgramViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self p_setupView];
	self.numberOfRows = 2;
}

#pragma mark - p_setupView
- (void)p_setupView
{
	self.suggestedRetailPriceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 48 * hScale, 168 * wScale, 24 *hScale)];
	self.suggestedRetailPriceTitleLabel.text = @"建议零售价(元)";
	self.suggestedRetailPriceTitleLabel.font = [UIFont systemFontOfSize:12];
	self.suggestedRetailPriceTitleLabel.textColor = [UIColor hexString:@"#FFBFBFBF"];
	[self.view addSubview:self.suggestedRetailPriceTitleLabel];
	
	self.suggestedRetailPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(self.suggestedRetailPriceTitleLabel.frame) + 24 * hScale, 512 * wScale, 40 * hScale)];
	self.suggestedRetailPriceLabel.text = [[self.carModel.catModelDetailPrice cutOutStringContainsDot]cut];
	self.suggestedRetailPriceLabel.font = [UIFont systemFontOfSize:22];
	self.suggestedRetailPriceLabel.textColor = [UIColor hexString:@"#FF333333"];
	[self.view addSubview:self.suggestedRetailPriceLabel];
	
	self.realPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(512 * wScale, 48 * hScale, 168 * wScale, 24 * hScale)];
	self.realPriceLabel.text = @"实际价格";
	self.realPriceLabel.font = [UIFont systemFontOfSize:12];
	self.realPriceLabel.textColor = [UIColor hexString:@"#FFBFBFBF"];
	[self.view addSubview:self.realPriceLabel];
	
	self.realPriceInputTextField = [[LSTextField alloc]initWithFrame:CGRectMake(self.realPriceLabel.frame.origin.x, CGRectGetMaxY(self.realPriceLabel.frame) + 12 * hScale, 512 * wScale, 64 * hScale)];
	self.realPriceInputTextField.placeholder = @"0";
	self.realPriceInputTextField.keyboardType = UIKeyboardTypeNumberPad;
	self.realPriceInputTextField.font = [UIFont systemFontOfSize:22];
	self.realPriceInputTextField.backgroundColor = [UIColor clearColor];
	self.realPriceInputTextField.delegate = self;
	self.realPriceInputTextField.tag = 111;
	[self.view addSubview:self.realPriceInputTextField];
	
	UIView *textfieldBottomLine = [[UIView alloc]initWithFrame:CGRectMake(self.realPriceLabel.frame.origin.x, CGRectGetMaxY(self.realPriceInputTextField.frame) + 8 * hScale, 448 * wScale, 1 * hScale)];
	textfieldBottomLine.backgroundColor = [UIColor hexString:@"#FFD9D9D9"];
	[self.view addSubview:textfieldBottomLine];
	//购置税
	self.gzsLabel = [[UILabel alloc]initWithFrame:CGRectMake(1024 * wScale, 48 * hScale, 168 * wScale, 24 * hScale)];
	self.gzsLabel.text = @"购置税";
	self.gzsLabel.font = [UIFont systemFontOfSize:12];
	self.gzsLabel.textColor = [UIColor hexString:@"#FFBFBFBF"];
	[self.view addSubview:self.gzsLabel];
	
	self.gzsInputTextField = [[LSTextField alloc]initWithFrame:CGRectMake(1024 * wScale, CGRectGetMaxY(self.realPriceLabel.frame) + 12 * hScale, 512 * wScale, 64 * hScale)];
	self.gzsInputTextField.placeholder = @"0";
	self.gzsInputTextField.text = self.purchaseTax;
	self.gzsInputTextField.keyboardType = UIKeyboardTypeNumberPad;
	self.gzsInputTextField.font = [UIFont systemFontOfSize:22];
	self.gzsInputTextField.backgroundColor = [UIColor clearColor];
	self.gzsInputTextField.delegate = self;
	self.gzsInputTextField.tag = 112;
	[self.view addSubview:self.gzsInputTextField];
	
	UIView *gzsTextfieldBottomLine = [[UIView alloc]initWithFrame:CGRectMake(self.gzsLabel.frame.origin.x, CGRectGetMaxY(self.gzsInputTextField.frame) + 8 * hScale, 448 * wScale, 1 * hScale)];
	gzsTextfieldBottomLine.backgroundColor = [UIColor hexString:@"#FFD9D9D9"];
	[self.view addSubview:gzsTextfieldBottomLine];
	//保险
	self.bxLabel = [[UILabel alloc]initWithFrame:CGRectMake(1536 * wScale, 48 * hScale, 168 * wScale, 24 * hScale)];
	self.bxLabel.text = @"保险";
	self.bxLabel.font = [UIFont systemFontOfSize:12];
	self.bxLabel.textColor = [UIColor hexString:@"#FFBFBFBF"];
	[self.view addSubview:self.bxLabel];
	
	self.bxInputTextField = [[LSTextField alloc]initWithFrame:CGRectMake(1536 * wScale, CGRectGetMaxY(self.bxLabel.frame) + 12 * hScale, 512 * wScale, 64 * hScale)];
	self.bxInputTextField.placeholder = @"0";
	self.bxInputTextField.keyboardType = UIKeyboardTypeNumberPad;
	self.bxInputTextField.font = [UIFont systemFontOfSize:22];
	self.bxInputTextField.backgroundColor = [UIColor clearColor];
	self.bxInputTextField.delegate = self;
	self.bxInputTextField.tag = 113;
	[self.view addSubview:self.bxInputTextField];
	
	UIView *bxTextfieldBottomLine = [[UIView alloc]initWithFrame:CGRectMake(self.bxLabel.frame.origin.x, CGRectGetMaxY(self.gzsInputTextField.frame) + 8 * hScale, 448 * wScale, 1 * hScale)];
	bxTextfieldBottomLine.backgroundColor = [UIColor hexString:@"#FFD9D9D9"];
	[self.view addSubview:bxTextfieldBottomLine];

	
	UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
	layOut.minimumLineSpacing = 32 * hScale;
	layOut.minimumInteritemSpacing = 32 * wScale;//UICollectionView横向cell间距，会出现多10
	layOut.sectionInset = UIEdgeInsetsMake(32 * wScale, 32 * hScale, 32 * wScale, 0);
	layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	self.addFinancialProgramView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 196 * hScale, kWidth, kHeight - 449 * hScale) collectionViewLayout:layOut];
	self.addFinancialProgramView.delegate = self;
	self.addFinancialProgramView.dataSource = self;
	[self.addFinancialProgramView registerClass:[LSFinancialProgramCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
	self.addFinancialProgramView.contentInset = UIEdgeInsetsMake(0, 0, 0, 136);
	self.addFinancialProgramView.backgroundColor = [UIColor hexString:@"#FFF3F3F3"];
	
	//右侧边栏
	self.rightSideBarBgView = [[UIView alloc]initWithFrame:CGRectMake(kWidth - 234 * wScale, 324 * hScale, 216 * wScale, 456 * hScale)];
	self.rightSideBarBgView.backgroundColor = [UIColor colorWithColor:[UIColor hexString:@"#FFFFFFFF"] alpha:0.3];
	
	self.rightSidebar = [[UIView alloc]initWithFrame:CGRectMake(kWidth - 218 * wScale, 340 * hScale, 184 * wScale, 434 * hScale)];
	self.rightSidebar.backgroundColor = [UIColor hexString:@"#D9FFFFFF"];
	
	//添加金融方案按钮
	self.addFinancialProgramBtn = [[UIButton alloc]initWithFrame:CGRectMake(54 * wScale, 32 * hScale, 76 * wScale, 50 * hScale)];
	self.addFinancialProgramBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_tianjiajinrongfangan"]];
	[self.addFinancialProgramBtn addTarget:self action:@selector(showLSAddProgramViewController) forControlEvents:UIControlEventTouchUpInside];
	[self.rightSidebar addSubview:self.addFinancialProgramBtn];
 
	//添加金融方案label
	UILabel *addFinancialProgramLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(self.addFinancialProgramBtn.frame) + 16 *hScale, 126 * wScale, 20 * hScale)];
	addFinancialProgramLabel.text = @"添加金融方案";
	addFinancialProgramLabel.font = [UIFont systemFontOfSize:10];
	addFinancialProgramLabel.textColor = [UIColor hexString:@"#FF999999"];
	[self.rightSidebar addSubview:addFinancialProgramLabel];
	
	//对比金融方案按钮
	self.vsFinancialProgramBtn = [[UIButton alloc]initWithFrame:CGRectMake(54 * wScale, CGRectGetMaxY(addFinancialProgramLabel.frame) + 56 * hScale, 76 * wScale, 50 * hScale)];
	self.vsFinancialProgramBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_duibijinrongfangan"]];
	[self.vsFinancialProgramBtn addTarget:self action:@selector(showVSFinancialProgramViewController) forControlEvents:UIControlEventTouchUpInside];
	[self.rightSidebar addSubview:self.vsFinancialProgramBtn];
	
	//对比金融方案label
	UILabel *vsFinancialProgramLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(self.vsFinancialProgramBtn.frame) + 16 *hScale, 126 * wScale, 20 * hScale)];
	vsFinancialProgramLabel.text = @"对比金融方案";
	vsFinancialProgramLabel.font = [UIFont systemFontOfSize:10];
	vsFinancialProgramLabel.textColor = [UIColor hexString:@"#FF999999"];
	[self.rightSidebar addSubview:vsFinancialProgramLabel];
	
	//删除金融方案按钮
	self.deleteFinancialProgramBtn = [[UIButton alloc]initWithFrame:CGRectMake(54 * wScale, CGRectGetMaxY(vsFinancialProgramLabel.frame) + 56 * hScale, 76 * wScale, 50 * hScale)];
	//self.deleteFinancialProgramBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"icon_shanchufangan"]];
	[self.deleteFinancialProgramBtn setImage:[UIImage imageNamed:@"icon_shanchufangan"] forState:UIControlStateNormal];
	[self.deleteFinancialProgramBtn setImage:[UIImage imageNamed:@"icon_wancheng"] forState:UIControlStateSelected];
	[self.deleteFinancialProgramBtn addTarget:self action:@selector(deselectDeleteFinancialProgramButton:) forControlEvents:UIControlEventTouchUpInside];
	[self.rightSidebar addSubview:self.deleteFinancialProgramBtn];
	
	//删除金融方案label
	UILabel *deleteFinancialProgramLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(self.deleteFinancialProgramBtn.frame) + 16 *hScale, 126 * wScale, 20 * hScale)];
	deleteFinancialProgramLabel.text = @"删除金融方案";
	deleteFinancialProgramLabel.font = [UIFont systemFontOfSize:10];
	deleteFinancialProgramLabel.textColor = [UIColor hexString:@"#FF999999"];
	[self.rightSidebar addSubview:deleteFinancialProgramLabel];
	
	self.rightSidebar.hidden = YES;
	self.rightSideBarBgView.hidden = YES;
	
	[self.view addSubview:self.addFinancialProgramView];
	[self.view addSubview:self.rightSideBarBgView];
	[self.view addSubview:self.rightSidebar];
}

#pragma mark - LSAddProgramViewDelegate
-(void)popToFinancialProgramViewControllerWithChoosedProductsModel:(LSChoosedProductsModel *)choosedProductsModel
{
	self.choosedProductsModel = choosedProductsModel;
	
	int i = 0;
	for (LSChoosedProductsModel *m  in self.choosedProductsModelArray) {
		if ([m.productID isEqualToString:choosedProductsModel.productID]) {
			i += 1;
		}
	}
	if (i > 0) {
		choosedProductsModel.productName = [NSString stringWithFormat:@"%@%i",choosedProductsModel.productName,i];
	}
	[self.choosedProductsModelArray addObject:choosedProductsModel];
	self.rightSidebar.hidden = NO;
	self.rightSideBarBgView.hidden = NO;
	if (self.choosedProductsModelArray.count > 1) {
		self.numberOfRows +=1;
	}
	
	self.isNeedReload = NO;
	[self.addFinancialProgramView reloadData];
	
	if (_delegate && ([_delegate respondsToSelector:@selector(refreshChoosedFinancialProductTitle:)])) {
		[_delegate refreshChoosedFinancialProductTitle:choosedProductsModel.productName];
	}
	if (_delegate && ([_delegate respondsToSelector:@selector(popToFinancialProgramViewControllerWithDataArr:withFinancialProgramTag:)])) {
		[_delegate popToFinancialProgramViewControllerWithDataArr:self.choosedProductsModelArray withFinancialProgramTag:self.choosedProductsModelArray.count];
	}
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.numberOfRows;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray *indexArray = [NSArray array];
	NSMutableArray *tempArray = [NSMutableArray array];
	for (LSChoosedProductsModel *tempModel in self.choosedProductsModelArray) {
		[tempArray addObject:tempModel.khsjgccb];
	}
	if (tempArray.count > 0) {
		indexArray = [self getMinInfoFromArr:tempArray];
	}
	
	LSFinancialProgramCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    NSString *imageName = [self.ProductsBGImageNameArr objectAtIndex:indexPath.row % 8];
    cell.pictuerImageView.image = [UIImage imageNamed:imageName];
    cell.pictuerImageView.image = [UIImage imageNamed:@"quankuangouche"];
	if (indexPath.row == 0) {
		cell.addFinancialProgramImgView.hidden = YES;
		cell.bestProgramImageView.hidden = YES;
		cell.financialSizeLabel.text = @"0";
		cell.loanPeriodLabel.text = @"0";
		cell.downpaymentsLabel.text = @"100";
		cell.monthlyMoneyLabel.text = @"0";
		if (self.realPriceInputTextField.text.length == 0) {
			//cell.costOfCarLabel.text = [self.carModel.catModelDetailPrice cut];
			cell.costOfCarLabel.text = [NSString stringWithFormat:@"%.0f",[self.carModel.catModelDetailPrice floatValue] + [self.purchaseTax floatValue]];
		}else{
			NSString *tempString = [NSString stringWithFormat:@"%.0f",[self.realPriceInputTextField.text floatValue] + [self.gzsInputTextField.text floatValue] + [self.bxInputTextField.text floatValue]];
			cell.costOfCarLabel.text = [tempString cut];
		}
		self.fullPaymentRealPrice = cell.costOfCarLabel.text;
		cell.financialProgramTitleLabel.text = @"全款购车";
//		cell.pictuerImageView.image = [UIImage imageNamed:@"quankuangouche"];
	}else{
		cell.addFinancialProgramImgView.hidden = self.choosedProductsModel;
		cell.editBtn.enabled = cell.addFinancialProgramImgView.hidden;
		cell.chooseBtn.enabled = cell.addFinancialProgramImgView.hidden;
		if (cell.addFinancialProgramImgView.hidden == YES) {
			NSLog(@"%@",indexArray);
			cell.bestProgramImageView.hidden=YES;
			for (NSString *indexPathString in indexArray) {
				if (indexPath.row == [indexPathString integerValue] + 1) {
					cell.bestProgramImageView.hidden = NO;
				}
			}
			LSChoosedProductsModel *m = self.choosedProductsModelArray[indexPath.row - 1];
			cell.financialProgramTitleLabel.text = m.productName;
			cell.financialSizeLabel.text = [m.rzgm cut];
			cell.loanPeriodLabel.text = m.loanyear;
			cell.downpaymentsLabel.text = m.paymentradio;
			cell.monthlyMoneyLabel.text = [m.yg cut];
			cell.costOfCarLabel.text = [m.khsjgccb cut];
//			if ([m.productID isEqualToString:@"1"]) {
//				cell.pictuerImageView.image = [UIImage imageNamed:@"rongzizulinbiaozhunchanpin"];
//			}
//			if ([m.productID isEqualToString:@"2"]) {
//				cell.pictuerImageView.image = [UIImage imageNamed:@"kaixinche"];
//			}
//			if ([m.productID isEqualToString:@"20"]) {
//				cell.pictuerImageView.image = [UIImage imageNamed:@"yinhangdaikuan"];
//			}
//			if ([m.productID isEqualToString:@"21"]) {
//				cell.pictuerImageView.image = [UIImage imageNamed:@"rongzizulinbaozhengjinchanpin"];
//			}
//			if ([m.productID isEqualToString:@"22"]) {
//				cell.pictuerImageView.image = [UIImage imageNamed:@"rongzizulintiexichanpin"];
//			}
//			if ([m.productID isEqualToString:@"23"]) {
//				cell.pictuerImageView.image = [UIImage imageNamed:@"baomajinrongtiexi"];
//			}
//			if ([m.productID isEqualToString:@"24"]) {
//				cell.pictuerImageView.image = [UIImage imageNamed:@"baomaweikuantiexi"];
//			}
		}
	}
	
	cell.editBtn.tag = indexPath.row;
	[cell.editBtn addTarget:self action:@selector(editFinancialProduct:) forControlEvents:UIControlEventTouchUpInside];
	cell.chooseBtn.tag = indexPath.row;
	[cell.chooseBtn addTarget:self action:@selector(deselectFinancialProgramBtn:) forControlEvents:UIControlEventTouchUpInside];
	cell.deleteButton.tag = indexPath.row;
	[cell.deleteButton addTarget:self action:@selector(deleteFinancialProgramButton:) forControlEvents:UIControlEventTouchUpInside];
	
	if (self.isNeedReload == NO) {
		[self settingChoosedButtonStateWithCellRow:self.numberOfRows - 1 withCell:cell withIndexPath:indexPath];
	}else{
		[self settingChoosedButtonStateWithCellRow:self.selectedProgramTag - 1 withCell:cell withIndexPath:indexPath];
	}
	
	if (indexPath.row == 0) {
		cell.userInteractionEnabled = NO;
		[cell.editBtn setTitleColor:[UIColor clearColor]];
	}else{
		cell.userInteractionEnabled = YES;
		[cell.editBtn setTitleColor:[UIColor whiteColor]];
	}
	
	//是否删除金融方案
	if (indexPath.row == 0) {
		cell.deleteButton.hidden = YES;
		cell.chooseBtn.hidden = NO;
	}else{
		if (self.isNeedDelete) {
			cell.deleteButton.hidden = NO;
			cell.chooseBtn.hidden = YES;
		}else{
			cell.deleteButton.hidden = YES;
			cell.chooseBtn.hidden = NO;
		}
	}
	return cell;
}

-(void)settingChoosedButtonStateWithCellRow:(NSInteger)cellRow withCell:(LSFinancialProgramCollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == cellRow) {
		cell.chooseBtn.selected = YES;
		cell.chooseBtn.backgroundColor = [UIColor hexString:@"#FF333333"];
		[cell.chooseBtn setTitleColor:[UIColor hexString:@"#FFFFFFFF"]];
	}else{
		cell.chooseBtn.selected = NO;
		cell.chooseBtn.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
		if (indexPath.row == 0) {
			[cell.chooseBtn setTitleColor:[UIColor hexString:@"#FFC8C9CC"]];
		}else{
			[cell.chooseBtn setTitleColor:[UIColor hexString:@"#FF666666"]];
		}
	}
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake(660 * wScale,1004 * hScale);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"第%@行",indexPath);
	if (indexPath.row == 1) {
		if (!self.choosedProductsModel) {
			[self showLSAddProgramViewController];
		}
	}
}

-(void)deselectFinancialProgramBtn:(UIButton *)sender
{
	self.isNeedReload = YES;
	
	self.selectedProductTag = sender.tag;
	self.selectedProgramTag = sender.tag + 1;
	[self.addFinancialProgramView reloadData];
	
	if (_delegate && ([_delegate respondsToSelector:@selector(popToCarDetailsViewControllerWithTitle:)])) {
		NSMutableArray *transferArr = [NSMutableArray arrayWithObjects:@"--", nil];
		for (LSChoosedProductsModel *m in self.choosedProductsModelArray) {
			[transferArr addObject:m.productName];
		}
		[_delegate popToCarDetailsViewControllerWithTitle:transferArr[sender.tag]];
	}
	
	if (_delegate && ([_delegate respondsToSelector:@selector(popToFinancialProgramViewControllerWithDataArr:withFinancialProgramTag:)])) {
		[_delegate popToFinancialProgramViewControllerWithDataArr:self.choosedProductsModelArray withFinancialProgramTag:sender.tag];
	}
}

#pragma mark - 显示添加金融产品的ViewController
-(void)showLSAddProgramViewController
{
	if (self.realPriceInputTextField.text.length == 0) {
		[Tool showAlertViewWithString:@"请输入实际价格" withController:self];
		return;
	}
	if (self.gzsInputTextField.text.length == 0) {
		[Tool showAlertViewWithString:@"请输入购置税" withController:self];
		return;
	}
	if (self.bxInputTextField.text.length == 0) {
		[Tool showAlertViewWithString:@"请输入保险" withController:self];
		return;
	}
	
	[self.view.window endEditing:YES];
	LSAddProgramViewController *vc = [[LSAddProgramViewController alloc]init];
	vc.carModel = self.carModel;
	vc.realPrice = self.realPriceInputTextField.text;
	vc.purchaseTax = self.gzsInputTextField.text;
	vc.insurance = self.bxInputTextField.text;
	vc.view.frame = CGRectMake(0, kHeight, kWidth, kHeight);
	[UIView animateWithDuration:0.7 animations:^{
		vc.view.frame = CGRectMake(0, 0, kWidth, kHeight);
	}];
	vc.delegate = self;
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	[window addSubview:vc.view];
	[self addChildViewController:vc];
}

#pragma mark - 显示对比金融产品的ViewController
-(void)showVSFinancialProgramViewController
{
	LSVSFinancialProgramViewController *vc = [[LSVSFinancialProgramViewController alloc]init];
	vc.realPrice = self.realPriceInputTextField.text;
	vc.fullPaymentRealPrice = self.fullPaymentRealPrice;
	vc.numberOfRows = self.numberOfRows;
	vc.choosedProductsModelArray = self.choosedProductsModelArray;
	vc.view.frame = CGRectMake(0, 0, kWidth, kHeight);
	UIWindow *window = [UIApplication sharedApplication].keyWindow;
	[window addSubview:vc.view];
	[self addChildViewController:vc];
}

#pragma mark - 删除金融产品
-(void)deselectDeleteFinancialProgramButton:(UIButton *)button
{
	button.selected = !button.selected;
	self.isNeedDelete = button.selected;
	[self.addFinancialProgramView reloadData];
}

-(void)deleteFinancialProgramButton:(UIButton *)button
{
	[self.choosedProductsModelArray removeObjectAtIndex:button.tag - 1];
	if (self.choosedProductsModelArray.count == 0) {
		self.choosedProductsModel = nil;
		self.rightSidebar.hidden = YES;
		self.rightSideBarBgView.hidden = YES;
	}else{
		self.numberOfRows -=1;
	}
	
	LSChoosedProductsModel *choosedProductsModel = [self.choosedProductsModelArray lastObject];
	if (_delegate && ([_delegate respondsToSelector:@selector(refreshChoosedFinancialProductTitle:)])) {
		if (self.choosedProductsModelArray.count == 0) {
			[_delegate refreshChoosedFinancialProductTitle:@"--"];
		}else{
			[_delegate refreshChoosedFinancialProductTitle:choosedProductsModel.productName];
		}
	}
	self.isNeedReload = NO;
	if (_delegate && ([_delegate respondsToSelector:@selector(popToFinancialProgramViewControllerWithDataArr:withFinancialProgramTag:)])) {
		[_delegate popToFinancialProgramViewControllerWithDataArr:self.choosedProductsModelArray withFinancialProgramTag:self.choosedProductsModelArray.count];
	}
	[self.addFinancialProgramView reloadData];
}

#pragma mark - 编辑金融产品
-(void)editFinancialProduct:(UIButton *)sender
{
	[self.view.window endEditing:YES];
	self.editButtonTag = sender.tag;
	UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
	backgroundView.backgroundColor = [UIColor hexString:@"#4D000000"];
	
	LSChoosedProductsModel *choosedProductsModel = self.choosedProductsModelArray[sender.tag - 1];
	//if ([choosedProductsModel.productState isEqualToString:@"1"]) {
	//自营
	LSFinancialProductsModel *financialProductsModel = [[LSFinancialProductsModel alloc]init];
	financialProductsModel.interestrate = [NSString stringWithFormat:@"%.2f",[choosedProductsModel.fl floatValue]*100];//费率
	financialProductsModel.loanyear = choosedProductsModel.qs;//期数
	financialProductsModel.marginradio = choosedProductsModel.marginradio;//保证金比例
	financialProductsModel.paymentradio = choosedProductsModel.paymentradio;//首付比例
	financialProductsModel.productID = choosedProductsModel.productID;
	financialProductsModel.productName = choosedProductsModel.productName;
	financialProductsModel.productState =choosedProductsModel.productState;
	financialProductsModel.productDict = choosedProductsModel.intentID;
	//financialProductsModel.residualrate = choosedProductsModel.residualrate;//残值率
	//financialProductsModel.serviceradio = @"0";
	//financialProductsModel.taxdeductible = choosedProductsModel.gskds;
	financialProductsModel.cargive = choosedProductsModel.by;//保养赠送
	financialProductsModel.carlet = choosedProductsModel.cjrl;//车价让利
	financialProductsModel.investret = [NSString stringWithFormat:@"%.2f",[choosedProductsModel.ntzhbl floatValue]*100];//年投资回报率
	financialProductsModel.cpi = [NSString stringWithFormat:@"%.2f",[choosedProductsModel.ncpi floatValue]*100];//年CPI
	financialProductsModel.servicecharge = choosedProductsModel.dkfwf;//贷款服务费
	//新
	financialProductsModel.retentionRatio = [NSString stringWithFormat:@"%.2f",[choosedProductsModel.lgbl floatValue]*100];;//留购比例
	
	financialProductsModel.cj = choosedProductsModel.cj;//车价
	financialProductsModel.suggestedRetailPrice = self.carModel.catModelDetailPrice;//建议零售价
	financialProductsModel.counterFeeRatio = choosedProductsModel.sxfl;//手续费
	financialProductsModel.purchaseTax = choosedProductsModel.gzs;
	financialProductsModel.insurance = choosedProductsModel.bx;//保险
	financialProductsModel.isGzsSelected = choosedProductsModel.isGzsSelected;
	financialProductsModel.isBxSelected = choosedProductsModel.isBxSelected;
	financialProductsModel.interestRate1 = choosedProductsModel.interestRate1;
	financialProductsModel.interestRate2 = choosedProductsModel.interestRate2;
	
	self.inputView = [[LSAddNonAgentProductInputView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) productModel:financialProductsModel realPrice:financialProductsModel.cj productDict:choosedProductsModel.intentID];
	self.inputView.delegate = self;

	[backgroundView addSubview:self.inputView];
	self.backgroundView = backgroundView;
	[self.view.window addSubview:backgroundView];
}

/**
 取消编辑金融产品
 */
-(void)removeAddNonAgentProductInputView
{
    [self.backgroundView removeFromSuperview];
}

#pragma mark - 求最小值的下标算法
//-(void)getMinInfoFromArr:(NSMutableArray *)arr WithSuccessBlock:(void (^)(NSInteger index,NSString *min))SuccessBlock{
//	if(arr.count<1){
//		SuccessBlock(0,nil);
//		return;
//	}
//	int minIdx=0;
//	NSString *minStr=arr[0];
//	for(int i=0;i<arr.count;i++){
//		NSString *str=arr[i];
//		if([str floatValue]<[minStr floatValue]){
//			minStr=str;
//			minIdx=i;
//		}
//	}
//	SuccessBlock(minIdx,minStr);
//}

-(NSArray *)getMinInfoFromArr:(NSArray *)arr{
	NSInteger minIdx=0;
	NSString *minStr=arr[0];
	NSMutableArray *idxArr=[NSMutableArray array];
	[idxArr addObject:@"0"];
	for(NSInteger i=1;i<arr.count;i++){
		NSString *str=arr[i];
		if([str floatValue]<[minStr floatValue]){
			idxArr=[NSMutableArray array];
			minStr=str;
			minIdx=i;
			[idxArr addObject:[NSString stringWithFormat:@"%ld",(long)i]];
		}else if ([str floatValue]==[minStr floatValue]){
			[idxArr addObject:[NSString stringWithFormat:@"%ld",(long)i]];
		}
	}
	return idxArr;
}

#pragma mark - 确认编辑金融方案
-(void)removeAddProgramViewAfterAddNonAgentProductInputViewDisAppear
{
	if (self.inputView.choosedProductsModel) {
		[self.choosedProductsModelArray replaceObjectAtIndex:self.editButtonTag - 1 withObject:self.inputView.choosedProductsModel];
		self.inputView.choosedProductsModel = nil;
	}
	if (_delegate && ([_delegate respondsToSelector:@selector(refreshEditedFinancialProductArray: withSelectedProductTag:)])) {
		[_delegate refreshEditedFinancialProductArray:self.choosedProductsModelArray withSelectedProductTag:self.selectedProgramTag];
	}
	
	[self.addFinancialProgramView reloadData];
	[self.backgroundView removeFromSuperview];
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(LSTextField *)textField
{
	if (textField.tag == 111||textField.tag == 112||textField.tag == 113) {
		[self.addFinancialProgramView reloadData];
	}
}

#pragma mark - lazy load
-(NSMutableArray *)choosedProductsModelArray
{
	if (!_choosedProductsModelArray) {
		_choosedProductsModelArray = [NSMutableArray array];
	}
	return _choosedProductsModelArray;
}

-(UIAlertController *)editAlertController
{
	if (!_editAlertController) {
		_editAlertController = [[UIAlertController alloc]init];
	}
	return _editAlertController;
}
- (NSArray *)ProductsBGImageNameArr
{
    if (!_ProductsBGImageNameArr) {
        _ProductsBGImageNameArr = @[@"quankuangouche",@"rongzizulinbiaozhunchanpin",@"kaixinche",@"yinhangdaikuan",@"rongzizulinbaozhengjinchanpin",@"rongzizulintiexichanpin",@"baomajinrongtiexi",@"baomaweikuantiexi"];
    }
    return _ProductsBGImageNameArr;
}
@end
