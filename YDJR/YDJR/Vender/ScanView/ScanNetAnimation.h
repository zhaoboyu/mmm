//
//  ScanNetAnimation.h
//  二维码扫描与生成模拟
//
//  Created by 吕利峰 on 16/4/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanNetAnimation : UIImageView
/**
 *  开始扫码网格效果
 *
 *  @param animationRect 显示在parentView中得区域
 *  @param parentView    动画显示在UIView
 *  @param image     扫码线的图像
 */
- (void)startAnimatingWithRect:(CGRect)animationRect InView:(UIView*)parentView Image:(UIImage*)image andWithDirection:(NSInteger)direction;

/**
 *  停止动画
 */
- (void)stopAnimating;
@end
