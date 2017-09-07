//
//  AgentProductLetterOfIntentViewController.m
//  YDJR
//
//  Created by 李爽 on 2016/11/17.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "AgentProductLetterOfIntentViewController.h"
#import "LSFPDetailHeaderCollectionReusableView.h"
#import "LSLetterofIntentCollectionViewCell.h"
#import "LSInfoInputViewController.h"
#import "LSChoosedProductsModel.h"
#import <YYText.h>
#import "LSUniversalAlertView.h"
#import "LSAgentProductsTemplateModel.h"
#import "LSLetterofIntentWideCollectionViewCell.h"

#define CELL_ID      @"CELL_ID"
#define WIDECELL_ID      @"WIDECELL_ID"
@interface AgentProductLetterOfIntentViewController ()<LSInfoInputViewControllerDelegate>
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *bgSubView;/** 提交意向单界面*/
@property (nonatomic,strong)UIButton *closeBtn;/** 关闭按钮*/
@property (nonatomic,strong)UICollectionView *letterofIntentView;
@property (nonatomic,strong)UIView *grayView;/** 小灰色背景*/
@property (nonatomic,assign) BOOL isAgreeProtocol;/** 是否同意协议*/
@property (nonatomic,strong)NSArray *headerTitleArray;/** header标题Arr*/
@property (nonatomic,strong)NSMutableArray *titleArray;/** 意向单标题*/
@property (nonatomic,strong)NSMutableArray *contentArray;/** 意向单内容*/
@property (nonatomic,strong)UILabel *addProgramLabel;/** 导航栏标题*/
@end

@implementation AgentProductLetterOfIntentViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self p_setupView];
	self.isAgreeProtocol = YES;
}

#pragma mark - lazy load
-(NSArray *)headerTitleArray
{
	if (!_headerTitleArray) {
		_headerTitleArray = @[@"车型信息",@"产品信息"];
	}
	return _headerTitleArray;
}

-(NSMutableArray *)titleArray
{
	if (!_titleArray) {
		NSMutableArray *tempArray = [NSMutableArray array];
		for (LSAgentProductsTemplateModel *m in self.returnResultArray) {
			[tempArray addObject:m.procolumname];
			if ([m.procolumdesc isEqualToString:@"chexing"]) {
				[tempArray removeObject:m.procolumname];
			}
		}
		[tempArray addObject:@"保险(元)"];
		[tempArray addObject:@"实际购车成本(元)"];
		_titleArray = [NSMutableArray array];
		[_titleArray addObject:@[@"车辆品牌",@"车辆型号"]];
		[_titleArray addObject:tempArray];
	}
	return _titleArray;
}

-(NSMutableArray *)contentArray
{
	if (!_contentArray) {
		NSMutableArray *tempArray = [NSMutableArray array];
		for (LSAgentProductsTemplateModel *m in self.returnResultArray) {
			[tempArray addObject:m.myProcolumdefaut];
			if ([m.procolumdesc isEqualToString:@"chexing"]) {
				[tempArray removeObject:m.myProcolumdefaut];
			}
		}
		[tempArray addObject:self.choosedProductsModel.insurance];
		[tempArray addObject:self.choosedProductsModel.khsjgccb];
		_contentArray = [NSMutableArray array];
		[_contentArray addObject:@[self.choosedProductsModel.carPpName,self.choosedProductsModel.carModelName]];
		[_contentArray addObject:tempArray];
	}
	return _contentArray;
}

