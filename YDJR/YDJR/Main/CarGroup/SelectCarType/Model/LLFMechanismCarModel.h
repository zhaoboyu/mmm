//
//  LLFMechanismCarModel.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface LLFMechanismCarModel : NSObject
@property (nonatomic,copy)NSString *bak1;//备用字段
@property (nonatomic,copy)NSString *bak2;//备用字段
@property (nonatomic,copy)NSString *bak3;//备用字段
@property (nonatomic,copy)NSString *carPpName;//品牌
@property (nonatomic,copy)NSString *carSeriesCode;//车系ID
@property (nonatomic,copy)NSString *carSeriesID;//车系ID
@property (nonatomic,strong)NSMutableArray *carSeriesImg;//缩略图地址
@property (nonatomic,copy)NSString *carSeriesName;//车系名称
@property (nonatomic,copy)NSString *mechanismID;//机构ID

@end
