//
//  UIImageView+DownloadImage.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/31.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "UIImageView+DownloadImage.h"

@implementation UIImageView (DownloadImage)
/**
 *  根据图片地址获取图片
 *
 *  @param imageUrl   图片地址
 *  @param placeholderImage   默认图片
 */
- (void)refreshCarImageWithImageUrl:(NSString *)imageUrl placeholderImage:(UIImage *)placeholderImage
{
    self.image = placeholderImage;
    [Tool refreshCarImageWithImageUrl:imageUrl placeholderImage:placeholderImage imageBlock:^(UIImage *image) {
        self.image = image;
    }];
}
@end
