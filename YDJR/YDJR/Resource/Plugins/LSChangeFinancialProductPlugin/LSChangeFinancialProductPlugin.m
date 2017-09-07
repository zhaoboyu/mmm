//
//  LSChangeFinancialProductPlugin.m
//  YDJR
//
//  Created by 李爽 on 2016/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSChangeFinancialProductPlugin.h"
#import "CTTXRequestServer+financialProgram.h"
#import "LSFinancialProductsModel.h"
#import "LSFinishView.h"
#import "HGBPromgressHud.h"
#import "LSAddNonAgentProductInputView.h"
@interface LSChangeFinancialProductPlugin ()<LSFinishViewDelegate>
@property (nonatomic,copy)NSString *callbackId;
@property (nonatomic,strong)UIButton *closeBtn;
@property (nonatomic,strong)UIButton *confirmProgramBtn;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,copy)NSArray *transferArr;
@property (nonatomic,strong)LSFinishView *finishView;
@property (nonatomic,strong)HGBPromgressHud *phud;
@property (nonatomic,copy) NSString *productState;
@end

@implementation LSChangeFinancialProductPlugin

/**
 *	@brief	更换金融方案
 *
 */
- (void)changeFinancialProduct:(CDVInvokedUrlCommand *)command
{
	self.callbackId = command.callbackId;
	__weak LSChangeFinancialProductPlugin *weakself = self;
	[self.phud showHUDSaveAddedTo:self.webView];
	if (command.arguments.count > 0) {
		NSString *carPpName = command.arguments[1];
		NSString *productID = command.arguments[2];
		NSString *catModelDetailPrice = command.arguments[0];
		NSString *intentID = command.arguments[3];
		NSString *productState = command.arguments[4];
		NSString *carModelDetailName = command.arguments[5];
		NSString *productName = command.arguments[6];
		NSString *suggestedRetailPrice = command.arguments[7];
		NSString *purchaseTax = command.arguments[8];
		NSString *insurance = command.arguments[9];
		self.productState = productState;
		[[CTTXRequestServer shareInstance]checkProductsWithCatModelDetailID:carPpName SuccessBlock:^(NSMutableArray *productsModelArr) {
			[weakself.phud hideSave];
			[productsModelArr enumerateObjectsUsingBlock:^(LSFinancialProductsModel *m, NSUInteger idx, BOOL * _Nonnull stop) {
				if ([m.productID isEqualToString:productID]) {
					LSFinishView *view = [[LSFinishView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) andWithModel:m withPrice:catModelDetailPrice withIndentID:intentID withProductDict:m.productDict productState:productState productID:productID carModelDetailName:carModelDetailName productName:productName suggestedRetailPrice:suggestedRetailPrice purchaseTax:purchaseTax insurance:insurance];
					view.delegate = self;
					[view showinputView];
					self.finishView = view;
				}
			}];
		} failedBlock:^(NSError *error) {
			[weakself.phud hideSave]; 
			weakself.phud.promptStr = @"网络状况不好,请稍后重试!";
			[weakself.phud showHUDResultAddedTo:weakself.webView];
			CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
			[weakself.commandDelegate sendPluginResult:result callbackId:_callbackId];
			NSLog(@"error:%@",error);
		}];
	}else{
		CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
		[weakself.commandDelegate sendPluginResult:result callbackId:_callbackId];
	}
}

-(void)deselectConfirmProgramButton
{
	//NSError *error = nil;
	NSArray *transfer = [NSArray array];
	transfer = @[self.finishView.inputView.productsModel.productID,self.finishView.inputView.productsModel.productName];
	NSMutableArray *intentInfoArr = [Tool getIntentValueArr];
	NSMutableDictionary *dic = [NSMutableDictionary dictionary];
	[dic setObject:transfer forKey:@"transfer"];
	[dic setObject:intentInfoArr forKey:@"intentInfo"];
	
	CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dic];
	[self.commandDelegate sendPluginResult:result callbackId:_callbackId];
}

-(HGBPromgressHud *)phud
{
	if(_phud == nil){
		_phud = [[HGBPromgressHud alloc]init];
	}
	return _phud;
}

@end
