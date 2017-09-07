//
//  UIImage+CreateImageWithColor.m
//  YDJR
//
//  Created by 吕利峰 on 2016/12/22.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "UIImage+CreateImageWithColor.h"

@implementation UIImage (CreateImageWithColor)
/**
 颜色转换图片
 
 @param color 颜色值
 @return 图片
 */
+(UIImage*) createImageWithColor:(NSString*) color
{
    UIColor *imageColor = [UIColor hex:color];
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [imageColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
