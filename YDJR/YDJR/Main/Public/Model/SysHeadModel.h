//
//  sysHeadModel.h
//  CTTX
//
//  Created by 吕利峰 on 16/5/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

@interface SysHeadModel : NSObject
/**
 服务代码
 */
@property (nonatomic,copy)NSString *TransServiceCode;

/**
 平台类型
 */
@property (nonatomic,copy)NSString *PlatformType;

/**
 时间戳
 */
@property (nonatomic,copy)NSString *TimeStamp;

/**
 应答码
 */
@property (nonatomic,copy)NSString *ReturnCode;

/**
 应答信息
 */
@property (nonatomic,copy)NSString *ReturnMessage;
@end
