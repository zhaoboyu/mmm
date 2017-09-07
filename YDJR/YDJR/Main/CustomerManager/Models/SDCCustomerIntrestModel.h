//
//  SDCCustomerIntrestModel.h
//  YDJR
//
//  Created by sundacheng on 16/10/12.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
/**
 *  用户意向订单
 */
@interface SDCCustomerIntrestModel : NSObject
/**
 *  是否达分期
 */
@property (nonatomic, assign) NSNumber *isInsFq;

/**
 *  意向单id
 */
@property (nonatomic, strong) NSString *intentID;

@property (nonatomic,copy)NSString *interest;
@property (nonatomic,copy)NSString *interestrate;
@property (nonatomic,copy)NSString *investret;
@property (nonatomic,copy)NSString *investretRet;

/**
 购置税
 */
@property (nonatomic,copy)NSString *purchasetax;
@property (nonatomic,copy)NSString *totalCarCost;
@property (nonatomic,copy)NSString *totalSave;
@property (nonatomic,copy)NSString *totalCost;
@property (nonatomic,copy)NSString *totalExp;
@property (nonatomic,copy)NSString *totalRet;


/**
 *  是否自营 1自营 2代理 3达分期
 */
@property (nonatomic, assign) NSNumber *productState;


/**
 *  保险费用
 */
@property (nonatomic, strong) NSString *totalInst;

/**
 *  保险期限
 */
@property (nonatomic, strong) NSString *uptoTerm;


/**
 *  开票价
 */
@property (nonatomic, strong) NSString *contractAmount;


/**
 年cpi
 */
@property (nonatomic,copy)NSString *cpi;

/**
 *  车辆品牌
 */
@property (nonatomic, strong) NSString *carPpName;

/**
 *  车型id
 */
@property (nonatomic, strong) NSString *carModelID;

/**
 车系id
 */
@property (nonatomic,copy)NSString *carSeriesID;

/**
 *  产品id
 */
@property (nonatomic, strong) NSString *productID;

/**
 *  客户id
 */
@property (nonatomic, strong) NSString *customerID;

/**
 抗膨胀金额
 */
@property (nonatomic,copy)NSString *expand;

/**
 空闲资金率
 */
@property (nonatomic,copy)NSString *idleFunds;
/**
 保险金额
 */
@property (nonatomic,copy)NSString *insurance;
/**
 保险名称
 */
@property (nonatomic,copy)NSString *insuranceMess;


/**
 *  车辆指导价格
 */
@property (nonatomic, strong) NSString *carPrice;

/**
 *  销售名id
 */
@property (nonatomic, strong) NSString *catModelDetailID;

/**
 *  产品名称
 */
@property (nonatomic, strong) NSString *productName;

/**
 *  车辆型号
 */
@property (nonatomic, strong) NSString *catModelDetailName;

/**
 *  期数
 */
@property (nonatomic, strong) NSString *instCounts;

/**
 *  申请状态
 0:开始申请
 00:一次进件
 01:已受理
 02:审批中
 03:审批通过
 04:审批拒绝
 05:人工终止
 06:转介中
 07:审批通过
 08:审批失败
 09:首付成功
 10:放款成功
 11:初审
 12:复审
 13:终审
 14:保险购买成功
 15:保险购买失败
 16:查看终审批复
 */
@property (nonatomic, strong) NSString *state;

/**
 *  达分期申请状态
 */
@property (nonatomic, strong) NSString *insuState;


/**
 *  申请时间
 */
@property (nonatomic, strong) NSString *createDate;

/**
 *  融资范围
 */
@property (nonatomic, strong) NSString *includeAmountType;

/**
 *  融资金额
 */
@property (nonatomic, strong) NSString *carrzgm;


/**
 流程状态
 */
@property (nonatomic,copy)NSString *processState;

/**
 终审批复状态 0未收到1已收到
 0:未收到(按state显示)
 1:已收到(显示-查看终审批复文档)
 */
@property (nonatomic,copy)NSString *approveState;

- (BOOL)isClickButtonState;

/**
 补件状态
 01:需补件
 02:补件完成
 */
@property (nonatomic,copy)NSString *patchState;
@end
