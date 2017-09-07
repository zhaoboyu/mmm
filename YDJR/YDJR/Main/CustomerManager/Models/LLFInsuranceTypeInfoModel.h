//
//  LLFInsuranceTypeInfoModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/29.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
//险种信息
@interface LLFInsuranceTypeInfoModel : NSObject

/**
 机动车损失险
 */
@property (nonatomic,copy)NSString *carLossInsFlag;
/**
 机动车第三者责任保险
 */
@property (nonatomic,copy)NSString *thirdDutyFlag;
/**
 机动车全车盗抢保险
 */
@property (nonatomic,copy)NSString *carRobberyFlag;
/**
 玻璃单独破碎险
 */
@property (nonatomic,copy)NSString *glassBreakFlag;
/**
 机动车车上人员责任保险
 */
@property (nonatomic,copy)NSString *carPersonSum;
/**
 车身划痕损失险
 */
@property (nonatomic,copy)NSString *carBodyLossSum;
/**
 自燃损失险
 */
@property (nonatomic,copy)NSString *selfIgniteFlag;
/**
 不计免赔率险
 */
@property (nonatomic,copy)NSString *nofreerFlag;
/**
 新增设备损失险
 */
@property (nonatomic,copy)NSString *addEquipmentLoss;
/**
 发动机涉水损失险
 */
@property (nonatomic,copy)NSString *engineWadingLoss;
/**
 机动车损失保险无法找到第三方特约险
 */
@property (nonatomic,copy)NSString *canNotFindThirdPartySpecial;
/**
 修理期间费用补偿险
 */
@property (nonatomic,copy)NSString *costCompenSation;
/**
 车上货物责任险
 */
@property (nonatomic,copy)NSString *carGoresPonsibility;
/**
 精神损害抚慰金责任险
 */
@property (nonatomic,copy)NSString *mentalinjury;
/**
 指定修理厂险
 */
@property (nonatomic,copy)NSString *designatedRepairShop;
/**
 交强险
 */
@property (nonatomic,copy)NSString *eforceInsurance;

@end
