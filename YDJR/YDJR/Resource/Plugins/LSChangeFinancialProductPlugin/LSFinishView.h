//
//  LSFinishView.h
//  YDJR
//
//  Created by 李爽 on 2016/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "PopView.h"
@class LSFinancialProductsModel;
@class LSAddNonAgentProductInputView;
@protocol LSFinishViewDelegate <NSObject>

-(void)deselectConfirmProgramButton;

@end
@interface LSFinishView : PopView
@property (nonatomic,strong)LSFinancialProductsModel *productsModel;
@property (nonatomic,copy)NSString *catModelDetailPrice;
@property (nonatomic,strong)LSAddNonAgentProductInputView *inputView;
@property (nonatomic,weak)id<LSFinishViewDelegate> delegate;
- (void)showinputView;
- (instancetype)initWithFrame:(CGRect)frame andWithModel:(LSFinancialProductsModel *)productsModel withPrice:(NSString *)price withIndentID:(NSString *)intentID withProductDict:(NSString *)productDict productState:(NSString *)productState productID:(NSString *)productID carModelDetailName:(NSString *)carModelDetailName productName:(NSString *)productName suggestedRetailPrice:(NSString *)suggestedRetailPrice purchaseTax:(NSString *)purchaseTax insurance:(NSString *)insurance;
@end
