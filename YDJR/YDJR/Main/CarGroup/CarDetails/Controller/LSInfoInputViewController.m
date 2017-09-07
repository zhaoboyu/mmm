//
//  LSInfoInputCollectionViewController.m
//  YDJR
//
//  Created by 李爽 on 2016/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSInfoInputViewController.h"
#import "LSInfoInputCollectionViewCell.h"
#import "LSFPDetailHeaderCollectionReusableView.h"
#import "DetailListCellPopView.h"
#import "LSTextField.h"
#import "CTTXRequestServer+LetterofIntent.h"
#import "LSMaterialModel.h"
#import "LSChoosedProductsModel.h"
#import "LSMaterialShowCollectionViewCell.h"
#import "LSInfoInputPopCollectionViewCell.h"

#define CELL_ID      @"CELL_ID"
#define POPCELL_ID      @"POPCELL_ID"
#define TALKCELL_ID      @"TALKCELL_ID"
@interface LSInfoInputViewController ()<UITextFieldDelegate,DetailListCellPopViewDelegate>
@property (nonatomic,strong)UICollectionView *infoInputCollectionView;
@property (nonatomic,copy)NSArray *headerTitleArray;/** header标题Arr*/
@property (nonatomic,copy)NSArray *titleArray;/** 标题Arr*/
@property (nonatomic,strong)UIButton *chooseBtn;/** 请选择按钮*/
@property (nonatomic,strong)UIButton *choosedBtn;/** 已经选择的按钮*/
@property (nonatomic,assign,getter=isOpen)BOOL open;
@property (nonatomic,strong)UIButton *sexBtn;/** 性别*/
@property (nonatomic,strong)UIButton *cardTypeBtn;/** 证件类型*/
@property (nonatomic,strong)UIButton *clientTypeBtn;/** 客户类型*/
@property (nonatomic,copy)NSMutableArray *materialModelArr;/** 客户所需材料ModelArr*/
@property (nonatomic,copy)NSMutableArray *cardModelArr;/** 证件类型ModelArr*/
@property (nonatomic,copy)NSMutableArray *contentTextArr;/** 客户信息输入框内容*/
@property (nonatomic,strong)HGBPromgressHud *phud;
@property (nonatomic,copy)NSDictionary *businessCustomerDic;
@property (nonatomic,copy)NSDictionary *individualClientDic;
@end

@implementation LSInfoInputViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor whiteColor];
	NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
	NSDictionary *userTypeDic = tempArr[0];
	NSArray *userTypeArr;
	userTypeArr = [userTypeDic objectForKey:@"IDFS000046"];
	if (userTypeArr.count <= 0) {
		return;
	}
	self.businessCustomerDic = userTypeArr[0];
	self.individualClientDic = userTypeArr[1];

	[self p_setupView];
	if (![Tool isCustomerPersonTypeWithCustomerType:self.customerType]) {
		[self obtainDataFromNetWithDictItem:@"IDFS000210" WithType:1];
	}else{
		[self obtainDataFromNetWithDictItem:@"IDFS000322" WithType:1];
	}
}

