//
//  LSFinishView.m
//  YDJR
//
//  Created by 李爽 on 2016/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFinishView.h"
#import "LSChoosedProductsModel.h"
#import "CTTXRequestServer+LetterofIntent.h"
#import "LSMaterialModel.h"
#import "CTTXRequestServer+financialProgram.h"
#import "LSUniversalAlertView.h"
#import "HGBPromgressHud.h"
#import "LSAddNonAgentProductInputView.h"

@interface LSFinishView ()<LSAddNonAgentProductInputViewDelegate>

@property (nonatomic,copy)NSMutableArray *materialModelArr;
@property (nonatomic,copy)NSString *gzs;//购置税
@property (nonatomic,copy)NSString *zsy;
@property (nonatomic,copy)NSString *zfy;
@property (nonatomic,copy)NSString *zzc;
@property (nonatomic,copy)NSString *zgccb;
@property (nonatomic,copy)NSMutableDictionary *dict;
@property (nonatomic,copy)NSString *intentID;
@property (nonatomic,copy)NSString *productDict;
/**
 1.自营 2.非自营
 */
@property (nonatomic,copy)NSString *productState;
@property (nonatomic,copy)NSString *productID;
/**
 车型详细名称
 */
@property (nonatomic,copy)NSString *carModelDetailName;
/**
 金融产品名称
 */
@property (nonatomic,copy)NSString *productName;
@property (nonatomic,copy)NSString *suggestedRetailPrice;
@property (nonatomic,strong)HGBPromgressHud *phud;

@property (nonatomic,copy)NSString *purchaseTax;
@property (nonatomic,copy)NSString *insurance;
@end
@implementation LSFinishView
- (instancetype)initWithFrame:(CGRect)frame andWithModel:(LSFinancialProductsModel *)productsModel withPrice:(NSString *)price withIndentID:(NSString *)intentID withProductDict:(NSString *)productDict productState:(NSString *)productState productID:(NSString *)productID carModelDetailName:(NSString *)carModelDetailName productName:(NSString *)productName suggestedRetailPrice:(NSString *)suggestedRetailPrice purchaseTax:(NSString *)purchaseTax insurance:(NSString *)insurance
{
	self = [super initWithFrame:frame];
	if (self) {
		self.productsModel = productsModel;
		self.catModelDetailPrice = price;
		self.intentID = intentID;
		self.productDict = productDict;
		self.productState = productState;
		self.productID = productID;
		self.carModelDetailName =carModelDetailName;
		self.productName = productName;
		self.suggestedRetailPrice = suggestedRetailPrice;
		self.purchaseTax = purchaseTax;
		self.insurance = insurance;
		self.backgroundColor = [UIColor hexString:@"#4D000000"];
	}
	return self;
}

#pragma mark - 取消更换方案
-(void)removeAddNonAgentProductInputView
{
	[self removeFromSuperview];
}

#pragma mark - 确认更换方案
-(void)removeAddProgramViewAfterAddNonAgentProductInputViewDisAppear
{
	[[CTTXRequestServer shareInstance]checkMaterialWithDictitem:@"IDFS000305" WithType:100 SuccessBlock:^(NSMutableArray *materialModelArr) {
		self.materialModelArr = materialModelArr;
		[self updateProprietaryProductLetterOfIntent];
	} failedBlock:^(NSError *error) {
		
	}];
}

/**
 更新自营产品意向单
 */
