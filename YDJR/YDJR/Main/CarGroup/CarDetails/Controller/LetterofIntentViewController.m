//
//  LetterofIntentViewController.m
//  YDJR
//
//  Created by 李爽 on 2016/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LetterofIntentViewController.h"
#import "LSFPDetailHeaderCollectionReusableView.h"
#import "LSLetterofIntentCollectionViewCell.h"
#import "LSInfoInputViewController.h"
#import "TTTAttributedLabel.h"
#import "LSChoosedProductsModel.h"
#import "YYText.h"
#import "LSUniversalAlertView.h"
#import "LSLetterofIntentWideCollectionViewCell.h"
#import "LSLetterofIntentTableViewCell.h"
#define CELL_ID      @"CELL_ID"
//#define WIDECELL_ID      @"WIDECELL_ID"
@interface LetterofIntentViewController ()<LSInfoInputViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *bgSubView;/** 提交意向单界面*/
@property (nonatomic,strong)UIButton *closeBtn;/** 关闭按钮*/
@property (nonatomic,strong)UICollectionView *letterofIntentView;
@property (nonatomic,strong)UIView *grayView;/** 小灰色背景*/
@property (nonatomic,assign) BOOL isAgreeProtocol;/** 是否同意协议*/
@property (nonatomic,copy)NSArray *headerTitleArray;/** header标题Arr*/
@property (nonatomic,copy)NSArray *titleArray;/** 意向单标题*/
@property (nonatomic,copy)NSArray *contentArray;/** 意向单内容*/
@property (nonatomic,strong)UILabel *addProgramLabel;/** 导航栏标题*/
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *lightGrayView;
@property (nonatomic,copy)NSMutableDictionary *userTypeDic;

@end

@implementation LetterofIntentViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self p_setupView];
	self.isAgreeProtocol = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	[self transitionWithType:@"rippleEffect" WithSubtype:@"kCATransitionFromLeft" ForView:self.view];
}

#pragma mark - lazy load
-(NSArray *)headerTitleArray
{
	if (!_headerTitleArray) {
		_headerTitleArray = @[@[@"车型信息"],@[@"支出费用"],@[@"享受的利益"]];
	}
	return _headerTitleArray;
}

-(NSArray *)titleArray
{
	if (!_titleArray) {
		_titleArray = @[@[@"车辆品牌",@"车辆型号"],@[@"车辆价格(元)",@"购置税(元)",@"保险(元)",@"购买方式",@"融资规模(元)",@"首付(元)",@"期限(月)",@"总费用(元)",@"总支出(元)"],@[@"金融方案收益(元)",@"总购车成本"]];
	}
	return _titleArray;
}

-(NSArray *)contentArray
{
	if (!_contentArray) {
		_contentArray = @[@[self.choosedProductsModel.carPpName,self.choosedProductsModel.catModelDetailName],@[[self.choosedProductsModel.inputPrice cut],[self.choosedProductsModel.gzs cut],[self.choosedProductsModel.insurance cut],self.choosedProductsModel.buyType,[self.choosedProductsModel.rzgm cut],[self.choosedProductsModel.sf cut],self.choosedProductsModel.loanyear,[self.choosedProductsModel.zfy cut],[self.choosedProductsModel.totalCost cut]],@[[self.choosedProductsModel.zsy cut],[self.choosedProductsModel.zgccb cut]]];
	}
	return _contentArray;
}

