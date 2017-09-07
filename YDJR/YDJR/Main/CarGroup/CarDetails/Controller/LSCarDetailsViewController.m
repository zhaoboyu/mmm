//
//  LSCarDetailsViewController.m
//  YDJR
//
//  Created by 李爽 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSCarDetailsViewController.h"
#import "LSCarDetailsView.h"
#import "LSFinancialProgramViewController.h"
#import "LLFInsuranceInfoViewController.h"
#import "LetterofIntentViewController.h"
#import "LSChoosedProductsModel.h"
#import "LLFCarModel.h"
#import "InsuranceInfoModel.h"
#import "SDCCustomerManagerController.h"

#import "CTTXRequestServer+LetterofIntent.h"
#import "LSMaterialModel.h"
#import "LSFinancialProductsModel.h"
#import "YYModel.h"

#import "LSTextField.h"

#import "LSAgentProductsTemplateModel.h"
#import "UIImage+CreateImageWithColor.h"


#import "AppDelegate.h"
#import "YDJRBarViewController.h"
@interface LSCarDetailsViewController ()<LSCarDetailsViewDelegate,LLFInsuranceInfoViewControllerDelegate,LSFinancialProgramViewControllerDelegate,LetterofIntentViewControllerDelegate>

@property (nonatomic,strong)UILabel *financialLabel;//已选择金融方案
@property (nonatomic,strong)UILabel *insuranceTitleLabel;//保险方案标题
@property (nonatomic,strong)UILabel *insurancePlanLabel;//保险方案
@property (nonatomic,strong)LSChoosedProductsModel *choosedProductsModel;
@property (nonatomic,copy)NSArray *choosedProductsModelArr;
/**
 保险描述
 */
@property (nonatomic,copy)NSString *insuranceMessStr;
/**
 保险期数
 */
@property (nonatomic,copy)NSString *uptoTerm;
/**
 是否是达分期
 */
@property (nonatomic,copy)NSString *isInsFq;
@property (nonatomic,copy)NSString *insurance;//保险

@property (nonatomic,copy)NSMutableArray *materialModelArr;
@property (nonatomic,copy)NSString *gzs;//购置税
@property (nonatomic,copy)NSString *zsy;
@property (nonatomic,copy)NSString *zfy;
/**
 总支出
 */
@property (nonatomic,copy)NSString *zzc;
@property (nonatomic,copy)NSString *zgccb;
@property (nonatomic,assign)NSInteger financialProgramTag;
@property (nonatomic,copy)NSString *gzsString;
@property (nonatomic,assign)BOOL status;
@end