#pragma mark - p_setupView
- (void)p_setupView
{
	//灰色背景
	UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1696*wScale, 1254*hScale)];
	grayView.backgroundColor = [UIColor hexString:@"#FFF0F1F5"];
	[self.view addSubview:grayView];
	
	UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
	layOut.minimumLineSpacing = 0;
	layOut.minimumInteritemSpacing = 0;//UICollectionView横向cell间距，会出现多10
	layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
	layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
	layOut.headerReferenceSize = CGSizeMake(grayView.width, 152.0f *hScale);  //设置header大小
	self.infoInputCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, grayView.width, grayView.height) collectionViewLayout:layOut];
	self.infoInputCollectionView.delegate = self;
	self.infoInputCollectionView.dataSource = self;
	[self.infoInputCollectionView registerClass:[LSInfoInputCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
	[self.infoInputCollectionView registerClass:[LSInfoInputPopCollectionViewCell class] forCellWithReuseIdentifier:POPCELL_ID];
	[self.infoInputCollectionView registerClass:[LSMaterialShowCollectionViewCell class] forCellWithReuseIdentifier:TALKCELL_ID];
	
	//注册header
	[self.infoInputCollectionView registerClass:[LSFPDetailHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
	self.infoInputCollectionView.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
	self.infoInputCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 152*hScale, 0);
	
	[grayView addSubview:self.infoInputCollectionView];
	
	//底部栏
	UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, grayView.height - 128*hScale, grayView.width, 128*hScale)];
	barView.backgroundColor = [UIColor hexString:@"#FFFFFF"];
	
	UIView *cuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, grayView.width, hScale)];
	cuttingLine.backgroundColor = [UIColor hexString:@"#FFD9D9D9"];
	[barView addSubview:cuttingLine];
	
	UIButton *saveUserBtn = [[UIButton alloc]initWithFrame:CGRectMake(1344 * wScale, 24 * hScale, 320 * wScale, 80 * hScale)];
	[saveUserBtn setTitle:@"保存" forState:UIControlStateNormal];
	saveUserBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
	saveUserBtn.backgroundColor = [UIColor hex:@"#FF333333"];
	[saveUserBtn addTarget:self action:@selector(saveUser) forControlEvents:UIControlEventTouchUpInside];
	[barView addSubview:saveUserBtn];
	
	[grayView addSubview:barView];
	
	//self.grayView = grayView;
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	if (![Tool isCustomerPersonTypeWithCustomerType:self.customerType]) {
		return  section == 1 ? self.materialModelArr.count : 5;
	}else{
		return  section == 1 ? self.materialModelArr.count : 6;
	}
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		if (![Tool isCustomerPersonTypeWithCustomerType:self.customerType]) {
			if ((indexPath.row ==0)||(indexPath.row ==3)||(indexPath.row ==4)) {
				LSInfoInputCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
				cell.nameLabel.text = self.titleArray[indexPath.item];
				cell.contentTextField.delegate = self;
				cell.contentTextField.tag = indexPath.item;
				NSString *titleStr = self.contentTextArr[indexPath.item];
				cell.contentTextField.text = titleStr;
				return cell;
			}else{
				LSInfoInputPopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:POPCELL_ID forIndexPath:indexPath];
				cell.nameLabel.text = self.titleArray[indexPath.item];
				cell.chooseBtn.tag = indexPath.item;
				NSString *titleStr = self.contentTextArr[indexPath.item];
				if (titleStr.length > 0) {
					[cell.chooseBtn setTitle:titleStr forState:UIControlStateNormal];
				}else{
					[cell.chooseBtn setTitle:@"请选择" forState:UIControlStateNormal];
				}
				[cell.chooseBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
				return cell;
			}
		}else{
			if ((indexPath.row ==0)||(indexPath.row ==3)||(indexPath.row ==4)||(indexPath.row ==5)) {
				LSInfoInputCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
				cell.nameLabel.text = self.titleArray[indexPath.item];
				cell.contentTextField.delegate = self;
				cell.contentTextField.tag = indexPath.item;
				NSString *titleStr = self.contentTextArr[indexPath.item];
				cell.contentTextField.text = titleStr;
				return cell;
			}else{
				LSInfoInputPopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:POPCELL_ID forIndexPath:indexPath];
				cell.nameLabel.text = self.titleArray[indexPath.item];
				cell.chooseBtn.tag = indexPath.item;
				NSString *titleStr = self.contentTextArr[indexPath.item];
				if (titleStr.length > 0) {
					[cell.chooseBtn setTitle:titleStr forState:UIControlStateNormal];
				}else{
					[cell.chooseBtn setTitle:@"请选择" forState:UIControlStateNormal];
				}
				[cell.chooseBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
				return cell;
			}
		}
	}else {
		LSMaterialShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TALKCELL_ID forIndexPath:indexPath];
		LSMaterialModel *m = self.materialModelArr[indexPath.item];
		cell.nameLabel.text = [NSString stringWithFormat:@"%ld、%@",(long)indexPath.row + 1,m.dictname];
		if (indexPath.row == 0) {
			[collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
		}
		return cell;
	}
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake(1696*wScale/3,154 *hScale);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
		LSFPDetailHeaderCollectionReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
		reusableView.headerTitleLabel.text = self.headerTitleArray[indexPath.section];
		if (indexPath.section == 1) {
			reusableView.additionalBtn.hidden = NO;
			[reusableView.additionalBtn setTitle:@"材料查询" forState:UIControlStateNormal];
			[reusableView.additionalBtn addTarget:self action:@selector(materialCheck) forControlEvents:UIControlEventTouchUpInside];
		}
		return reusableView;
	}
	return nil;
}

