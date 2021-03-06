//
//  SubScanViewController.h
//  二维码扫描与生成模拟
//
//  Created by 吕利峰 on 16/4/6.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "ScanViewController.h"
typedef void (^ResultCallback)(id responseData);
//继承LBXScanViewController,在界面上绘制想要的按钮，提示语等
@interface SubScanViewController : ScanViewController
#pragma mark -模仿qq界面

@property (nonatomic, assign) BOOL isQQSimulator;

/**
 @brief  扫码区域上方提示文字
 */
@property (nonatomic, strong) UILabel *topTitle;

#pragma mark --增加拉近/远视频界面
@property (nonatomic, assign) BOOL isVideoZoom;

#pragma mark - 底部几个功能：开启闪光灯、相册、我的二维码
//底部显示的功能项
@property (nonatomic, strong) UIView *bottomItemsView;
//相册
@property (nonatomic, strong) UIButton *btnPhoto;
//闪光灯
@property (nonatomic, strong) UIButton *btnFlash;
//我的二维码
@property (nonatomic, strong) UIButton *btnMyQR;
@property (nonatomic, copy) ResultCallback resultBlock;


@end