#pragma mark - p_setupView
- (void)p_setupView
{
	self.view.backgroundColor = [UIColor hexString:@"#4D000000"];
	LSUniversalAlertView *universalAlertView = [[LSUniversalAlertView alloc]initWithFrame:CGRectMake(128*wScale, 277*hScale, 1780*wScale, 1060*hScale)];
	[universalAlertView.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
	[universalAlertView.closeButton addTarget:self action:@selector(closeTheAddProgramView) forControlEvents:UIControlEventTouchUpInside];
	self.closeBtn = universalAlertView.closeButton;
	universalAlertView.titleLabel.text = @"购车意向确认单";
	self.addProgramLabel = universalAlertView.titleLabel;
	
	//小灰色背景
	UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 98*hScale, universalAlertView.width, 962*hScale)];
	grayView.backgroundColor = [UIColor hexString:@"#FFF0F1F5"];
	
	//购车意向确认单
	UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
	layOut.minimumLineSpacing = 0;
	layOut.minimumInteritemSpacing = 0;//UICollectionView横向cell间距，会出现多10
	layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
	layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
	layOut.headerReferenceSize = CGSizeMake(grayView.width, 112.0f*hScale);  //设置header大小
	self.letterofIntentView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, grayView.width, grayView.height - 152*hScale) collectionViewLayout:layOut];
	self.letterofIntentView.delegate = self;
	self.letterofIntentView.dataSource = self;
	[self.letterofIntentView registerClass:[LSLetterofIntentWideCollectionViewCell class] forCellWithReuseIdentifier:WIDECELL_ID];
	[self.letterofIntentView registerClass:[LSLetterofIntentCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
	//注册headerletterofIntentView
	[self.letterofIntentView registerClass:[LSFPDetailHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
	self.letterofIntentView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
	//self.letterofIntentView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
	
	[grayView addSubview:self.letterofIntentView];
	[universalAlertView addSubview:grayView];
	[self.view addSubview:universalAlertView];
	self.grayView = grayView;
	
	//底部栏
	UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, grayView.height - 152*hScale, grayView.width, 152*hScale)];
	barView.backgroundColor = [UIColor hexString:@"#FFFFFF"];
	
	//分割线
	UIView *cuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, hScale)];
	cuttingLine.backgroundColor = [UIColor hex:@"#F0D9D9D9"];
	[barView addSubview:cuttingLine];
	
	//勾选按钮
	UIButton *checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(48*wScale, 56*hScale, 40*wScale, 40*hScale)];
	[checkBtn setImage:[UIImage imageNamed:@"icon_normal_agree"] forState:UIControlStateNormal];
	[checkBtn setImage:[UIImage imageNamed:@"icon_pressed_agree"] forState:UIControlStateSelected];
	checkBtn.selected = YES;
	[checkBtn addTarget:self action:@selector(desectCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
	//[barView addSubview:checkBtn];
	
	////协议label
	//YYLabel *protocolLabel = [[YYLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(checkBtn.frame) + 16*wScale, 56*hScale, 600*wScale, 40*hScale)];
	//NSMutableAttributedString *protocolText = [[NSMutableAttributedString alloc] initWithString:@"我已告知客户《客户服务协议》中详细信息"];
	//[protocolText setYy_color:[UIColor hex:@"#FF999999"]];
	//[protocolText setYy_font:[UIFont systemFontOfSize:14]];
	//[protocolText yy_setTextHighlightRange:NSMakeRange(6, 8)
	//                                 color:[UIColor hex:@"#FF148FF5"]
	//                       backgroundColor:nil
	//                             tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
	//                                 NSLog(@"--");
	//                                 self.addProgramLabel.text = @"客户服务协议";
	//                                 LSUserServerProtocolViewController *vc = [[LSUserServerProtocolViewController alloc]init];
	//                                 vc.view.frame = CGRectMake(0, 0, self.grayView.width, self.grayView.height);
	//                                 [self.closeBtn setTitle:@"返回" forState:UIControlStateNormal];
	//                                 [self.grayView addSubview:vc.view];
	//                                 self.bgSubView = vc.view;
	//                                 [self addChildViewController:vc];
	//                             }];
	//protocolLabel.attributedText = protocolText;
	//[barView addSubview:protocolLabel];
	
	//录入客户信息
	UIButton *userInfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(barView.width - 288*wScale, 0, 288*wScale, 152*hScale)];
	[userInfoBtn setTitle:@"录入客户信息" forState:UIControlStateNormal];
	userInfoBtn.titleLabel.font = [UIFont systemFontOfSize:17.5];
	userInfoBtn.backgroundColor = [UIColor hex:@"#FC5A5A"];
	[userInfoBtn addTarget:self action:@selector(showInfoInputViewController) forControlEvents:UIControlEventTouchUpInside];
	[barView addSubview:userInfoBtn];
	
	[grayView addSubview:barView];
}

