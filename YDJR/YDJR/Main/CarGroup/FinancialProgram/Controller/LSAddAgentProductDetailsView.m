//
//  LSAddAgentProductDetailsView.m
//  YDJR
//
//  Created by 李爽 on 2016/11/15.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddAgentProductDetailsView.h"
#import "CTTXRequestServer+financialProgram.h"
#import "HGBPromgressHud.h"
#import "LSFPDetailCollectionViewCell.h"
#import "LSFPDetailHeaderCollectionReusableView.h"
#import "LSAgentProductsTemplateModel.h"
#import "LSFPSimplifyFooterCollectionReusableView.h"
#import "LSTextField.h"
#import "DetailListCellPopView.h"

#define CELL_ID      @"CELL_ID"
//#define EASY_CELL_ID      @"EASY_CELL_ID"
//#define EXTRA_CELL_ID      @"EXTRA_CELL_ID"

@interface LSAddAgentProductDetailsView ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,DetailListCellPopViewDelegate>
@property (nonatomic ,strong) HGBPromgressHud *phud;
/**
 底部灰色背景
 */
@property (nonatomic ,strong) UIView *grayBackGroundView;
/**
 模版modelArray
 */
@property (nonatomic ,strong) NSMutableArray *templateModelArray;
/**
 实际价格
 */
@property (nonatomic ,copy) NSString *actualPrice;
/**
 车型
 */
@property (nonatomic ,copy) NSString *carModelName;
/**
 选中按钮tag
 */
@property (nonatomic ,assign) NSInteger selectedButtonTag;
@end
@implementation LSAddAgentProductDetailsView

- (instancetype)initWithFrame:(CGRect)frame productID:(NSString *)productID actualPrice:(NSString *)actualPrice carModelName:(NSString *)carModelName productName:(NSString *)productName
{
	self = [super initWithFrame:frame];
	if (self) {
		self.productID = productID;
		self.actualPrice = actualPrice;
		self.carModelName = carModelName;
		[self obtainDataFromNet];
	}
	return self;
}

