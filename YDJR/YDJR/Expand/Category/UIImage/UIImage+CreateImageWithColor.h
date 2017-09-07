//
//  UIImage+CreateImageWithColor.h
//  YDJR
//
//  Created by 吕利峰 on 2016/12/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CreateImageWithColor)


/**
 颜色转换图片

 @param color 颜色值
 @return 图片
 */
+(UIImage*) createImageWithColor:(NSString*) color;
@end
