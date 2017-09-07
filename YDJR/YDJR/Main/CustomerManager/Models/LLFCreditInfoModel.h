//
//  LLFCreditInfoModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/29.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
//授信信息
@interface LLFCreditInfoModel : NSObject

/**
 融资金额
 */
@property (nonatomic,copy)NSString *businessSum;
/**
 融资期限
 */
@property (nonatomic,copy)NSString *businessTerm;
/**
 是否按揭
 */
@property (nonatomic,copy)NSString *isMortgaged;
/**
 按揭机构
 */
@property (nonatomic,copy)NSString *mortgagedOrg;
/**
 按揭期限
 */
@property (nonatomic,copy)NSString *mortgagedTerm;
@end
