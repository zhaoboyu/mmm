//
//  UIView+MakeImage.m
//  YDJR
//
//  Created by 吕利峰 on 2017/4/7.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "UIView+MakeImage.h"

@implementation UIView (MakeImage)
#pragma mark 生成image
- (UIImage *)makeImagewithSize:(CGSize)size
{
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
@end
