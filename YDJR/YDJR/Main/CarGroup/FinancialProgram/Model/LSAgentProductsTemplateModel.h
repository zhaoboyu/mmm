//
//  LSAgentProductsTemplateModel.h
//  YDJR
//
//  Created by 李爽 on 2016/11/14.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  代理产品模版model

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface LSAgentProductsTemplateModel : NSObject
/**
 默认值
 */
@property (nonatomic,copy)NSString *procolumdefaut;
/**
 默认值
 */
@property (nonatomic,copy)NSString *myProcolumdefaut;
/**
 默认值数组
 */
@property (nonatomic,strong)NSMutableArray *procolumdefautArray;
/**
 对应单元格行
 */
@property (nonatomic,copy)NSString *procolumformula;
/**
 字段英文名
 */
@property (nonatomic,copy)NSString *procolumdesc;
/**
 中文名
 */
@property (nonatomic,copy)NSString *procolumname;
/**
 0固定，1填写，2下拉，3计算
 */
@property (nonatomic,copy)NSString *procolumpre;
/**
 模版字段ID
 */
@property (nonatomic,copy)NSString *prodictID;
/**
 产品ID
 */
@property (nonatomic,copy)NSString *productID;
@end
