//
//  MessageImageInfoModel.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/25.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
@interface MessageImageInfoModel : NSObject

/**
 影像类型图标
 */
@property (nonatomic,copy)NSString *imageUrl;

/**
 影像名称
 */
@property (nonatomic,copy)NSString *imageName;

/**
 影像代码
 */
@property (nonatomic,copy)NSString *imageId;
@end
