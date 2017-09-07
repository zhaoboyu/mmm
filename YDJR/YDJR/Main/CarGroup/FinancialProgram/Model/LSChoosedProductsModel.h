//
//  LSChoosedProductsModel.h
//  YDJR
//
//  Created by 李爽 on 2016/10/11.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  已选择的金融产品

#import <Foundation/Foundation.h>

@interface LSChoosedProductsModel : NSObject
/**
 首付
 */
@property (nonatomic,copy)NSString *sf;
/**
 保证金比例
 */
@property (nonatomic,copy)NSString *marginradio;
/**
 融资规模
 */
@property (nonatomic,copy)NSString *rzgm;
/**
 尾款
 */
@property (nonatomic,copy)NSString *wk;
/**
 利率
 */
@property (nonatomic,copy)NSString *interestrate;
/**
 利息
 */
@property (nonatomic,copy)NSString *lx;
/**
 月供
 */
@property (nonatomic,copy)NSString *yg;
/**
 贷款服务费
 */
@property (nonatomic,copy)NSString *dkfwf;
/**
 表面总支出
 */
@property (nonatomic,copy)NSString *bmzzc;
/**
 车价让利
 */
@property (nonatomic,copy)NSString *cjrl;
/**
 保养/精品赠送
 */
@property (nonatomic,copy)NSString *by;
/**
 三年资金利用
 */
@property (nonatomic,copy)NSString *snzjly;
/**
 年投资回报率
 */
@property (nonatomic,copy)NSString *ntzhbl;
/**
 投资回报
 */
@property (nonatomic,copy)NSString *tzhb;
/**
 年CPI
 */
@property (nonatomic,copy)NSString *ncpi;
/**
 年贬值
 */
@property (nonatomic,copy)NSString *nbz;
/**
 公司可抵税(仅融资租赁增加)
 */
@property (nonatomic,copy)NSString *gskds;
/**
 客户实际购车车本
 */
@property (nonatomic,copy)NSString *khsjgccb;
/**
 残值率
 */
@property (nonatomic,copy)NSString *residualrate;
/**
 残值
 */
@property (nonatomic,copy)NSString *cz;
/**
 客户若换车实际支出
 */
@property (nonatomic,copy)NSString *khrhcsjzc;
@property (nonatomic,copy)NSString *productID;
@property (nonatomic,copy)NSString *productName;
/**
 借款期限
 */
@property (nonatomic,copy)NSString *loanyear;
/**
 首付比例
 */
@property (nonatomic,copy)NSString *paymentradio;
/**
 车型价格
 */
@property (nonatomic,copy)NSString *catModelDetailPrice;
/**
 输入价格
 */
@property (nonatomic,copy)NSString *inputPrice;

/**
 车辆品牌
 */
@property (nonatomic,copy)NSString *catModelDetailName;
/**
 车型名称
 */
@property (nonatomic,copy)NSString *carModelName;
/**
 购置税(元)
 */
@property (nonatomic,copy)NSString *gzs;
/**
 保险(元)
 */
@property (nonatomic,copy)NSString *insurance;
/**
 车系ID
 */
@property (nonatomic,copy)NSString *carSeriesID;
/**
 车型ID
 */
@property (nonatomic,copy)NSString *carModelID;
/**
 销售名称ID
 */
@property (nonatomic,copy)NSString *catModelDetailID;
/**
 保险描述
 */
@property (nonatomic,copy)NSString *insuranceMess;
/**
 总费用
 */
@property (nonatomic,copy)NSString *zfy;
/**
 总购车成本
 */
@property (nonatomic,copy)NSString *zgccb;
/**
 金融方案收益(元)
 */
@property (nonatomic,copy)NSString *zsy;

/**
 购买方式
 */
@property (nonatomic,copy)NSString *buyType;
/**
 总支出
 */
@property (nonatomic,copy)NSString *totalCost;
/**
 开票价
 */
@property (nonatomic,copy)NSString *contractAmount;
@property (nonatomic,copy)NSString *uptoTerm;
/**
 是否达分期
 */
@property (nonatomic,copy)NSString *isInsFq;
/**
 1.自营 2.代理
 */
@property (nonatomic,copy)NSString *productState;
/**
 品牌
 */
@property (nonatomic,copy)NSString *carPpName;
@property (nonatomic,copy)NSString *customCardNumId;
/**
 意向单ID
 */
@property (nonatomic,copy)NSString *intentID;
@property (nonatomic,copy)NSString *mechanismID;
@property (nonatomic,copy)NSString *productCode;

/**
 材料查询 个人
 */
@property (nonatomic,copy)NSString *dataDictP;
/**
 材料查询 企业
 */
@property (nonatomic,copy)NSString *dataDictQ;
/**
 保证金
 */
@property (nonatomic,copy)NSString *bzj;

@property (nonatomic,assign,getter=isCheck)BOOL check;

/**
 保险
 */
@property (nonatomic,copy)NSString *bx;
/**
 期数
 */
@property (nonatomic,copy)NSString *qs;
/**
 费率
 */
@property (nonatomic,copy)NSString *fl;
/**
 手续费率
 */
@property (nonatomic,copy)NSString *sxfl;
/**
 手续费
 */
@property (nonatomic,copy)NSString *sxf;
/**
 车价
 */
@property (nonatomic,copy)NSString *cj;
/**
 留购价
 */
@property (nonatomic,copy)NSString *lgj;
/**
 留购比例
 */
@property (nonatomic,copy)NSString *lgbl;
/**
 保证金比例
 */
@property (nonatomic,copy)NSString *bzjbl;
/**
 购车成本
 */
@property (nonatomic,copy)NSString *gccb;
/**
 抗膨胀
 */
@property (nonatomic,copy)NSString *kpz;
/**
 是否勾选购置税
 */
@property (nonatomic,assign)BOOL isGzsSelected;
/**
 是否勾选保险
 */
@property (nonatomic,assign)BOOL isBxSelected;
@property (nonatomic,copy)NSString *interestRate1;
@property (nonatomic,copy)NSString *interestRate2;
@end