-(void)updateProprietaryProductLetterOfIntent{
	[[CTTXRequestServer shareInstance]checkIntentWithIntentID:self.intentID SuccessBlock:^(NSDictionary *intentDictionary) {
		//NSArray *array = [Tool unarcheiverWithfileName:@"LetterofIntent"] ;
		//if (array.count > 0) {
		self.inputView.choosedProductsModel.insurance = intentDictionary[@"insurance"];
		NSMutableDictionary *intentDict = [intentDictionary mutableCopy];
		intentDict[@"productName"]= self.productName;
		intentDict[@"catModelDetailName"]= self.carModelDetailName;
		intentDict[@"totalSave"] = @"";
		//intentDict[@"totalExp"] = self.inputView.choosedProductsModel.totalCost;
		intentDict[@"insuState"] = @"0";
		intentDict[@"state"] = @"0";
		intentDict[@"productState"] = self.inputView.choosedProductsModel.productState;
		intentDict[@"productID"] = self.inputView.choosedProductsModel.productID;
		intentDict[@"investretRet"] = self.inputView.choosedProductsModel.tzhb;
		intentDict[@"expand"] = [NSString stringWithFormat:@"%.2f",([self.inputView.choosedProductsModel.rzgm floatValue]/2)*[self.inputView.choosedProductsModel.ncpi floatValue]];
		//intentDict[@"carPrice"] = self.inputView.choosedProductsModel.catModelDetailPrice;
		intentDict[@"cpi"] = [NSString stringWithFormat:@"%.2f",[self.inputView.choosedProductsModel.ncpi floatValue]*100];
		intentDict[@"idleFunds"] = [NSString stringWithFormat:@"%.2f",[self.inputView.choosedProductsModel.rzgm floatValue]/2];
		intentDict[@"instCounts"] = self.inputView.choosedProductsModel.loanyear;
		intentDict[@"interest"] = self.inputView.choosedProductsModel.lx;
		intentDict[@"investret"] = [NSString stringWithFormat:@"%.2f",[self.inputView.choosedProductsModel.ntzhbl floatValue]*100];
		intentDict[@"interestrate"] = self.inputView.choosedProductsModel.interestrate;
		//		if ([self.inputView.choosedProductsModel.productID isEqualToString:@"1"]) {
		//			NSArray *transferArr=[intentDict[@"includeAmountType"] componentsSeparatedByString:@","];
		//			if (transferArr.count < 3) {
		//				NSString *tempString = [NSString stringWithFormat:@"%.2f",[self.inputView.choosedProductsModel.rzgm floatValue] + [self.inputView.choosedProductsModel.insurance floatValue]];
		//				intentDict[@"carrzgm"] = tempString;
		//				intentDict[@"includeAmountType"] = @"01,03";
		//			}else{
		//				NSString *tempString = [NSString stringWithFormat:@"%.2f",[self.inputView.choosedProductsModel.rzgm floatValue] + [self.inputView.choosedProductsModel.insurance floatValue] + [self.inputView.choosedProductsModel.gzs floatValue]];
		//				intentDict[@"carrzgm"] = tempString;
		//				intentDict[@"includeAmountType"] = @"01,02,03";
		//			}
		//		}else{
		//			intentDict[@"includeAmountType"] = @"01";
		//			intentDict[@"carrzgm"] = self.inputView.choosedProductsModel.rzgm;
		//		}
		if (self.inputView.choosedProductsModel.isBxSelected && self.inputView.choosedProductsModel.isBxSelected) {
			intentDict[@"includeAmountType"] = @"01,02,03";
		}else if (self.inputView.choosedProductsModel.isGzsSelected) {
			intentDict[@"includeAmountType"] = @"01,02";
		}else if (self.inputView.choosedProductsModel.isBxSelected) {
			intentDict[@"includeAmountType"] = @"01,03";
		}else{
			intentDict[@"includeAmountType"] = @"01";
		}
		intentDict[@"carrzgm"] = self.inputView.choosedProductsModel.rzgm;
		//intentDict[@"uptoTerm"] = self.inputView.choosedProductsModel.uptoTerm;
		//intentDict[@"isInsFq"] = self.inputView.choosedProductsModel.isInsFq;
		//intentDict[@"insuranceMess"] = self.inputView.choosedProductsModel.insuranceMess;
		//intentDict[@"carSeriesID"] = self.inputView.choosedProductsModel.carSeriesID;
		//intentDict[@"carModelID"] = self.inputView.choosedProductsModel.carModelID;
		//intentDict[@"catModelDetailID"] = self.inputView.choosedProductsModel.catModelDetailID;
		//intentDict[@"insurance"] = self.inputView.choosedProductsModel.insurance;
		
		for (LSMaterialModel *m in self.materialModelArr) {
			//购置税
			//if ([m.dictvalue isEqualToString:@"gzs"]) {
			//	NSString *gzs = [self calculationWithAlgorithm:m.dictname];
			//	self.gzs = gzs;
			//	self.inputView.choosedProductsModel.gzs = gzs;
			//}
			//总费用
			if ([m.dictvalue isEqualToString:@"zfy"]) {
				NSString *zfy =  [self calculationWithAlgorithm:m.dictname];
				self.zfy = zfy;
				self.inputView.choosedProductsModel.zfy = zfy;
			}
			//总支出
			if ([m.dictvalue isEqualToString:@"totalCost"]) {
				NSString *zzc = [self calculationWithAlgorithm:m.dictname];
				self.zzc = zzc;
				self.inputView.choosedProductsModel.totalCost = zzc;
			}
			//金融方案收益
			if ([m.dictvalue isEqualToString:@"zsy"]) {
				NSString *zsy =  [self calculationWithAlgorithm:m.dictname];
				self.zsy = zsy;
				self.inputView.choosedProductsModel.zsy = zsy;
			}
			//总购车车本
			if ([m.dictvalue isEqualToString:@"zgccb"]) {
				NSString *zgccb =  [self calculationWithAlgorithm:m.dictname];
				self.zgccb = zgccb;
				self.inputView.choosedProductsModel.zgccb = zgccb;
			}
		}
		intentDict[@"purchasetax"] = self.inputView.choosedProductsModel.gzs;
		intentDict[@"totalRet"] = self.inputView.choosedProductsModel.zsy;
		intentDict[@"totalCarCost"] = self.inputView.choosedProductsModel.zgccb;
		intentDict[@"totalExp"] = self.inputView.choosedProductsModel.totalCost;
		intentDict[@"totalCost"] = self.inputView.choosedProductsModel.zfy;
		intentDict[@"productState"] = self.inputView.choosedProductsModel.productState;
		//NSLog(@"pppppppp%@",intentDict);
		//[self.dict setObject:intentDict forKey:@"Intent"];
		//}
		
		[self.phud showHUDSaveAddedTo:self];
		[[CTTXRequestServer shareInstance]updateIntentWithInfoDict:intentDict SuccessBlock:^(NSDictionary * responseObject) {
			NSLog(@"存入客户%@",responseObject);
			[self.phud hideSave];
			NSString *resultStr = [NSString stringWithFormat:@"%@", responseObject[@"result"]];
			if ([resultStr isEqualToString:@"1"]) {
				//0车辆品牌、1产品id、2客户id、3开票价、4产品名称、5角色权限、6是否自营（1:自营,2.非自营,3达分期）、7转借状态、8意向单id、9客户类型 10.车辆销售名称
				NSMutableArray *intentArr = [Tool getIntentValueArr];
				intentArr[1] = self.inputView.choosedProductsModel.productID;
				intentArr[4] = self.inputView.choosedProductsModel.productName;
				intentArr[6] = self.inputView.choosedProductsModel.productState;
				[Tool saveIntentValueWithValueArr:intentArr];
				if (_delegate && ([_delegate respondsToSelector:@selector(deselectConfirmProgramButton)])) {
					[_delegate deselectConfirmProgramButton];
				}
				[self removeFromSuperview];
			}else{
				[self.phud hideSave];
				self.phud.promptStr = responseObject[@"message"];
				[self.phud showHUDResultAddedTo:self];
                [self removeFromSuperview];
			}
		} failedBlock:^(NSError *error) {
			[self.phud hideSave];
			self.phud.promptStr = @"网络状况不好...请稍后重试!";
			[self.phud showHUDResultAddedTo:self];
            [self removeFromSuperview];
		}];
	} failedBlock:^(NSError *error) {
		[self.phud hideSave];
		self.phud.promptStr = @"网络状况不好...请稍后重试!";
		[self.phud showHUDResultAddedTo:self];
        [self removeFromSuperview];
	}]; 
}

#pragma mark - 展示方案详情
- (void)showinputView
{
	self.productsModel.suggestedRetailPrice = self.suggestedRetailPrice;
	self.productsModel.purchaseTax = self.purchaseTax;
	self.productsModel.insurance = self.insurance;
	self.inputView = [[LSAddNonAgentProductInputView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) productModel:self.productsModel realPrice:[self.catModelDetailPrice stringByReplacingOccurrencesOfString:@"," withString:@""] productDict:self.productDict];
	self.inputView.delegate = self;
	[self addSubview:self.inputView];
	[self addPopViewToWinder];
}

#pragma mark - 根据传进来的公式进行运算
-(NSString *)calculationWithAlgorithm:(NSString *)algorithm
{
	NSMutableDictionary *dict = [self.inputView.choosedProductsModel yy_modelToJSONObject];
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

#pragma mark - lazy load
-(HGBPromgressHud *)phud
{
	if(_phud == nil){
		_phud = [[HGBPromgressHud alloc]init];
	}
	return _phud;
}
@end