//-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    if(section == 1)
//    {
//        CGSize size = {1780*wScale, 0};
//        return size;
//    }
//    else
//    {
//        CGSize size = {1780*wScale, 112.0f *hScale};
//        return size;
//    }
//}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	if (textField.tag == 3 || textField.tag == 4) {
		textField.keyboardType = UIKeyboardTypeNumberPad;
		if (textField.tag == 3) {
			if (kStringIsEmpty(self.contentTextArr[2])) {
				[Tool showAlertViewWithString:@"请先选择证件类型" withController:self];
				return;
			}
		}
	}
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
	if (textField.tag == 3 || textField.tag == 4) {
		if (textField.tag == 3) {
			if ([self.contentTextArr[2] isEqualToString:@"身份证"]) {
				if (![Tool checkIDCardNum:textField.text]) {
					[Tool showAlertViewWithString:@"您输入的身份证号码不正确" withController:self];
					return;
				}
			}
		}
		if (textField.tag == 4) {
			if (![Tool isMobileNumberWithPhoneNum:textField.text]) {
				[Tool showAlertViewWithString:@"您输入的手机号码不正确" withController:self];
				return;
			}
		}
	}
	[self.contentTextArr replaceObjectAtIndex:textField.tag withObject:textField.text];
}

#pragma mark - 设置小三角旋转的事件
-(void)btnClicked:(UIButton *)titleBtn
{
	[self.view.window endEditing:YES];
	if (!self.isOpen) {
		if ((titleBtn.tag == 1)||(titleBtn.tag == 2)) {
			NSMutableArray *tempArr = nil;
			switch (titleBtn.tag) {
				case 1:
					tempArr = [NSMutableArray arrayWithObjects:@"男",@"女", nil];
					self.sexBtn = titleBtn;
					break;
				case 2:
					tempArr = [NSMutableArray array];
					for (LSMaterialModel *m in self.cardModelArr) {
						[tempArr addObject:m.dictname];
					}
					self.cardTypeBtn = titleBtn;
					break;
				default:
					break;
			}
			CGRect originInSuperview = [self.infoInputCollectionView.window convertRect:titleBtn.bounds fromView:titleBtn];
			BOOL isOther = NO;
			if (titleBtn.tag == 1) {
				isOther = NO;
			}else{
				isOther = YES;
			}
			DetailListCellPopView *detailListCellPopView = [[DetailListCellPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds] ListFrame:originInSuperview listArr:tempArr isOtherTitle:isOther];
			detailListCellPopView.delegate = self;
			[detailListCellPopView showPopView];
		}
		
		[UIView animateWithDuration:1 animations:^{
			titleBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
		}];
		self.open = YES;
	}else{
		[UIView animateWithDuration:1 animations:^{
			titleBtn.imageView.transform = CGAffineTransformIdentity;
		}];
		self.open = NO;
	}
	self.choosedBtn = titleBtn;
}