@implementation LSCarDetailsViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)loadView
{
	[super loadView];
	self.carDetailsView = [[LSCarDetailsView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
	self.carDetailsView.delegate = self;
	self.carDetailsView.parent = self;
	self.view = self.carDetailsView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setupView];
	[self obtainLetterofIntentFormula];
}

- (void)setupView
{
	//[self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:@"#FFFFFFFF"] forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.translucent = NO;
	
	//自定义导航栏左边按钮
	UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[leftButton setSize:CGSizeMake(824*wScale, 30*hScale)];
	[leftButton setTitle:[NSString stringWithFormat:@"%@ %@ %@",self.carModel.carSeriesName,self.carModel.catModelDetailYear,self.carModel.catModelDetailName] forState:UIControlStateNormal];
	[leftButton setTitleColor:[UIColor hexString:@"#FF666666"]];
	[leftButton setImage:[UIImage imageNamed:@"L_icon_back"] forState:UIControlStateNormal];
	leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[leftButton addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
	self.navigationItem.leftBarButtonItem = leftItem;
	
	//self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"L_icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction:)];
	//self.navigationItem.leftBarButtonItem.title = self.carModel.catModelDetailName;
	//[self.navigationItem.leftBarButtonItem setTintColor:[UIColor hexString:@"#FF666666"]];
	
	self.navigationItem.title = @"产品详情";
	
	self.navigationItem.titleView = self.carDetailsView.topView;
	
	self.financialProgramVC = [[LSFinancialProgramViewController alloc]init];
	self.financialProgramVC.carModel = self.carModel;
	self.financialProgramVC.purchaseTax = [NSString stringWithFormat:@"%.0f",[self.carModel.catModelDetailPrice floatValue]/1.17 * 0.1];
	self.financialProgramVC.delegate = self;
	self.financialProgramVC.view.frame = CGRectMake(0, 0, kWidth, CGRectGetHeight(self.carDetailsView.BackgroundScrollView.frame));
	[self addChildViewController:self.financialProgramVC];
	[self.carDetailsView.BackgroundScrollView addSubview:self.financialProgramVC.view];
	
	self.insuranceVC= [[LLFInsuranceInfoViewController alloc]init];
	self.insuranceVC.delegate = self;
	self.insuranceVC.view.frame = CGRectMake(kWidth, 0, kWidth, CGRectGetHeight(self.carDetailsView.BackgroundScrollView.frame));
	[self addChildViewController:self.insuranceVC];
	[self.carDetailsView.BackgroundScrollView addSubview:self.insuranceVC.view];
	
	//底部栏
	UIView *bottomBarView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight - 256 * hScale, kWidth, 128*hScale)];
	bottomBarView.backgroundColor = [UIColor hexString:@"#FFFFFF"];
	
	UILabel *financialTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 49 * hScale, 224 * wScale, 30 * hScale)];
	financialTitleLabel.text = @"已选择金融方案:";
	financialTitleLabel.font = [UIFont systemFontOfSize:15];
	financialTitleLabel.textColor = [UIColor hexString:@"#FF666666"];
	[bottomBarView addSubview:financialTitleLabel];
	
	self.financialLabel = [[UILabel alloc]initWithFrame:CGRectMake(268 * wScale,49 * hScale, kWidth/2, 30 * hScale)];
	self.financialLabel.text = @"--";
	self.financialLabel.font = [UIFont systemFontOfSize:15];
	self.financialLabel.textColor = [UIColor hexString:@"#FF333333"];
	[bottomBarView addSubview:self.financialLabel];
		
	UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWidth - 352 * wScale, 24 * hScale, 320 * wScale, 80*hScale)];
	[buyBtn setTitle:@"马上购买" forState:UIControlStateNormal];
	buyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
	buyBtn.backgroundColor = [UIColor hexString:@"#FF333333"];
	[buyBtn addTarget:self action:@selector(showLetterofIntentViewController) forControlEvents:UIControlEventTouchUpInside];
	[bottomBarView addSubview:buyBtn];
	
	[self.view addSubview:bottomBarView];
}

- (void)addViewControllerWithIndex:(NSInteger)index
{
	if (index == 0) {
		[self.financialProgramVC viewWillAppear:YES];
	}else if (index == 1){
		[self.financialProgramVC.view endEditing:YES];
		[self.insuranceVC viewWillAppear:YES];
	}
}

