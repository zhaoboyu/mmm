//
//  InsuranceInfoModel.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface InsuranceInfoModel : NSObject
@property (nonatomic,copy)NSString *bak1;//备用字段
@property (nonatomic,copy)NSString *bak2;//备用字段
@property (nonatomic,copy)NSString *bak3;//备用字段
@property (nonatomic,copy)NSString *insuranceCode;//保险代码
@property (nonatomic,copy)NSString *insuranceId;//保险id
@property (nonatomic,copy)NSString *insuranceName;//保险名称
@property (nonatomic,copy)NSString *insurancePrice;//保险价格
@property (nonatomic,copy)NSString *insuranceSort;//保险类型:1(必交险)2(主险)3(附加险)
@property (nonatomic,copy)NSString *insuranceSortName;//保险类型:1(必交险)2(主险)3(附加险)
@property (nonatomic,copy)NSString *dictvalue;//保险期数
@property (nonatomic,copy)NSString *bgImageName;//背景图片
@property (nonatomic,assign)BOOL isSelect;
@end
