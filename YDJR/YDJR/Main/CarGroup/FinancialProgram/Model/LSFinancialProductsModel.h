//
//  LSFinancialProductsModel.h
//  YDJR
//
//  Created by 李爽 on 2016/10/11.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  金融产品

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface LSFinancialProductsModel : NSObject
/**
 备用字段
 */
@property (nonatomic,copy)NSString *bak1;
/**
 备用字段
 */
@property (nonatomic,copy)NSString *bak2;
/**
 备用字段
 */
@property (nonatomic,copy)NSString *bak3;
/**
 保养 精品赠送
 */
@property (nonatomic,copy)NSString *cargive;

/**
 车价让利
 */
@property (nonatomic,copy)NSString *carlet;
/**
 年CPI
 */
@property (nonatomic,copy)NSString *cpi;
@property (nonatomic,copy)NSString *createDate;
/**
 费率
 */
@property (nonatomic,copy)NSString *interestrate;

/**
 年投资回报率
 */
@property (nonatomic,copy)NSString *investret;
/**
 贷款期限
 */
@property (nonatomic,copy)NSString *loanyear;
/**
 保证金比例
 */
@property (nonatomic,copy)NSString *marginradio;
@property (nonatomic,copy)NSString *mechanismID;

/**
 首付比例
 */
@property (nonatomic,copy)NSString *paymentradio;
@property (nonatomic,copy)NSString *productCode;
@property (nonatomic,copy)NSString *productID;
@property (nonatomic,copy)NSString *productName;
/**
 1自营 2非自营
 */
@property (nonatomic,copy)NSString *productState;
/**
 字典数组编号
 */
@property (nonatomic,copy)NSString *productDict;

/**
 残值率
 */
@property (nonatomic,copy)NSString *residualrate;
/**
 手续费
 */
@property (nonatomic,copy)NSString *servicecharge;
@property (nonatomic,copy)NSString *serviceradio;
@property (nonatomic,copy)NSString *taxdeductible;

/**
 材料查询字典编号 个人
 */
@property (nonatomic,copy)NSString *dataDictP;
/**
 材料查询字典编号 企业
 */
@property (nonatomic,copy)NSString *dataDictQ;
/**
 留购比例
 */
@property (nonatomic,copy)NSString *retentionRatio;
/**
 手续费率
 */
@property (nonatomic,copy)NSString *counterFeeRatio;
/**
 建议零售价
 */
@property (nonatomic,copy)NSString *suggestedRetailPrice;
/**
 车价
 */
@property (nonatomic,copy)NSString *cj;
/**
 购置税
 */
@property (nonatomic,copy)NSString *purchaseTax;
/**
 保险
 */
@property (nonatomic,copy)NSString *insurance;
/**
 是否勾选购置税
 */
@property (nonatomic,assign)BOOL isGzsSelected;
/**
 是否勾选保险
 */
@property (nonatomic,assign)BOOL isBxSelected;
/**
 利率1
 */
@property (nonatomic,copy)NSString *interestRate1;
/**
 利率2
 */
@property (nonatomic,copy)NSString *interestRate2;
@end