#pragma mark - p_setupView
- (void)p_setupView
{
	self.backgroundColor = [UIColor whiteColor];
	
	UIView *grayBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1408*wScale, 970*hScale)];
	grayBackGroundView.backgroundColor = [UIColor hexString:@"#FFF0F1F5"];
	[self addSubview:grayBackGroundView];
	
	UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
	layOut.minimumLineSpacing = 0;
	layOut.minimumInteritemSpacing = 0;//UICollectionView横向cell间距，会出现多10
	layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
	layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
	layOut.headerReferenceSize = CGSizeMake(grayBackGroundView.width, 112.0f *hScale);  //设置header大小
	layOut.footerReferenceSize = CGSizeMake(grayBackGroundView.width, 152.0f *hScale);
	self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, grayBackGroundView.width, grayBackGroundView.height) collectionViewLayout:layOut];
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	[self.collectionView registerClass:[LSFPDetailCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
	
	//注册header
	[self.collectionView registerClass:[LSFPDetailHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
	[self.collectionView registerClass:[LSFPSimplifyFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
	self.collectionView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
	
	[grayBackGroundView addSubview:self.collectionView];
	[self addSubview:grayBackGroundView];
	self.grayBackGroundView = grayBackGroundView;
}
/**
 从服务器获取模版信息
 */
-(void)obtainDataFromNet
{
	[self.phud showHUDSaveAddedTo:self];
	
	[[CTTXRequestServer shareInstance]checkAgentProductsTemplateInfoWithProductID:self.productID SuccessBlock:^(NSMutableArray *templateModelArray) {
		[self.phud hideSave];
		self.templateModelArray = templateModelArray;
		[self p_setupView];
		[self obtainDataFromNetAgainWithTemplateModelArray:self.templateModelArray];
	} failedBlock:^(NSError *error) {
		[self.phud hideSave];
		self.phud.promptStr = @"网络状况不好...请稍后重试!";
		[self.phud showHUDResultAddedTo:self];
	}];
}
/**
 从服务器获取模版信息后 立即计算
 */
-(void)obtainDataFromNetAgainWithTemplateModelArray:(NSMutableArray *)templateModelArray
{
	[self.phud showHUDSaveAddedTo:self];
	NSMutableDictionary *param = [NSMutableDictionary dictionary];
	NSMutableDictionary *productID = [NSMutableDictionary dictionary];
	productID[@"productID"] = self.productID;
	NSMutableDictionary *pro = [NSMutableDictionary dictionary];
	for (int i = 0; i < templateModelArray.count; i++) {
		LSAgentProductsTemplateModel *m = templateModelArray[i];
		if (IS_STRING_EMPTY(m.procolumdefaut)) {
			pro[m.procolumformula] = @"";
		}else{
			pro[m.procolumformula] = m.procolumdefaut;
		}
	}
	[pro removeObjectForKey:@""];
	pro[@"9"] = self.actualPrice;
	[param setObject:productID forKey:@"id"];
	[param setObject:pro forKey:@"pro"];
	
	//重复代码
	NSMutableArray *countResultArray = [NSMutableArray array];
	[[CTTXRequestServer shareInstance]countAgentProductsTemplateInfoWithRequestParam:param SuccessBlock:^(NSDictionary *responseDict) {
		if (responseDict) {
			[self.phud hideSave];
			for (int i = 0; i < templateModelArray.count; i++) {
				LSAgentProductsTemplateModel *m = templateModelArray[i];
				if (IS_STRING_NOT_EMPTY(m.procolumformula)) {
					if ([m.procolumdesc containsString:@"bili"]||[m.procolumdesc containsString:@"lilv"]) {
						[countResultArray addObject:[NSString stringWithFormat:@"%.2f",[responseDict[m.procolumformula] floatValue]*100]];
					}else{
						[countResultArray addObject:responseDict[m.procolumformula]];
					}
				}
			}
			self.countResultArray = countResultArray;
			
			for (int i = 0; i < templateModelArray.count; i++) {
				LSAgentProductsTemplateModel *m = templateModelArray[i];
				if (i == 0) {
					m.myProcolumdefaut = self.carModelName;
				}else{
					m.myProcolumdefaut = [countResultArray[i - 1] cutOutStringContainsDot];
				}
				[self.returnResultArray addObject:m];
			}
			[self.collectionView reloadData];

		}else{
			[self.phud hideSave];
			self.phud.promptStr = @"出错啦,请稍后重试";
			[self.phud showHUDResultAddedTo:self];
		}
	} failedBlock:^(NSError *error) {
		[self.phud hideSave];
		self.phud.promptStr = @"网络状况不好...请稍后重试!";
		[self.phud showHUDResultAddedTo:self];
	}];
}
/**
 计算
 */
- (void)obtainCountDataFromNet
{
	NSMutableArray *tempArray = [NSMutableArray array];
	for (UIView *subView in self.collectionView.subviews) {
		if ([subView isKindOfClass:[LSFPDetailCollectionViewCell class]]) {
			[tempArray addObject:@""];
			}
	}
	if (tempArray.count == self.templateModelArray.count) {
		//[tempArray removeLastObject];
		//for (int i = 0; i < tempArray.count; i ++) {
			for (UIView *subView in self.collectionView.subviews) {
				if ([subView isKindOfClass:[LSFPDetailCollectionViewCell class]]) {
					LSFPDetailCollectionViewCell *cell = (LSFPDetailCollectionViewCell *)subView;
					[tempArray replaceObjectAtIndex:cell.conditionTextField.tag withObject:cell.conditionTextField.text];
					[tempArray replaceObjectAtIndex:cell.conditionButton.tag withObject:cell.conditionTextField.text];
				}
			}
		//}
	}
	//[tempArray removeObjectAtIndex:0];
	[self.phud showHUDSaveAddedTo:self];
	NSMutableDictionary *param = [NSMutableDictionary dictionary];
	NSMutableDictionary *productID = [NSMutableDictionary dictionary];
	productID[@"productID"] = self.productID;
	NSMutableDictionary *pro = [NSMutableDictionary dictionary];
	for (int i = 0; i < self.templateModelArray.count; i++) {
		LSAgentProductsTemplateModel *m = self.templateModelArray[i];
		if (IS_STRING_NOT_EMPTY(m.procolumformula)) {
			NSString *procolumdefautString = nil;
			procolumdefautString = tempArray[i];
			if (IS_STRING_EMPTY(procolumdefautString)) {
				procolumdefautString = @"";
			}
			if ([m.procolumdesc containsString:@"bili"]||[m.procolumdesc containsString:@"lilv"]) {
				if (![m.procolumpre isEqualToString:@"2"]) {
					if (m.procolumdefautArray.count > 1) {
						NSMutableArray *tempArr = [NSMutableArray array];
						for (NSDictionary *dict in m.procolumdefautArray) {
							[tempArr addObject:dict[@"v"]];
						}
						float MinValue = [[tempArr firstObject] floatValue];
						float MaxValue = [[tempArr lastObject] floatValue];
						if ([tempArray[i] floatValue] > MaxValue || [tempArray[i] floatValue] < MinValue) {
							self.phud.promptStr = @"您输入的数值超过合理范围";
							[self.phud showHUDResultAddedTo:self];
							return;
						}
					}
				}
				pro[m.procolumformula] = [NSString stringWithFormat:@"%.2f",[procolumdefautString floatValue]/100];
			}else{
				pro[m.procolumformula] = procolumdefautString;
			}
			//NSLog(@"测试%@",procolumdefautString);
			//pro[m.procolumformula] = procolumdefautString;
			//NSLog(@"XXX%@---%@",m.procolumformula,procolumdefautString);
		}
	}
	[pro removeObjectForKey:@""];
	pro[@"9"] = self.actualPrice;
	[param setObject:productID forKey:@"id"];
	[param setObject:pro forKey:@"pro"];
	
	//重复代码
	NSMutableArray *countResultArray = [NSMutableArray array];
	[[CTTXRequestServer shareInstance]countAgentProductsTemplateInfoWithRequestParam:param SuccessBlock:^(NSDictionary *responseDict) {
		if (responseDict) {
			[self.phud hideSave];
			for (int i = 0; i < self.templateModelArray.count; i++) {
				LSAgentProductsTemplateModel *m = self.templateModelArray[i];
				if (IS_STRING_NOT_EMPTY(m.procolumformula)) {
					if ([m.procolumdesc containsString:@"bili"]||[m.procolumdesc containsString:@"lilv"]) {
						[countResultArray addObject:[NSString stringWithFormat:@"%.2f",[responseDict[m.procolumformula] floatValue]*100]];
					}else{
						[countResultArray addObject:responseDict[m.procolumformula]];
					}
					//[countResultArray addObject:responseDict[m.procolumformula]];
				}
			}
			self.countResultArray = countResultArray;
			self.returnResultArray = nil;
			for (int i = 0; i < self.templateModelArray.count; i++) {
				LSAgentProductsTemplateModel *m = self.templateModelArray[i];
				if (i == 0) {
					m.myProcolumdefaut = self.carModelName;
				}else{
					m.myProcolumdefaut = [countResultArray[i - 1] cutOutStringContainsDot];
				}
				[self.returnResultArray addObject:m];
			}
			[self.collectionView reloadData];

		}else{
			[self.phud hideSave];
			self.phud.promptStr = @"出错啦,请稍后重试";
			[self.phud showHUDResultAddedTo:self];
		}
	} failedBlock:^(NSError *error) {
		[self.phud hideSave];
		self.phud.promptStr = @"网络状况不好...请稍后重试!";
		[self.phud showHUDResultAddedTo:self];
	}];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.templateModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	LSFPDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
	LSAgentProductsTemplateModel *m = self.templateModelArray[indexPath.row];
	cell.conditionTilteLabel.text = m.procolumname;
	cell.conditionTextField.tag = indexPath.row;
	cell.conditionTextField.delegate = self;
	cell.conditionButton.tag = indexPath.row;
	
	if ([m.procolumpre isEqualToString:@"2"]) {
		cell.conditionButton.hidden = NO;
		cell.conditionTextField.hidden = YES;
	}else{
		cell.conditionButton.hidden = YES;
		cell.conditionTextField.hidden = NO;
	}
	
	if (self.countResultArray) {
		if (!(indexPath.row == 0)) {
			NSString *contentString = self.countResultArray[indexPath.row - 1];
			cell.conditionTextField.text = [contentString cutOutStringContainsDot];
			[cell.conditionButton setTitle:[contentString cutOutStringContainsDot] forState:UIControlStateNormal];
			}else{
			cell.conditionTextField.text = self.carModelName;
		}
	}else{
		if (m.procolumdefautArray.count > 0) {
			NSDictionary *procolumdefautdict = [m.procolumdefautArray firstObject];
			cell.conditionTextField.text = procolumdefautdict[@"v"];
		}
	}
	cell.moneyTitleLabel.hidden = YES;
	cell.moneyLabel.hidden = YES;
	[cell.conditionButton addTarget:self action:@selector(showDetailListCellPopViewWithButton:) forControlEvents:UIControlEventTouchUpInside];
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake(self.grayBackGroundView.width/4,180*hScale);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
		LSFPDetailHeaderCollectionReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
		reusableView.headerTitleLabel.text = @"金融方案详情";
		return reusableView;
	}else{
		LSFPSimplifyFooterCollectionReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
		reusableView.packUpBtn.hidden = YES;
		reusableView.countButton.hidden = NO;
		[reusableView.countButton addTarget:self action:@selector(obtainCountDataFromNet) forControlEvents:UIControlEventTouchUpInside];
		return reusableView;
	}
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	LSAgentProductsTemplateModel *m = self.templateModelArray[textField.tag];
	if ([m.procolumpre isEqualToString:@"2"]||[m.procolumpre isEqualToString:@"0"]||[m.procolumpre isEqualToString:@"3"]) {
		return NO;
	}else{
		return YES;
	}
}

#pragma mark - DetailListCellPopViewDelegate
- (void)sendMessageWithMessage:(NSString *)messge
{
	[self.countResultArray replaceObjectAtIndex:self.selectedButtonTag - 1 withObject:messge];
	[self.collectionView reloadData];
}
/**
 弹出下拉列表

 @param button 被点击的按钮
 */
-(void)showDetailListCellPopViewWithButton:(UIButton *)button
{
	self.selectedButtonTag = button.tag;
	LSAgentProductsTemplateModel *m = self.templateModelArray[button.tag];
	CGRect originInSuperview = [self.collectionView.window convertRect:button.bounds fromView:button];
	NSMutableArray *tempArr = [NSMutableArray array];
	for (NSDictionary *dict in m.procolumdefautArray) {
		[tempArr addObject:dict[@"v"]];
	}
	DetailListCellPopView *detailListCellPopView = [[DetailListCellPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds] ListFrame:originInSuperview listArr:tempArr isOtherTitle:NO];
	detailListCellPopView.delegate = self;
	[detailListCellPopView showPopView];
}

#pragma mark - lazy load
-(HGBPromgressHud *)phud
{
	if(_phud==nil){
		_phud=[[HGBPromgressHud alloc]init];
	}
	return _phud;
}

- (NSMutableArray *)templateModelArray
{
	if (!_templateModelArray) {
		_templateModelArray = [NSMutableArray array];
	}
	return _templateModelArray;
}
- (NSMutableArray *)returnResultArray
{
	if (!_returnResultArray) {
		_returnResultArray = [NSMutableArray array];
	}
	return _returnResultArray;
}
@end
