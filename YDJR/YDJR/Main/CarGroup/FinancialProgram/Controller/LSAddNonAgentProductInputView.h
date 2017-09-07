//
//  LSAddNonAgentProductInputView.h
//  YDJR
//
//  Created by 李爽 on 2016/12/21.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSFinancialProductsModel;
@class LSChoosedProductsModel;

@protocol LSAddNonAgentProductInputViewDelegate <NSObject>

@optional;

-(void)removeAddNonAgentProductInputView;

-(void)removeAddProgramViewAfterAddNonAgentProductInputViewDisAppear;

@end

@interface LSAddNonAgentProductInputView : UIView

@property (nonatomic,copy)LSFinancialProductsModel *productsModel;
@property (nonatomic,strong)LSChoosedProductsModel *choosedProductsModel;
@property (nonatomic,weak)id<LSAddNonAgentProductInputViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame productModel:(LSFinancialProductsModel *)productModel realPrice:(NSString *)actualPrice productDict:(NSString *)productDict;

@end
