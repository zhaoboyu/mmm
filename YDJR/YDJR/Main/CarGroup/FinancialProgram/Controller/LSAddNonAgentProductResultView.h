//
//  LSAddNonAgentProductResultView.h
//  YDJR
//
//  Created by 李爽 on 2016/12/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSChoosedProductsModel;

@interface LSAddNonAgentProductResultView : UIView

@property (nonatomic,strong)LSChoosedProductsModel *choosedProductsModel;

- (instancetype)initWithFrame:(CGRect)frame productModel:(LSChoosedProductsModel *)choosedProductsModel;

@end