#pragma mark - 跳转到客户管理界面
-(void)pushToCustomerManagerController
{
    [self  dismissViewControllerAnimated:YES completion:nil];
    //SDCCustomerManagerController *vc = [[SDCCustomerManagerController alloc]init];
//    [[NSUserDefaults standardUserDefaults]setObject:self.choosedProductsModel.customCardNumId forKey:@"SDDcustomCardNumId"];
//	vc.customerId = self.choosedProductsModel.customCardNumId;
//	[self.navigationController pushViewController:vc animated:YES];
    
    
    YDJRBarViewController *tabbar = (YDJRBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabbar.selectedIndex = 2;
    if (self.choosedProductsModel.customCardNumId && self.choosedProductsModel.customCardNumId.length > 0) {
        YDJRNavigationViewController *nav = (YDJRNavigationViewController *)tabbar.viewControllers[2];
        SDCCustomerManagerController *vc = (SDCCustomerManagerController *)nav.viewControllers[0];
        vc.customerId = self.choosedProductsModel.customCardNumId;
    }
    

    
}

#pragma mark - LSFinancialProgramViewControllerDelegate
-(void)popToCarDetailsViewControllerWithTitle:(NSString *)tilte
{
	self.financialLabel.text = tilte;
}

-(void)popToFinancialProgramViewControllerWithDataArr:(NSArray *)dataArr withFinancialProgramTag:(NSInteger)tag
{
	self.choosedProductsModelArr  = dataArr;
	self.financialProgramTag = tag;
	[self transitionWithType:@"rippleEffect" WithSubtype:@"kCATransitionFromLeft" ForView:self.view];
}

-(void)refreshChoosedFinancialProductTitle:(NSString *)title
{
	self.financialLabel.text = title;
}
//编辑金融方案
-(void)refreshEditedFinancialProductArray:(NSArray *)array withSelectedProductTag:(NSInteger)tag
{
	self.choosedProductsModelArr = array;
	[self transitionWithType:@"rippleEffect" WithSubtype:@"kCATransitionFromLeft" ForView:self.view];

}

#pragma mark LLFInsuranceInfoViewControllerDelegate
- (void)insuranceInfoModelstate:(NSString *)state modelArr:(NSMutableArray *)modelArr insuranceNum:(NSString *)insuranceNum
{
	self.insurancePlanLabel.text = [insuranceNum stringByAppendingString:@"年期"];
	self.insuranceMessStr = @"";
	for (InsuranceInfoModel *m in modelArr) {
		if (IS_STRING_NOT_EMPTY(m.insuranceName)) {
			self.insuranceMessStr = [self.insuranceMessStr stringByAppendingString:m.insuranceName];
		}
	}
}
//是否购买达分期产品
- (void)sendIsByDaFenQi:(BOOL)isBy
{
	if (isBy == NO) {
		self.isInsFq = @"0";
	}else{
		self.isInsFq = @"1";
	}
}
#pragma mark - show购车意向确认单
-(void)showLetterofIntentViewController
{
	if ([self.financialLabel.text isEqualToString:@"--"]) {
		//全款购车
		[Tool showAlertViewWithString:@"请选择金融方案" withController:self];
		return;
	}else{
		//有无选中金融方案
		if (!self.financialProgramTag) {
			//若无 则默认是最后一个金融产品model
			self.choosedProductsModel = [self.financialProgramVC.choosedProductsModelArray lastObject];
			self.choosedProductsModel = [self.financialProgramVC.choosedProductsModelArray lastObject];
		}else{
			//若有 则找出对应model
			self.choosedProductsModel = self.choosedProductsModelArr[self.financialProgramTag - 1];
		}
		
		self.choosedProductsModel.insurance = self.choosedProductsModel.bx;
		self.choosedProductsModel.uptoTerm = self.uptoTerm;
		self.choosedProductsModel.isInsFq = self.isInsFq;
		self.choosedProductsModel.insuranceMess = [NSString stringWithFormat:@"%@", self.insuranceMessStr];
		
		//有无输入实际价格 （实际价格既是开票价）
		if (kStringIsEmpty(self.financialProgramVC.realPriceInputTextField.text)) {
			[Tool showAlertViewWithString:@"您还没有输入实际价格" withController:self];
			return;
		}
		//开票价
		self.choosedProductsModel.contractAmount = self.financialProgramVC.realPriceInputTextField.text;
		
		//是否自营
		//if ([self.choosedProductsModel.productState isEqualToString:@"1"]) {
		
		self.choosedProductsModel.buyType = self.choosedProductsModel.productName;
		self.choosedProductsModel.catModelDetailName = [NSString stringWithFormat:@"%@ %@ %@",self.carModel.carSeriesName,self.carModel.catModelDetailYear,self.carModel.catModelDetailName];
		self.choosedProductsModel.carModelName = self.carModel.carModelName;
		self.choosedProductsModel.catModelDetailPrice = self.carModel.catModelDetailPrice;
		self.choosedProductsModel.carSeriesID = self.carModel.carSeriesID;
		self.choosedProductsModel.carModelID = self.carModel.catModelID;
		self.choosedProductsModel.catModelDetailID = self.carModel.catModelDetailID;
		self.choosedProductsModel.carPpName = self.carModel.carPpName;
		
		for (LSMaterialModel *m in self.materialModelArr) {
			//总费用
			if ([m.dictvalue isEqualToString:@"zfy"]) {
				NSString *zfy = [self calculationWithAlgorithm:m.dictname choosedProductsModel:self.choosedProductsModel];
				self.zfy = zfy;
				self.choosedProductsModel.zfy = zfy;
			}
			//总支出
			if ([m.dictvalue isEqualToString:@"totalCost"]) {
				NSString *zzc = [self calculationWithAlgorithm:m.dictname choosedProductsModel:self.choosedProductsModel];
				self.zzc = zzc;
				self.choosedProductsModel.totalCost = zzc;
			}
			//金融方案收益
			if ([m.dictvalue isEqualToString:@"zsy"]) {
				NSString *zsy = [self calculationWithAlgorithm:m.dictname choosedProductsModel:self.choosedProductsModel];
				self.zsy = zsy;
				self.choosedProductsModel.zsy = zsy;
			}
			//总购车车本
			if ([m.dictvalue isEqualToString:@"zgccb"]) {
				NSString *zgccb = [self calculationWithAlgorithm:m.dictname choosedProductsModel:self.choosedProductsModel];
				self.zgccb = zgccb;
				self.choosedProductsModel.zgccb = zgccb;
			}
		}
		
		LetterofIntentViewController *vc = [[LetterofIntentViewController alloc]init];
		vc.choosedProductsModel = self.choosedProductsModel;
		vc.delegate = self;
		vc.view.frame = CGRectMake(0, 0, kWidth, kHeight);
		UIWindow *window = [UIApplication sharedApplication].keyWindow;
		[window addSubview:vc.view];
		[self addChildViewController:vc];
		//[self wxs_presentViewController:vc animationType:WXSTransitionAnimationTypeBoom completion:nil];
	}
}

/**
 获取意向单确认公式
 */
-(void)obtainLetterofIntentFormula
{
	[[CTTXRequestServer shareInstance]checkMaterialWithDictitem:@"IDFS000305" WithType:101 SuccessBlock:^(NSMutableArray *materialModelArr) {
		self.materialModelArr = materialModelArr;
	} failedBlock:^(NSError *error) {
		
	}];
}

-(NSString *)calculationWithAlgorithm:(NSString *)algorithm choosedProductsModel:(LSChoosedProductsModel *)choosedProductsModel
{
	NSMutableDictionary *dict = [choosedProductsModel yy_modelToJSONObject];
	NSArray *transferArr=[algorithm componentsSeparatedByString:@","];
	NSString *newAlgorithmstr=@"";
	for(NSString *tempStr in transferArr){
		if ([tempStr isEqualToString:@"0"]) {
			newAlgorithmstr = tempStr;
		}else{
			NSString *s=[dict objectForKey:tempStr];
			if ([tempStr isEqualToString:@"paymentradio"]||[tempStr isEqualToString:@"marginradio"]||[tempStr isEqualToString:@"interestrate"]||[tempStr isEqualToString:@"investret"]||[tempStr isEqualToString:@"cpi"]||[tempStr isEqualToString:@"residualrate"]||[tempStr isEqualToString:@"retentionRatio"]) {
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
	if ([str floatValue] < 1) {
		return [str cutOutStringContainsDotSupplement];
	}else{
		return [str cutOutStringContainsDot];
	}
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

#pragma mark - 返回
- (void)leftBarButtonItemAction:(UIButton *)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

@end
