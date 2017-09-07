//
//  UIImageView+DownloadImage.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/31.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (DownloadImage)
/**
 *  根据图片地址获取图片
 *
 *  @param imageUrl   图片地址
 *  @param placeholderImage   默认图片
 */
- (void)refreshCarImageWithImageUrl:(NSString *)imageUrl placeholderImage:(UIImage *)placeholderImage;
@end
