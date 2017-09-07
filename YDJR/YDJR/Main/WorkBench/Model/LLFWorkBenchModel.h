//
//  LLFWorkBenchModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/5/22.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
#import "SDCCustomerIntrestModel.h"
#import "LLFDafenqiBusinessModel.h"
#import "SDCCustomerContactModel.h"
@interface LLFWorkBenchModel : NSObject

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

/**
 终审批复状态
 */
@property (nonatomic,copy)NSString *approveState;
/**
 任务状态
 *01:代办,
 *02已办
 */
@property (nonatomic,copy)NSString *workerState;
/**
 任务状态
 *01:达分期,
 *02:自营及代理
 */
@property (nonatomic,copy)NSString *productType;
@property (nonatomic,strong)SDCCustomerIntrestModel *intentModelInfo;
@property (nonatomic,strong)LLFDafenqiBusinessModel *dfqModelInfo;
@property (nonatomic,strong)SDCCustomerContactModel *customerModelInfo;

/**
 产品显示状态
 */
@property (nonatomic,copy)NSString *showState;

/**
 显示时间
 */
@property (nonatomic,copy)NSString *showCreatTime;
- (BOOL)isClickButtonState;
@end
