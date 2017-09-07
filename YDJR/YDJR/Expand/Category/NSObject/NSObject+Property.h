//
//  NSObject+Property.h
//  YDJR
//
//  Created by 李爽 on 2017/5/2.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 自动生成属性的分类
 */
@interface NSObject (Property)

+ (void)creatPropertyCodeWithDictionary:(NSDictionary *)dict;
@end
