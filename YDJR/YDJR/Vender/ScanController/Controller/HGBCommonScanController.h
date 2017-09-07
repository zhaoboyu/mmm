//
//  HGBCommonScanController.h
//  CTTX
//
//  Created by huangguangbao on 17/1/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HGBCommonScanViewStyle.h"
#import "HGBCommonScanView.h"

#import <CoreImage/CoreImage.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AudioToolbox/AudioToolbox.h>


#import "AppDelegate.h"


/**
 扫描
 */
@protocol HGBCommonScanControllerDelegate <NSObject>
/**
 返回扫描到的图片

 @param commonImage 图片
 @param commonSize 图片大小
 */
-(void)commonScanImage:(UIImage *)commonImage andWithSize:(CGSize)commonSize;
@end

@interface HGBCommonScanController : UIViewController
@property(strong,nonatomic)id<HGBCommonScanControllerDelegate>delegate;
/**
    @brief 是否需要扫码图像
*/
@property (nonatomic, assign) BOOL isNeedScanImage;
#pragma mark - 扫码界面效果及提示等
/**
 @brief  扫码区域视图,二维码一般都是框
 */
@property (nonatomic,strong)HGBCommonScanView* scanView;
/**
 *  界面效果参数
 */
@property (nonatomic, strong) HGBCommonScanViewStyle *style;



#pragma mark - 扫码界面效果及提示等
/**
 开始扫描
 */
-(void)startScan;
/**
 停止扫描
 */
-(void)stopScan;

@end
