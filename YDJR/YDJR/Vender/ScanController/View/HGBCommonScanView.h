//
//  HGBCommonScanView.h
//  CTTX
//
//  Created by huangguangbao on 17/1/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGBCommonScanNetAnimation.h"
#import "HGBCommonScanLineAnimation.h"
#import "HGBCommonScanViewStyle.h"

/**
 扫描view
 */
@interface HGBCommonScanView : UIView
/**
 @brief  初始化
 @param frame 位置大小
 @param style 类型
 
 @return instancetype
 */
-(id)initWithFrame:(CGRect)frame style:(HGBCommonScanViewStyle*)style;

/**
 *  设备启动中文字提示
 */
- (void)startDeviceReadyingWithText:(NSString*)text;

/**
 *  设备启动完成
 */
- (void)stopDeviceReadying;

/**
 *  开始扫描动画
 */
- (void)startScanAnimation;

/**
 *  结束扫描动画
 */
- (void)stopScanAnimation;

//

/**
 @brief  根据矩形区域，获取识别兴趣区域
 @param view  视频流显示UIView
 @param style 效果界面参数
 @return 识别区域
 */
+ (CGRect)getScanRectWithPreView:(UIView*)view style:(HGBCommonScanViewStyle*)style;


@end
