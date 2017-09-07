//
//  LSAddProgramViewController.m
//  YDJR
//
//  Created by 李爽 on 2016/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddProgramViewController.h"
#import "LSFPSimplifyCollectionViewCell.h"
#import "LSFinancialProductsModel.h"
#import "LSChoosedProductsModel.h"
#import "LLFCarModel.h"
#import "CTTXRequestServer+financialProgram.h"
#import "LSFPSimplifyHeaderCollectionReusableView.h"
#import "LSFPSimplifyFooterCollectionReusableView.h"
#import "LSUniversalAlertView.h"
#import "LSAddNonAgentProductInputView.h"

#define CELL_ID      @"CELL_ID"
@interface LSAddProgramViewController ()<LSAddNonAgentProductInputViewDelegate>
/**
 金融方案collectionView
 */
@property (nonatomic,strong)UICollectionView *financialProgramView;
/**
 关闭button
 */
@property (nonatomic,strong)UIButton *closeButton;
/**
 确认方案button
 */
@property (nonatomic,strong)UIButton *confirmProgramButton;
/**
 所选中的金融产品的ID
 */
@property (nonatomic,copy)NSString *selectedProductID;
/**
 非自营产品modelArray
 */
@property (nonatomic,copy)NSMutableArray *agentProductModelArray;
/**
 自营产品modelArray
 */
@property (nonatomic,copy)NSMutableArray *nonAgentProductModelArray;
/**
 提示控件
 */
@property (nonatomic,strong)HGBPromgressHud *phud;
/**
 更多产品button
 */
@property (nonatomic, strong) UIButton *morePlanButton;
/**
 无数据view
 */
@property (nonatomic, strong) UIView *noDataView;
/**
 金融产品model
 */
@property (nonatomic, strong) LSFinancialProductsModel *productsModel;
/**
 是否点击确认方案
 */
@property (nonatomic)BOOL isDeselect;

@property (nonatomic,strong)UIView *backGroundView;
@property (nonatomic,strong)UIView *bgSubView;
@property (nonatomic,strong)LSAddNonAgentProductInputView *inputView;

@property (nonatomic,strong)NSArray *nonAgentProductBGImageNameArr;
@property (nonatomic,strong)NSArray *agentProductBGImageNameArr;
@end

@implementation LSAddProgramViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self p_setupView];
	[self obtainDataFromNet];
}

