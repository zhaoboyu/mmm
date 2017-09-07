//
//  LLFCarInfoModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/29.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
//车辆信息
@interface LLFCarInfoModel : NSObject

/**
 车辆品牌
 */
@property (nonatomic,copy)NSString *carBrand;
/**
 车辆型号
 */
@property (nonatomic,copy)NSString *carModel;
/**
 排量
 */
@property (nonatomic,copy)NSString *displacement;
/**
 使用性质
 */
@property (nonatomic,copy)NSString *useProperty;
@end
