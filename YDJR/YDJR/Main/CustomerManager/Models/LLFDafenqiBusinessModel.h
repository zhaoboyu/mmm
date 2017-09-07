//
//  LLFDafenqiBusinessModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/29.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLFCarInfoModel.h"
#import "LLFCreditInfoModel.h"
#import "LLFAccountInfoModel.h"
#import "LLFInsuranceInfoModel.h"
#import "LLFInsuranceTypeInfoModel.h"
#import "YYModel.h"
@interface LLFDafenqiBusinessModel : NSObject

/**
 订单号
 */
@property (nonatomic,copy)NSString *businessID;
/**
 经办店名称
 */
@property (nonatomic,copy)NSString *operateOrgName;
/**
 首付款金额
 */
@property (nonatomic,copy)NSString *downPayment;

/**
 借款合同编号
 */
@property (nonatomic,copy)NSString *loanContractNo;
/**
 委托合同编号
 */
@property (nonatomic,copy)NSString *insuranceContractNo;
/**
 流程状态
 01:创建订单
 02:待客户确认
 03:客户确认
 04:客户拒绝
 05:审批中
 06:审批通过,二次进件
 07:审批拒绝
 08:保险购买成功
 09:保险购买失败
 10:待放款
 11:已放款
 12:需补保单
 13:一次进件
 14:二次进件完成
 15:补保单完成
 */
@property (nonatomic,copy)NSString *processState;
/**
 补件状态
 00:无
 01:补件中
 */
@property (nonatomic,copy)NSString *patchState;
/**
 创建时间
 */
@property (nonatomic,copy)NSString *createDate;
/**
 银行卡信息
 */
@property (nonatomic,strong)LLFAccountInfoModel *accountInfo;
/**
 授信信息
 */
@property (nonatomic,strong)LLFCreditInfoModel *creditInfo;
/**
 车辆信息
 */
@property (nonatomic,strong)LLFCarInfoModel *carInfo;
/**
 保险信息
 */
@property (nonatomic,strong)LLFInsuranceInfoModel *insuranceInfo;
/**
 险种信息
 */
@property (nonatomic,strong)LLFInsuranceTypeInfoModel *insuranceTypeInfo;

/**
 显示状态
 */
@property (nonatomic,copy)NSString *state;

/**
 补款状态
 *0:未补款
 *1:补款中
 *2:补款成功
 */
@property (nonatomic,copy)NSString *replenState;

/**
 补款状态
 */
@property (nonatomic,copy)NSString *changeReplenState;

/**
 补保单状态
 *01:补保单
 *02:补保单完成
 */
@property (nonatomic,copy)NSString *coverPolicy;
/**
 信贷的业务编号
 */
@property (nonatomic,copy)NSString *applySerialNo;

/**
 是否是简版达分期产品
 01:是简版达分期
 */
@property (nonatomic,copy)NSString *terminalType;
/**
 根据processState和patchState来判断当前按钮是否可点击
 
 @return yes:可点击,NO:不可点击
 */
- (BOOL)isClickButtonState;

/**
 判断是否可以查看申请书
 
 @return yes:可点击,NO:不可点击
 */
- (BOOL)isCanApplyBook;
/**
 是否显示补款状态
 
 @return yes:显示,no:不显示
 */
- (BOOL)isReplenishment;
/**
 是否可以取消申请
 
 @return yes:可点击,NO:不可点击
 */
- (BOOL)isCanCancleApply;
@end
