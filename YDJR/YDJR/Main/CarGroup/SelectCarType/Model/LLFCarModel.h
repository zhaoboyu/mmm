//
//  LLFCarModel.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface LLFCarModel : NSObject
@property (nonatomic,copy)NSString *bak1;//备用字段--车型
@property (nonatomic,copy)NSString *bak2;//备用字段
@property (nonatomic,copy)NSString *bak3;//备用字段
@property (nonatomic,copy)NSString *carPpName;//品牌
@property (nonatomic,copy)NSString *carModelCode;//车型Code
@property (nonatomic,copy)NSString *carModelID;//车型ID
@property (nonatomic,copy)NSString *carModelName;//车型名称
@property (nonatomic,copy)NSString *carSeriesID;//车系ID
@property (nonatomic,copy)NSString *carSeriesName;//车系名称
@property (nonatomic,copy)NSString *catModelDetailID;//销售名称ID
@property (nonatomic,copy)NSString *catModelDetailName;//销售名称<车型 + 排量 + 销售版本>
@property (nonatomic,copy)NSString *catModelDetailPrice;//车型价格
@property (nonatomic,copy)NSString *catModelDetailYear;//车型年份
@property (nonatomic,copy)NSString *catModelID;//车型ID
@property (nonatomic,copy)NSString *gchzjk;//进出口

/**
 进气形式
 */
@property (nonatomic,copy)NSString *jqxs;
/**
 长(mm)
 */
@property (nonatomic,copy)NSString *cc;
/**
 宽(mm)
 */
@property (nonatomic,copy)NSString *kk;
/**
 高(mm)
 */
@property (nonatomic,copy)NSString *gg;
/**
 轴距(mm)
 */
@property (nonatomic,copy)NSString *zj;
/**
 最高车速(km/h)
 */
@property (nonatomic,copy)NSString *zgcs;
/**
 加速时间（0-100km/h)
 */
@property (nonatomic,copy)NSString *jssj;
@end
