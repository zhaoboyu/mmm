//
//  LSFinancialProgramView.h
//  YDJR
//
//  Created by 李爽 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  金融方案View

#import <UIKit/UIKit.h>
@class LSTextField;

@interface LSFinancialProgramView : UIView
/**
 建议零售价(元)
 */
@property (nonatomic,strong)UILabel *suggestedRetailPriceTitleLabel;
/**
 建议零售价格
 */
@property (nonatomic,strong)UILabel *suggestedRetailPriceLabel;
/**
 第一条分隔线
 */
@property (nonatomic,strong)UIView *firstCuttingLine;
/**
 实际价格
 */
@property (nonatomic,strong)UILabel *realPriceLabel;
/**
 实际价格TextField
 */
@property (nonatomic,strong)LSTextField *realPriceInputTextField;
///**
// 第二条分割线
// */
//@property (nonatomic,strong)UIView *secondCuttingLine;
///**
// 保险
// */
//@property (nonatomic,strong)UILabel *insuranceLabel;
///**
//保险输入框
// */
//@property (nonatomic,strong)LSTextField *insuranceInputTextField;
///**
// 保险勾选按钮
// */
//@property (nonatomic,strong)UIButton *checkBtn;

@end