#pragma mark - DetailListCellPopViewDelegate
- (void)sendMessageWithMessage:(NSString *)messge
{
	[UIView animateWithDuration:1 animations:^{
		self.choosedBtn.imageView.transform = CGAffineTransformIdentity;
	}];
	self.open = NO;
	
	[self.choosedBtn setTitle:messge forState:UIControlStateNormal];//#FF333333
	[self.choosedBtn setTitleColor:[UIColor hexString:@"#FF333333"] forState:UIControlStateNormal];
	[self.contentTextArr replaceObjectAtIndex:self.choosedBtn.tag withObject:messge];
}

-(void)popViewHide
{
	[UIView animateWithDuration:1 animations:^{
		self.choosedBtn.imageView.transform = CGAffineTransformIdentity;
	}];
	self.open = NO;
}

#pragma mark - 材料查询
-(void)materialCheck
{
	if ([self.choosedProductsModel.productID isEqualToString:@"2"]){
		if (![Tool isCustomerPersonTypeWithCustomerType:self.customerType]) {
			//开心车
			[self obtainDataFromNetWithDictItem:@"IDFS000331" WithType:2];
		}else{
			[Tool showAlertViewWithString:@"暂无材料可查询" withController:self];
		}
	}else if ([self.choosedProductsModel.productID isEqualToString:@"1"]||[self.choosedProductsModel.productID isEqualToString:@"21"]||[self.choosedProductsModel.productID isEqualToString:@"22"]){
		if (![Tool isCustomerPersonTypeWithCustomerType:self.customerType]) {
			//融资租赁个人
			[self obtainDataFromNetWithDictItem:@"IDFS000329" WithType:2];
		}else{
			//融资租赁企业
			[self obtainDataFromNetWithDictItem:@"IDFS000330" WithType:2];
		}
	}else{
		[Tool showAlertViewWithString:@"暂无材料可查询" withController:self];
	}

}

#pragma mark - 获取证件类型数据
-(void)obtainDataFromNetWithDictItem:(NSString *)dictitem WithType:(int)type
{
	[self.phud showHUDSaveAddedTo:self.view];
	[[CTTXRequestServer shareInstance]checkMaterialWithDictitem:dictitem WithType:type SuccessBlock:^(NSMutableArray *materialModelArr) {
		[self.phud hideSave];
		if (type == 1) {
			self.cardModelArr = materialModelArr;
		}
		if (type == 2) {
			//self.numberOfItems = (int)materialModelArr.count;
			self.materialModelArr = materialModelArr;
			NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:1];
			[self.infoInputCollectionView reloadSections:indexSet];
		}
	} failedBlock:^(NSError *error) {
		[self.phud hideSave];
		self.phud.promptStr = @"网络状况不好...请稍后重试!";
		[self.phud showHUDResultAddedTo:self.view];
	}];
}

