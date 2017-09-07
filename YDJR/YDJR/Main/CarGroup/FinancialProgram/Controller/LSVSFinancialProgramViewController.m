//
//  LSVSFinancialProgramViewController.m
//  YDJR
//
//  Created by 李爽 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSVSFinancialProgramViewController.h"
#import "LSMasterViewController.h"
#import "LSDetailViewController.h"
#import "LSUniversalAlertView.h"

@interface LSVSFinancialProgramViewController ()<UISplitViewControllerDelegate>

@end

@implementation LSVSFinancialProgramViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	[self p_setupView];
}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:YES];
	[self transitionWithType:@"rippleEffect" WithSubtype:@"kCATransitionFromLeft" ForView:self.view];
}

#pragma mark - p_setupView
- (void)p_setupView
{
	self.view.backgroundColor = [UIColor hexString:@"#4D000000"];
	
	UIView *universalAlertBackgroungView = [[UIView alloc]initWithFrame:CGRectMake(160 * wScale, 76 * hScale, 1728 * wScale, 1384 * hScale)];
	universalAlertBackgroungView.backgroundColor = [UIColor colorWithColor:[UIColor hexString:@"#FFFFFFFF"] alpha:0.3];
	
	LSUniversalAlertView *universalAlertView = [[LSUniversalAlertView alloc]initWithFrame:CGRectMake(176 * wScale, 92 *hScale, 1696 * wScale, 1352 * hScale)];
	[universalAlertView.closeButton setTitle:@"关闭" forState:UIControlStateNormal];
	[universalAlertView.closeButton addTarget:self action:@selector(closeTheVSFinancialProgramView) forControlEvents:UIControlEventTouchUpInside];
	universalAlertView.titleLabel.text = @"金融方案对比";
	[universalAlertView.rightButton setTitle:@"清除已选方案" forState:UIControlStateNormal];
	[universalAlertView.rightButton addTarget:self action:@selector(deselectClearSelectedProgramBtn) forControlEvents:UIControlEventTouchUpInside];
	universalAlertView.rightButton.hidden = self.choosedProductsModelArray.count == 1;
	
	UISplitViewController *splitVC = [[UISplitViewController alloc]init];
	splitVC.view.frame = CGRectMake(0, 98 * hScale, 1696 * wScale, universalAlertView.frame.size.height - 98*hScale);
	splitVC.view.backgroundColor = [UIColor hexString:@"#FFF0F1F5"];
	splitVC.preferredPrimaryColumnWidthFraction = 0.316;
	LSMasterViewController *masterVC = [[LSMasterViewController alloc]init];
	masterVC.catModelDetailPrice = self.realPrice;
	masterVC.fullPaymentRealPrice = self.fullPaymentRealPrice;
	masterVC.numberOfRows = self.numberOfRows;
	masterVC.choosedProductsModelArray = self.choosedProductsModelArray;
	masterVC.mainVC = self;
	LSDetailViewController *detailVC = [[LSDetailViewController alloc]init];
	detailVC.leftVC = masterVC;
	detailVC.actualPrice = self.realPrice;
	detailVC.fullPaymentRealPrice = self.fullPaymentRealPrice;
	detailVC.choosedProductsModelArray = self.choosedProductsModelArray;
	splitVC.viewControllers = [NSArray arrayWithObjects:masterVC,detailVC,nil];
	[universalAlertView addSubview:splitVC.view];
	[self addChildViewController:splitVC];
	
	[self.view addSubview:universalAlertBackgroungView];
	[self.view addSubview:universalAlertView];
}

/**
 关闭对比金融产品view
 */
-(void)closeTheVSFinancialProgramView
{
	[self.view removeFromSuperview];
}

#pragma mark - clearSelectedProgram
-(void)deselectClearSelectedProgramBtn
{
	if (_delegate && ([_delegate respondsToSelector:@selector(clearSelectedProgram)])) {
		[_delegate clearSelectedProgram];
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

@end
