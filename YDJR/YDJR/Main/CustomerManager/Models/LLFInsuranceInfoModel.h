//
//  LLFInsuranceInfoModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/29.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
//保险信息
@interface LLFInsuranceInfoModel : NSObject

/**
 被保险人
 */
@property (nonatomic,copy)NSString *insureObject;
/**
 保险公司名称
 */
@property (nonatomic,copy)NSString *insuranceOrg;
/**
 保险期限
 */
@property (nonatomic,copy)NSString *uptoTerm;
/**
 预估保费
 */
@property (nonatomic,copy)NSString *preInsuranceSum;
/**
 应付车船税
 */
@property (nonatomic,copy)NSString *payAblevavtAmount;
/**
 投保城市
 */
@property (nonatomic,copy)NSString *insureCity;
@end