#pragma mark - 存入客户
-(void)saveUser
{
	if (![Tool isCustomerPersonTypeWithCustomerType:self.customerType]) {
		if (([self.contentTextArr[0] isEqualToString:@""])||([self.contentTextArr[4] isEqualToString:@""])) {
			[Tool showAlertViewWithString:@"您输入的信息不全" withController:self];
			return;
		}
	}else{
		if (([self.contentTextArr[4] isEqualToString:@""])||([self.contentTextArr[5] isEqualToString:@""])) {
			[Tool showAlertViewWithString:@"您输入的信息不全" withController:self];
			return;
		}
	}
	
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	NSMutableDictionary *customerDict = [NSMutableDictionary dictionary];
	
	if (![Tool isCustomerPersonTypeWithCustomerType:self.customerType]) {
		customerDict[@"customerName"] = self.contentTextArr[0];
		customerDict[@"customerLxr"] = @"";
	}else{
		if (!kStringIsEmpty(self.contentTextArr[0])) {
			customerDict[@"customerLxr"] = self.contentTextArr[0];
		}else{
			customerDict[@"customerLxr"] = @"";
		}
		customerDict[@"customerName"] = self.contentTextArr[5];
	}
	
	if (!kStringIsEmpty(self.contentTextArr[1])) {
		customerDict[@"customerSex"] = self.contentTextArr[1];
	}else{
		customerDict[@"customerSex"] = @"";
	}
	
	if (!kStringIsEmpty(self.contentTextArr[2])) {
		for (int i = 0; i < self.cardModelArr.count; i++) {
			LSMaterialModel *m = self.cardModelArr[i];
			if ([m.dictname isEqualToString:self.contentTextArr[2]]) {
				customerDict[@"idsType"] = m.dictvalue;
			}
		}
	}else{
		customerDict[@"idsType"] = @"";
	}
	
	if (!kStringIsEmpty(self.contentTextArr[3])) {
		customerDict[@"idsNumber"] = self.contentTextArr[3];
	}else{
		customerDict[@"idsNumber"] = @"";
	}
	
	customerDict[@"customerPhone"] = self.contentTextArr[4];
	customerDict[@"customerType"] = self.customerType;
	customerDict[@"operatorCode"] = [UserDataModel sharedUserDataModel].userName;
	customerDict[@"mechanismID"] = [Tool getMechinsId];
	[params setObject:customerDict forKey:@"Customer"];
	
	NSMutableDictionary *intentDict = [NSMutableDictionary dictionary];
	intentDict[@"carSeriesID"] = self.choosedProductsModel.carSeriesID;
	intentDict[@"carModelID"] =	@"";
	intentDict[@"catModelDetailID"] = self.choosedProductsModel.catModelDetailID;
	intentDict[@"productID"] = self.choosedProductsModel.productID;
	intentDict[@"carPrice"] = self.choosedProductsModel.catModelDetailPrice;
	intentDict[@"insurance"] = self.choosedProductsModel.insurance;
	intentDict[@"totalInst"] = self.choosedProductsModel.insurance;
	intentDict[@"interest"] = self.choosedProductsModel.lx;
	intentDict[@"insuranceMess"] = self.choosedProductsModel.insuranceMess;
	intentDict[@"totalCarCost"] = self.choosedProductsModel.zgccb;
	intentDict[@"instCounts"] = self.choosedProductsModel.loanyear;
	intentDict[@"contractAmount"] = self.choosedProductsModel.contractAmount;
	intentDict[@"uptoTerm"] = self.choosedProductsModel.uptoTerm;
	intentDict[@"isInsFq"] = self.choosedProductsModel.isInsFq;
	intentDict[@"productState"] = self.choosedProductsModel.productState;
	intentDict[@"carPpName"] = self.choosedProductsModel.carPpName;
	if (IS_STRING_EMPTY(self.choosedProductsModel.gzs)) {
		intentDict[@"purchasetax"] = @"";
	}else{
		intentDict[@"purchasetax"] = self.choosedProductsModel.gzs;
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.interestrate)) {
		intentDict[@"interestrate"] = @"";
	}else{
		intentDict[@"interestrate"] = self.choosedProductsModel.interestrate;
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.totalCost)) {
		intentDict[@"totalExp"] = @"";
	}else{
		intentDict[@"totalExp"] = self.choosedProductsModel.totalCost;
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.ntzhbl)) {
		intentDict[@"investret"] = @"";
	}else{
		intentDict[@"investret"] = [NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ntzhbl floatValue]*100];;
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.ncpi)) {
		intentDict[@"cpi"] = @"";
	}else{
		intentDict[@"cpi"] = [NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.ncpi floatValue]*100];
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.tzhb)) {
		intentDict[@"investretRet"] = @"";
	}else{
		intentDict[@"investretRet"] = self.choosedProductsModel.tzhb;
	}
	if (IS_STRING_EMPTY(self.choosedProductsModel.zsy)) {
		intentDict[@"totalRet"] = @"";
	}else{
		intentDict[@"totalRet"] = self.choosedProductsModel.zsy;
	}
	intentDict[@"totalCost"] = self.choosedProductsModel.zfy;
	intentDict[@"idleFunds"] = [NSString stringWithFormat:@"%.2f",[self.choosedProductsModel.rzgm floatValue]/2];
	intentDict[@"expand"] = [NSString stringWithFormat:@"%.2f",([self.choosedProductsModel.rzgm floatValue]/2)*[self.choosedProductsModel.ncpi floatValue]];
	intentDict[@"insuState"] = @"0";
	intentDict[@"state"] = @"0";
	if (self.choosedProductsModel.isBxSelected && self.choosedProductsModel.isBxSelected) {
		intentDict[@"includeAmountType"] = @"01,02,03";
	}else if (self.choosedProductsModel.isGzsSelected) {
		intentDict[@"includeAmountType"] = @"01,02";
	}else if (self.choosedProductsModel.isBxSelected) {
		intentDict[@"includeAmountType"] = @"01,03";
	}else{
		intentDict[@"includeAmountType"] = @"01";
	}
	intentDict[@"carrzgm"] = self.choosedProductsModel.rzgm;
	intentDict[@"totalSave"] = @"";
	intentDict[@"createDate"] = [Tool getTimeFormatStr];
	intentDict[@"catModelDetailName"] = self.choosedProductsModel.catModelDetailName;
	
	[params setObject:intentDict forKey:@"Intent"];
	
	if ([netWork isEqualToString:@"1"]) {
		if (_delegate && ([_delegate respondsToSelector:@selector(removeVisibleViews)])) {
			[_delegate removeVisibleViews];
		}
	}else{
		[self.phud showHUDSaveAddedTo:self.view];
		[[CTTXRequestServer shareInstance]saveClientWithInfoDict:params
													SuccessBlock:^(NSDictionary * responseObject) {
														NSLog(@"存入客户%@",responseObject);
														[self.phud hideSave];
														NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
														if ([resultStr isEqualToString:@"1"]) {
															self.choosedProductsModel.customCardNumId = responseObject[@"customerId"];
															if (_delegate && ([_delegate respondsToSelector:@selector(removeVisibleViews)])) {
																[_delegate removeVisibleViews];
															}
														}else{
															[Tool showAlertViewWithString:@"网络状况不好,请稍后重试" withController:self];
														}
													} failedBlock:^(NSError *error) {
														[self.phud hideSave];
														self.phud.promptStr = @"网络状况不好...请稍后重试!";
														[self.phud showHUDResultAddedTo:self.view];
													}];
		
	}
}

