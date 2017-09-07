//
//  LSAddNonAgentProductDetailsView.h
//  YDJR
//
//  Created by 李爽 on 2016/11/30.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSChoosedProductsModel;
@class LSFinancialProductsModel;
@interface LSAddNonAgentProductDetailsView : UIView
/**
 金融产品model
 */
@property (nonatomic,copy)LSFinancialProductsModel *productsModel;
@property (nonatomic,copy)NSString *catModelDetailPrice;
@property (nonatomic,strong)LSChoosedProductsModel *choosedProductsModel;

- (instancetype)initWithFrame:(CGRect)frame productModel:(id)productModel actualPrice:(NSString *)actualPrice productDict:(NSString *)productDict;
@end