#pragma mark - p_setupView
- (void)p_setupView
{
	//self.view.backgroundColor = [UIColor hexString:@"#4D000000"];
	
	LSUniversalAlertView *universalAlertView = [[LSUniversalAlertView alloc]initWithFrame:CGRectMake(0, 40 * hScale, kWidth, kHeight - 40 * hScale)];
	[universalAlertView.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
	[universalAlertView.closeButton addTarget:self action:@selector(closeTheAddProgramView) forControlEvents:UIControlEventTouchUpInside];
	self.closeButton = universalAlertView.closeButton;
	universalAlertView.titleLabel.text = @"添加金融方案";
	[universalAlertView.rightButton setTitle:@"确认方案" forState:UIControlStateNormal];
	[universalAlertView.rightButton addTarget:self action:@selector(deselectconfirmProgramButton) forControlEvents:UIControlEventTouchUpInside];
	self.confirmProgramButton = universalAlertView.rightButton;
	self.confirmProgramButton.hidden = YES;
	
	//请选择一个金融方案
	UILabel *tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 130 * hScale, 224*wScale, 24*hScale)];
	tipsLabel.text = @"请选择一个金融方案";
	tipsLabel.font = [UIFont systemFontOfSize:12];
	tipsLabel.textColor = [UIColor hexString:@"#FF666666"];
	[universalAlertView addSubview:tipsLabel];
	
	//金融方案
	UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
	layOut.sectionInset = UIEdgeInsetsMake(32*wScale, 32*hScale, 24*wScale, 24*hScale);
	layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
	self.financialProgramView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 154 * hScale, universalAlertView.frame.size.width, universalAlertView.height - 178 * hScale) collectionViewLayout:layOut];
	self.financialProgramView.delegate = self;
	self.financialProgramView.dataSource = self;
	[self.financialProgramView registerClass:[LSFPSimplifyHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"header"];
	[self.financialProgramView registerClass:[LSFPSimplifyFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
	[self.financialProgramView registerClass:[LSFPSimplifyCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
	self.financialProgramView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
	
	[universalAlertView addSubview:self.financialProgramView];
	[self.view addSubview:universalAlertView];
	self.backGroundView = universalAlertView;
}

#pragma mark - obtainDataFromNet
-(void)obtainDataFromNet
{
	[self.phud showHUDSaveAddedTo:self.financialProgramView];
	[[CTTXRequestServer shareInstance]checkProductsWithCatModelDetailID:self.carModel.carPpName SuccessBlock:^(NSMutableArray *productsModelArr) {
		[self.phud hideSave];
		if (productsModelArr.count == 0) {
			[self.backGroundView addSubview:self.noDataView];
			return;
		}
		
		for (LSFinancialProductsModel *m in productsModelArr) {
			if ([m.productState isEqualToString:@"2"]) {
				[self.agentProductModelArray addObject:m];
			}else{
				[self.nonAgentProductModelArray addObject:m];
			}
		}
		
		[self.financialProgramView reloadData];
	} failedBlock:^(NSError *error) {
		[self.phud hideSave];
		self.phud.promptStr = @"网络状况不好...请稍后重试!";
		[self.phud showHUDResultAddedTo:self.financialProgramView];
	}];
}

#pragma mark - 关闭添加金融产品view
-(void)closeTheAddProgramView
{
	if ([self.closeButton.titleLabel.text isEqualToString:@"关闭"]) {
		[self.view removeFromSuperview];
	} else {
		[self.backGroundView sendSubviewToBack:self.bgSubView];
		[self.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
		self.confirmProgramButton.hidden = YES;
	}
}

///**
// 点击确认更多方案按钮
// */
//-(void)deselectconfirmProgramButton
//{
//	self.isDeselect = YES;
//	[self.view removeFromSuperview];
//	
//	if (self.isDeselect == NO) {
//		return;
//	}
//	
//	if ([self.selectedProductID isEqualToString:self.addNonAgentProductDetailsView.choosedProductsModel.productID]) {
//		if (_delegate && ([_delegate respondsToSelector:@selector(popToFinancialProgramViewControllerWithChoosedProductsModel:)])) {
//			[_delegate popToFinancialProgramViewControllerWithChoosedProductsModel:self.addNonAgentProductDetailsView.choosedProductsModel];
//		}
//	}
//}

#pragma mark - 展开更多方案
-(void)showMoreProduct:(UIButton *)sender
{
	sender.selected = !sender.selected;
	[self.financialProgramView reloadData];
}

#pragma mark - 收起更多方案
-(void)closeMoreProduct:(UIButton *)sender
{
	self.morePlanButton.selected = NO;
	[self.financialProgramView reloadData];
}

#pragma mark - inputView的代理方法
-(void)removeAddProgramViewAfterAddNonAgentProductInputViewDisAppear
{
	self.isDeselect = YES;
	[self.view removeFromSuperview];
	
	if (self.isDeselect == NO) {
		return;
	}
	
	if ([self.selectedProductID isEqualToString:self.inputView.choosedProductsModel.productID]) {
		if (_delegate && ([_delegate respondsToSelector:@selector(popToFinancialProgramViewControllerWithChoosedProductsModel:)])) {
			[_delegate popToFinancialProgramViewControllerWithChoosedProductsModel:self.inputView.choosedProductsModel];
		}
	}
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return self.morePlanButton.selected ? 2 : 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return section == 1 ? self.agentProductModelArray.count : self.nonAgentProductModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	LSFPSimplifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
	if (indexPath.section == 0) {
		LSFinancialProductsModel *m = self.nonAgentProductModelArray[indexPath.row];
		cell.programTitleLabel.text = m.productName;
        NSString *imageName = [self.nonAgentProductBGImageNameArr objectAtIndex:indexPath.row % 4];
        cell.bgView.image = [UIImage imageNamed:imageName];
//		if ([m.productID isEqualToString:@"1"]) {
//			cell.bgView.image = [UIImage imageNamed:@"bg_pressed_rongzizulinbiaozhunchanpin"];
//		}
//		if ([m.productID isEqualToString:@"2"]) {
//			cell.bgView.image = [UIImage imageNamed:@"bg_pressed_kaixinche"];
//		}
//		if ([m.productID isEqualToString:@"21"]) {
//			cell.bgView.image = [UIImage imageNamed:@"bg_pressed_rongzizulinbaozhengjinchanpin"];
//		}
//		if ([m.productID isEqualToString:@"22"]) {
//			cell.bgView.image = [UIImage imageNamed:@"bg_pressed_rongzizulintiexichanpin"];
//		}
	}else{
		LSFinancialProductsModel *m = self.agentProductModelArray[indexPath.row];
		cell.programTitleLabel.text = m.productName;
        NSString *imageName = [self.agentProductBGImageNameArr objectAtIndex:indexPath.row % 4];
        cell.bgView.image = [UIImage imageNamed:imageName];
//		if ([m.productID isEqualToString:@"20"]) {
//			cell.bgView.image = [UIImage imageNamed:@"bg_pressed_yinhangdaikuan"];
//		}
//		if ([m.productID isEqualToString:@"23"]) {
//			cell.bgView.image = [UIImage imageNamed:@"bg_pressed_baomajinrongtiexi"];
//		}
//		if ([m.productID isEqualToString:@"24"]) {
//			cell.bgView.image = [UIImage imageNamed:@"bg_pressed_baomaweikuantiexi"];
//		}
	}
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake(472 * wScale,200 * hScale);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	if ([kind isEqualToString:@"UICollectionElementKindSectionFooter"]) {
		if (indexPath.section == 0) {
			LSFPSimplifyHeaderCollectionReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
			[reusableView.morePlanBtn addTarget:self action:@selector(showMoreProduct:) forControlEvents:UIControlEventTouchUpInside];
			self.morePlanButton = reusableView.morePlanBtn;
			return reusableView;
		}else{
			LSFPSimplifyFooterCollectionReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
			reusableView.packUpBtn.hidden = NO;
			[reusableView.packUpBtn addTarget:self action:@selector(closeMoreProduct:) forControlEvents:UIControlEventTouchUpInside];
			return reusableView;
		}
	}
	return nil;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
	CGSize size = {1408*wScale, 56.0f *hScale};
	return size;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		self.productsModel = self.nonAgentProductModelArray[indexPath.row];
	}else{
		self.productsModel = self.agentProductModelArray[indexPath.row];
	}
	self.productsModel.suggestedRetailPrice = self.carModel.catModelDetailPrice;
	self.productsModel.insurance = nil;
	//self.addNonAgentProductDetailsView = [[LSAddNonAgentProductDetailsView alloc]initWithFrame:CGRectMake(0, 98*hScale, 1408*wScale, 968*hScale) productModel:self.productsModel actualPrice:self.realPrice productDict:self.productsModel.productDict];
	//[self.backGroundView addSubview:self.addNonAgentProductDetailsView];
	//self.bgSubView = self.addNonAgentProductDetailsView;
	
	self.productsModel.purchaseTax = self.purchaseTax;
	self.productsModel.insurance = self.insurance;
	LSAddNonAgentProductInputView *inputView = [[LSAddNonAgentProductInputView alloc]initWithFrame:CGRectMake(0, - 40 *hScale, kWidth, kHeight) productModel:self.productsModel realPrice:self.realPrice productDict:self.productsModel.productDict];
	inputView.backgroundColor = [UIColor hexString:@"#4D000000"];
	inputView.delegate = self;
	[self transitionWithType:@"rippleEffect" WithSubtype:@"kCATransitionFromLeft" ForView:self.view];
	//break;
	[self.backGroundView addSubview:inputView];
	self.bgSubView = inputView;
	self.inputView = inputView;
	
	self.selectedProductID = self.productsModel.productID;
	
	//[self.closeButton setTitle:@"返回" forState:UIControlStateNormal];
	//self.confirmProgramButton.hidden = NO;
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

#pragma mark - lazy load
-(HGBPromgressHud *)phud
{
	if(_phud == nil){
		_phud = [[HGBPromgressHud alloc]init];
	}
	return _phud;
}

-(NSMutableArray *)agentProductModelArray
{
	if (!_agentProductModelArray) {
		_agentProductModelArray = [NSMutableArray array];
	}
	return _agentProductModelArray;
}

-(NSMutableArray *)nonAgentProductModelArray
{
	if (!_nonAgentProductModelArray) {
		_nonAgentProductModelArray = [NSMutableArray array];
	}
	return _nonAgentProductModelArray;
}

- (UIView *)noDataView {
	if (_noDataView == nil) {
		_noDataView = [[UIView alloc] initWithFrame:CGRectMake(0, 98*hScale, kWidth, kHeight - 324*hScale)];
		_noDataView.backgroundColor = [UIColor whiteColor];
		
		UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 114/2, 101/2)];
		imgView.image = [UIImage imageNamed:@"icon_wushuju"];
		
		imgView.center = CGPointMake(_noDataView.width/2, _noDataView.height/2);
		
		UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame) + 48 * hScale, _noDataView.width, 36 * hScale)];
		titleLabel.text = @"暂无更多数据";
		titleLabel.textColor = [UIColor hexString:@"#FFABADB3"];
		titleLabel.font = [UIFont systemFontOfSize:18.0];
		titleLabel.textAlignment = NSTextAlignmentCenter;
		[_noDataView addSubview:imgView];
		[_noDataView addSubview:titleLabel];
	}
	return _noDataView;
}
- (NSArray *)nonAgentProductBGImageNameArr
{
    if (!_nonAgentProductBGImageNameArr) {
        _nonAgentProductBGImageNameArr = @[@"bg_pressed_rongzizulinbiaozhunchanpin",@"bg_pressed_kaixinche",@"bg_pressed_rongzizulinbaozhengjinchanpin",@"bg_pressed_rongzizulintiexichanpin"];
    }
    return _nonAgentProductBGImageNameArr;
}
- (NSArray *)agentProductBGImageNameArr
{
    if (!_agentProductBGImageNameArr) {
        _agentProductBGImageNameArr = @[@"bg_pressed_yinhangdaikuan",@"bg_pressed_baomajinrongtiexi",@"bg_pressed_baomaweikuantiexi"];
    }
    return _agentProductBGImageNameArr;
}
@end