-(void)closeTheAddProgramView
{
	if ([self.closeBtn.titleLabel.text isEqualToString:@"关闭"]) {
		[self.view removeFromSuperview];
	} else {
		[self.grayView sendSubviewToBack:self.bgSubView];
		[self.closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
		self.addProgramLabel.text = @"购车意向确认单";
	}
}

#pragma mark - 勾选客服服务协议
-(void)desectCheckBtn:(UIButton*)sender{
	sender.selected = !sender.selected;
	self.isAgreeProtocol = sender.selected;
}

#pragma mark - LSInfoInputViewControllerDelegate
-(void)removeVisibleViews
{
	if (_delegate && ([_delegate respondsToSelector:@selector(pushToCustomerManagerControllerAgent)])) {
		[_delegate pushToCustomerManagerControllerAgent];
	}
	[self.view removeFromSuperview];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	if (section == 0) {
		return 2;
	}else {
		return self.returnResultArray.count + 1;
	}
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1) {
		LSLetterofIntentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
		cell.nameLabel.text = self.titleArray[indexPath.section][indexPath.row];
		NSString *tempString = self.contentArray[indexPath.section][indexPath.row];
		cell.contentLabel.text = [tempString cut];
		return cell;
	} else {
		LSLetterofIntentWideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WIDECELL_ID forIndexPath:indexPath];
		cell.nameLabel.text = self.titleArray[indexPath.section][indexPath.row];
		cell.contentLabel.text = self.contentArray[indexPath.section][indexPath.row];
		return cell;
	}
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		return CGSizeMake(self.grayView.width/2,208*hScale);
	}else{
		return CGSizeMake(self.grayView.width/4,208*hScale);
	}
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
		LSFPDetailHeaderCollectionReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
		reusableView.headerTitleLabel.text = self.headerTitleArray[indexPath.section];
		return reusableView;
	}
	return nil;
}

#pragma mark - 录入客服信息
-(void)showInfoInputViewController
{
	if (self.isAgreeProtocol == NO) {
		[Tool showAlertViewWithString:@"您还没有勾选客户协议" withController:self];
		return;
	}
	UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择客户类型" message:nil preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
		
	}];
	UIAlertAction *personNal = [UIAlertAction actionWithTitle:@"个人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self showSaveUserViewControllerWithTypeID:@"02"];
	}];
	UIAlertAction *enterprise = [UIAlertAction actionWithTitle:@"企业" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		[self showSaveUserViewControllerWithTypeID:@"01"];
	}];
	[alert addAction:personNal];
	[alert addAction:enterprise];
	[alert addAction:cancel];
	[self presentViewController:alert animated:YES completion:nil];
}

-(void)showSaveUserViewControllerWithTypeID:(NSString *)typeID
{
	self.addProgramLabel.text = @"客户信息录入";
	LSInfoInputViewController *vc = [[LSInfoInputViewController alloc]init];
	vc.customerType =  typeID;
	vc.choosedProductsModel = self.choosedProductsModel;
	vc.delegate = self;
	vc.view.frame = CGRectMake(0, 0, self.grayView.width, self.grayView.height);
	[self.closeBtn setTitle:@"返回" forState:UIControlStateNormal];
	[self.grayView addSubview:vc.view];
	self.bgSubView = vc.view;
	[self addChildViewController:vc];
}

//#pragma mark - 录入客服信息
//-(void)showInfoInputViewController
//{
//	if (self.isAgreeProtocol == NO) {
//		[Tool showAlertViewWithString:@"您还没有勾选客户协议" withController:self];
//		return;
//	}
//	self.addProgramLabel.text = @"客户信息录入";
//	LSInfoInputViewController *vc = [[LSInfoInputViewController alloc]init];
//	vc.choosedProductsModel = self.choosedProductsModel;
//	vc.delegate = self;
//	vc.view.frame = CGRectMake(0, 0, self.grayView.width, self.grayView.height);
//	[self.closeBtn setTitle:@"返回" forState:UIControlStateNormal];
//	[self.grayView addSubview:vc.view];
//	self.bgSubView = vc.view;
//	[self addChildViewController:vc];
//}

@end
