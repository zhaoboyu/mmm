//
//  SDCCustomerContactModel.h
//  YDJR
//
//  Created by sundacheng on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

/**
 *  客户联系方式
 */
@interface SDCCustomerContactModel : NSObject

/**
 *  客户地址
 */
@property (nonatomic, strong) NSString *address;

/**
 *  客户id
 */
@property (nonatomic, strong) NSString *customerID;

/**
 *  客户名称
 */
@property (nonatomic, strong) NSString *customerName;

/**
 *  客户电话
 */
@property (nonatomic, strong) NSString *customerPhone;

/**
 *  客户身份号码
 */
@property (nonatomic, strong) NSString *idsNumber;

/**
 *  证件类型
 */
@property (nonatomic, strong) NSString *idsType;

/**
 *  男女
 */
@property (nonatomic, strong) NSString *customerSex;

/**
 *  客户类型
 *  01:企业,03:个人
 */
@property (nonatomic, strong) NSString *customerType;

/**
 *  机构ID
 */
@property (nonatomic, strong) NSString *mechanismID;

/**
 *  操作员编号
 */
@property (nonatomic, strong) NSString *operatorCode;

/**
 企业联系人
 */
@property (nonatomic, strong) NSString *customerLxr;

@property (nonatomic, copy)NSString *customerNo;
@property (nonatomic,assign) NSInteger indexForRow;
@end
