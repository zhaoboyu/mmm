//
//  LLFFinalApprovalModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/4/7.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
//终审批复文档信息
@interface LLFFinalApprovalModel : NSObject

/**
 合同编号
 */
@property (nonatomic,copy)NSString *contractSerialNo;
/**
 客户名称
 */
@property (nonatomic,copy)NSString *customerName;
/**
 联合承租人/企业名称
 */
@property (nonatomic,copy)NSString *jointCustomer;
/**
 车辆品牌
 */
@property (nonatomic,copy)NSString *carBrand;
/**
 车辆型号
 */
@property (nonatomic,copy)NSString *carModel;
/**
 融资范围
 */
@property (nonatomic,copy)NSString *includeAmountType;
/**
 项目总额
 */
@property (nonatomic,copy)NSString *projectSum;
/**
 融资金额
 */
@property (nonatomic,copy)NSString *businessSum;
/**
 融资期限
 */
@property (nonatomic,copy)NSString *businessTerm;
/**
 保证金比例
 */
@property (nonatomic,copy)NSString *bZJPercent;
/**
 首付比例
 */
@property (nonatomic,copy)NSString *fPPercent;
/**
 担保人/企业名称
 */
@property (nonatomic,copy)NSString *guaranters;
/**
 意见
 */
@property (nonatomic,copy)NSString *phaseActionType;
/**
 意见说明
 */
@property (nonatomic,copy)NSString *phaseOpinion;
/**
 终审日期
 */
@property (nonatomic,copy)NSString *approveDate;
/**
 放款前落实条件
 */
@property (nonatomic,copy)NSString *putoutClause;
/**
 推送时间
 */
@property (nonatomic,copy)NSString *pushTime;
@end
