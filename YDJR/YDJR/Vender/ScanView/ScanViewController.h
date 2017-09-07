//
//  ScanViewController.h
//  二维码扫描与生成模拟
//
//  Created by 吕利峰 on 16/4/6.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ScanWrapper.h"
#import "ScanView.h"
@interface ScanViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/**
 @brief 是否需要扫码图像
 */
@property (nonatomic, assign) BOOL isNeedScanImage;

/**
 @brief  扫码功能封装对象
 */
@property (nonatomic,strong) ScanWrapper* scanObj;

#pragma mark - 扫码界面效果及提示等
/**
 @brief  扫码区域视图,二维码一般都是框
 */
@property (nonatomic,strong) ScanView* qRScanView;




/**
 *  界面效果参数
 */
@property (nonatomic, strong) ScanViewStyle *style;


#pragma mark - 扫码界面效果及提示等


/**
 @brief  扫码当前图片
 */
@property(nonatomic,strong)UIImage* scanImage;


/**
 @brief  启动区域识别功能
 */
@property(nonatomic,assign)BOOL isOpenInterestRect;


/**
 @brief  闪关灯开启状态
 */
@property(nonatomic,assign)BOOL isOpenFlash;


//打开相册
- (void)openLocalPhoto;
//开关闪光灯
- (void)openOrCloseFlash;


//子类继承必须实现的提示
/**
 *  继承者实现的alert提示功能：如没有权限时会调用
 *
 *  @param str 提示语
 */
- (void)showError:(NSString*)str;


- (void)reStartDevice;


@end