#pragma mark - p_setupView
- (void)p_setupView
{
	self.view.backgroundColor = [UIColor hexString:@"#4D000000"];
	UIView *universalAlertBackgroungView = [[UIView alloc]initWithFrame:CGRectMake(160 * wScale, 76 * hScale, 1728 * wScale, 1384 * hScale)];
	universalAlertBackgroungView.backgroundColor = [UIColor colorWithColor:[UIColor hexString:@"#FFFFFFFF"] alpha:0.3];
	LSUniversalAlertView *universalAlertView = [[LSUniversalAlertView alloc]initWithFrame:CGRectMake(176*wScale, 92*hScale, 1696*wScale, 1352 * hScale)];
	[universalAlertView.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
	[universalAlertView.closeButton addTarget:self action:@selector(closeTheAddProgramView) forControlEvents:UIControlEventTouchUpInside];
	self.closeBtn = universalAlertView.closeButton;
	universalAlertView.titleLabel.text = @"购车意向确认单";
	self.addProgramLabel = universalAlertView.titleLabel;
	
	//小灰色背景
	UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 98*hScale, universalAlertView.width, 1254*hScale)];
	grayView.backgroundColor = [UIColor hexString:@"#FFF0F1F5"];
	
	//购车意向确认单
	self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 1696 * wScale, 1128 * hScale) style:UITableViewStylePlain];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.tableView registerClass:[LSLetterofIntentTableViewCell class] forCellReuseIdentifier:CELL_ID];
	
	[grayView addSubview:self.tableView];
	[universalAlertView addSubview:grayView];
	[self.view addSubview:universalAlertBackgroungView];
	[self.view addSubview:universalAlertView];
	self.grayView = grayView;
	
	//底部栏
	UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, grayView.height - 128*hScale, grayView.width, 128*hScale)];
	barView.backgroundColor = [UIColor hexString:@"#FFFFFF"];
	
	//分割线
	UIView *cuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, hScale)];
	cuttingLine.backgroundColor = [UIColor hexString:@"#F0D9D9D9"];
	[barView addSubview:cuttingLine];
	
	//勾选按钮
	UIButton *checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(48*wScale, 56*hScale, 40*wScale, 40*hScale)];
	[checkBtn setImage:[UIImage imageNamed:@"icon_normal_agree"] forState:UIControlStateNormal];
	[checkBtn setImage:[UIImage imageNamed:@"icon_pressed_agree"] forState:UIControlStateSelected];
	checkBtn.selected = YES;
	[checkBtn addTarget:self action:@selector(desectCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
	//[barView addSubview:checkBtn];
	
	//录入客户信息
	UIButton *userInfoBtn = [[UIButton alloc]initWithFrame:CGRectMake(1312 * wScale, 24 * hScale, 320 * wScale, 80 * hScale)];
	[userInfoBtn setTitle:@"录入客户信息" forState:UIControlStateNormal];
	userInfoBtn.titleLabel.font = [UIFont systemFontOfSize:16];
	userInfoBtn.backgroundColor = [UIColor hex:@"#FF333333"];
	[userInfoBtn addTarget:self action:@selector(showInfoInputViewController) forControlEvents:UIControlEventTouchUpInside];
	[barView addSubview:userInfoBtn];
	
	[grayView addSubview:barView];
}

-(void)closeTheAddProgramView
{
	[self transitionWithType:@"rippleEffect" WithSubtype:@"kCATransitionFromLeft" ForView:self.view.superview];
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
	if (_delegate && ([_delegate respondsToSelector:@selector(pushToCustomerManagerController)])) {
		[_delegate pushToCustomerManagerController];
	}
	[self.view removeFromSuperview];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section == 0) {
		return 2;
	}else if(section == 1){
		return 9;
	}else {
		return 2;
	}
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LSLetterofIntentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
	if (indexPath.row == 0) {
		cell.L_TitleLable.text = self.headerTitleArray[indexPath.section][indexPath.row];
	}else{
		cell.L_TitleLable.text = @"";
	}
	cell.L_subTitleLable.text = self.titleArray[indexPath.section][indexPath.row];
	cell.L_ContentLable.text = self.contentArray[indexPath.section][indexPath.row];
	if (indexPath.section == 2) {
		cell.L_ContentLable.textColor = [UIColor hexString:@"#FF399B51"];
	} else {
		cell.L_ContentLable.textColor = [UIColor hexString:@"#FF000000"];
	}
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 112 * hScale;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 24 * hScale;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 24 * hScale)];
	view.backgroundColor = [UIColor hexString:@"#FFF3F3F3"];
	return view;
}

