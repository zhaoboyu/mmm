//
//  LLFCompleteTaskModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/5/22.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface LLFCompleteTaskModel : NSObject

/**
 订单ID
 */
@property (nonatomic,copy)NSString *businessId;

/**
 客户Id
 */
@property (nonatomic,copy)NSString *customerId;

/**
 客户姓名
 */
@property (nonatomic,copy)NSString *customerName;

/**
 产品名称
 */
@property (nonatomic,copy)NSString *productName;

/**
 品牌
 */
@property (nonatomic,copy)NSString *carBrand;

/**
 车辆型号
 */
@property (nonatomic,copy)NSString *carModel;

/**
 融资期限
 */
@property (nonatomic,copy)NSString *businessTerm;

/**
 日期
 */
@property (nonatomic,copy)NSString *createDate;

/**
 状态
 */
@property (nonatomic,copy)NSString *state;

/**
 审批状态
 */
@property (nonatomic,copy)NSString *processState;

/**
 补件状态
 */
@property (nonatomic,copy)NSString *patchState;

/**
 补款状态
 */
@property (nonatomic,copy)NSString *replenState;

/**
 补保单状态
 */
@property (nonatomic,copy)NSString *coverPolicy;
@end
