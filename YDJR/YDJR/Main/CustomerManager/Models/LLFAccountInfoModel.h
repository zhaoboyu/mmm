//
//  LLFAccountInfoModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/29.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//
//银行卡信息
#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface LLFAccountInfoModel : NSObject

/**
 开户名称
 */
@property (nonatomic,copy)NSString *accountName;
/**
 开户银行
 */
@property (nonatomic,copy)NSString *accountOrgID;
/**
 开户银行编号
 */
@property (nonatomic,copy)NSString *accountOrgIDNo;
/**
 银行卡卡号
 */
@property (nonatomic,copy)NSString *accountNo;
/**
 开户人身份证号
 */
@property (nonatomic,copy)NSString *accountCertID;
@end