#pragma mark - 录入客户信息
-(void)showInfoInputViewController
{
	if (self.isAgreeProtocol == NO) {
		[Tool showAlertViewWithString:@"您还没有勾选客户协议" withController:self];
		return;
	}
	NSArray *userTypeArr = [self.userTypeDic allKeys];

	UIView *lightGrayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
	lightGrayView.backgroundColor = [UIColor hexString:@"#4D000000"];
	
	UIView *borderLightGrayView = [[UIView alloc]initWithFrame:CGRectMake(768 * wScale, 540 * hScale, 512 * wScale, 456 * hScale)];
	borderLightGrayView.backgroundColor = [UIColor colorWithColor:[UIColor hexString:@"#FFFFFFFF"] alpha:0.3];
	UIView *userTypeView = [[UIView alloc]initWithFrame:CGRectMake(16 * wScale, 16 * hScale, 480 * wScale, 424 * hScale)];
	userTypeView.backgroundColor = [UIColor whiteColor];
	
	//标题Label
	UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, userTypeView.width, 87 * hScale)];
	titleLabel.text = @"请选择客户类型";
	titleLabel.font = [UIFont systemFontOfSize:12];
	titleLabel.textColor = [UIColor hexString:@"#FFBFBFBF"];
	titleLabel.textAlignment = NSTextAlignmentCenter;
	[userTypeView addSubview:titleLabel];
	//分割线
	UIView *firstCuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 88 * hScale, userTypeView.width, hScale)];
	firstCuttingLine.backgroundColor = [UIColor hexString:@"#FFD9D9D9"];
	[userTypeView addSubview:firstCuttingLine];
	//个人客户button
	UIButton *individualClientButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 89 * hScale, userTypeView.width, 112 * hScale)];
	individualClientButton.titleLabel.font = [UIFont systemFontOfSize:17];
	[individualClientButton setTitleColor:[UIColor hexString:@"#FF333333"]];
	[individualClientButton setTitle:userTypeArr[0] forState:UIControlStateNormal];
	individualClientButton.tag =  152;
	[individualClientButton addTarget:self action:@selector(selectUserTypeButton:) forControlEvents:UIControlEventTouchUpInside];
	[userTypeView addSubview:individualClientButton];
	//分割线
	UIView *secondeCuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 199 * hScale, userTypeView.width, hScale)];
	secondeCuttingLine.backgroundColor = [UIColor hexString:@"#FFD9D9D9"];
	[userTypeView addSubview:secondeCuttingLine];
	//企业客户button
	UIButton *businessCustomerButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(individualClientButton.frame), userTypeView.width, 112 * hScale)];
	businessCustomerButton .titleLabel.font = [UIFont systemFontOfSize:17];
	[businessCustomerButton  setTitleColor:[UIColor hexString:@"#FF333333"]];
	[businessCustomerButton setTitle:userTypeArr[1] forState:UIControlStateNormal];
	businessCustomerButton.tag = 151;
	[businessCustomerButton addTarget:self action:@selector(selectUserTypeButton:) forControlEvents:UIControlEventTouchUpInside];
	[userTypeView addSubview:businessCustomerButton ];
	//灰色条
	UIView *lightGrayStickView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(businessCustomerButton.frame), userTypeView.width, 24 * hScale)];
	lightGrayStickView.backgroundColor = [UIColor hexString:@"#FFF3F3F3"];
	[userTypeView addSubview:lightGrayStickView];
	//取消
	UIButton *quitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lightGrayStickView.frame), userTypeView.width, 88 * hScale)];
	[quitButton setTitle:@"取消" forState:UIControlStateNormal];
	[quitButton setTitleColor:[UIColor hexString:@"#FF999999"]];
	quitButton.titleLabel.font = [UIFont systemFontOfSize:15];
	[quitButton addTarget:self action:@selector(quitSelectUserType) forControlEvents:UIControlEventTouchUpInside];
	[userTypeView addSubview:quitButton];
	
	
	[borderLightGrayView addSubview:userTypeView];
	[lightGrayView addSubview:borderLightGrayView];
	[self.view addSubview:lightGrayView];
	self.lightGrayView = lightGrayView;
	//UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择客户类型" message:nil preferredStyle:UIAlertControllerStyleAlert];
	//UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
	//	
	//}];
	//UIAlertAction *personNal = [UIAlertAction actionWithTitle:@"个人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
	//	[self showSaveUserViewControllerWithTypeID:@"02"];
	//}];
	//UIAlertAction *enterprise = [UIAlertAction actionWithTitle:@"企业" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
	//	[self showSaveUserViewControllerWithTypeID:@"01"];
	//}];
	//[alert addAction:personNal];
	//[alert addAction:enterprise];
	//[alert addAction:cancel];
	//[self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 取消选择客户类型
-(void)quitSelectUserType
{
	[self.lightGrayView removeFromSuperview];
}

#pragma mark - 选择客户类型
-(void)selectUserTypeButton:(UIButton *)button
{
	if (button.tag == 151) {//企业
		[self showSaveUserViewControllerWithTypeID:self.userTypeDic[button.titleLabel.text]];
	}
	if (button.tag == 152) {//个人
		[self showSaveUserViewControllerWithTypeID:self.userTypeDic[button.titleLabel.text]];
	}
}

#pragma mark - 展示录入客户界面
-(void)showSaveUserViewControllerWithTypeID:(NSString *)typeID
{
	[self.lightGrayView removeFromSuperview];
	[self transitionWithType:@"rippleEffect" WithSubtype:@"kCATransitionFromLeft" ForView:self.view];
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

#pragma mark - lazy laod
-(NSMutableDictionary *)userTypeDic
{
	if (!_userTypeDic) {
		_userTypeDic = [Tool customerTypeDictionary];
	}
	return _userTypeDic;
}

@end