#pragma mark - lazy load
-(NSArray *)headerTitleArray
{
	if (!_headerTitleArray) {
		_headerTitleArray = [NSArray arrayWithObjects:@"客户信息",@"材料准备",nil];
	}
	return _headerTitleArray;
}

-(NSArray *)titleArray
{
	if (!_titleArray) {
		if (![Tool isCustomerPersonTypeWithCustomerType:self.customerType]) {
			_titleArray = [NSArray arrayWithObjects:@"客户名称",@"性别",@"证件类型",@"证件号码",@"联系电话",nil];
		}else{
			_titleArray = [NSArray arrayWithObjects:@"企业联系人",@"性别",@"证件类型",@"证件号码",@"联系电话",@"企业名称",nil];
		}
	}
	return _titleArray;
}

-(NSMutableArray *)materialModelArr
{
	if (!_materialModelArr) {
		_materialModelArr = [NSMutableArray array];
	}
	return _materialModelArr;
}

-(NSMutableArray *)cardModelArr
{
	if (!_cardModelArr) {
		_cardModelArr = [NSMutableArray array];
	}
	return _cardModelArr;
}

-(NSMutableArray *)contentTextArr
{
	if (!_contentTextArr) {
		_contentTextArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"", nil];
	}
	return _contentTextArr;
}

-(HGBPromgressHud *)phud
{
	if(_phud==nil){
		_phud=[[HGBPromgressHud alloc]init];
	}
	return _phud;
}

@end
