//
//  SubScanViewController.m
//  二维码扫描与生成模拟
//
//  Created by 吕利峰 on 16/4/6.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SubScanViewController.h"
#import "MyQRViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"
#define dafenqibaowen @"{\"customerNo\":\"111111111111111111111\",\"idType\":\"1\",\"idNum\":\"411123199008144534\",\"phoneNum\":\"13111111111\",\"bankCardNum\":\"1111111111111111\",\"userNmae\":\"张三\"}"
@interface SubScanViewController ()<UIAlertViewDelegate>

@end

@implementation SubScanViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupNativeView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor blackColor];
    
    //设置扫码后需要扫码图像
    self.isNeedScanImage = YES;
//    [self setupNativeView];
}
#pragma mark 设置导航栏
- (void)setupNativeView
{
//    self.navigationItem.title = @"扫一扫";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"LLF_TouMing_Navbar"] forBarMetrics:UIBarMetricsDefault];
    //    self.tabBarController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"LLF_icon_normal_back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonItemAction:)];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor hexString:@"#FF333333"]];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"LLF_TouMing_Navbar"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"LLF_TouMing_Navbar"];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

//    [self drawBottomItems];
    [self drawTitle];
    [self.view bringSubviewToFront:_topTitle];
}
//取消
- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//前往输入编码界面
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{
//    CheckViolationNumViewController *checkViolationNumVC = [[CheckViolationNumViewController alloc]init];
//    [self.navigationController pushViewController:checkViolationNumVC animated:YES];
}
//绘制扫描区域
- (void)drawTitle
{
    if (!_topTitle)
    {
        self.topTitle = [[UILabel alloc]init];
        _topTitle.frame = CGRectMake(0, kHeight - 270 * hScale - 44, kWidth, 42 * hScale);
        
        
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将二维码放入框内，即可自动扫描";
        _topTitle.textColor = [UIColor hex:@"#FFBFBFBF"];
        _topTitle.font = [UIFont systemFontOfSize:21.0];
        [self.view addSubview:_topTitle];
    }
}



- (void)drawBottomItems
{
    if (_bottomItemsView) {
        
        return;
    }
    
    self.bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame)-164,
                                                                   CGRectGetWidth(self.view.frame), 100)];
    _bottomItemsView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    [self.view addSubview:_bottomItemsView];
    
    CGSize size = CGSizeMake(65, 87);
    self.btnFlash = [[UIButton alloc]init];
    _btnFlash.bounds = CGRectMake(0, 0, size.width, size.height);
    _btnFlash.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/2, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnFlash setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
    [_btnFlash addTarget:self action:@selector(openOrCloseFlash) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnPhoto = [[UIButton alloc]init];
    _btnPhoto.bounds = _btnFlash.bounds;
    _btnPhoto.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame)/4, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnPhoto setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_nor"] forState:UIControlStateNormal];
    [_btnPhoto setImage:[UIImage imageNamed:@"qrcode_scan_btn_photo_down"] forState:UIControlStateHighlighted];
    [_btnPhoto addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    self.btnMyQR = [[UIButton alloc]init];
    _btnMyQR.bounds = _btnFlash.bounds;
    _btnMyQR.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) * 3/4, CGRectGetHeight(_bottomItemsView.frame)/2);
    [_btnMyQR setImage:[UIImage imageNamed:@"qrcode_scan_btn_myqrcode_nor"] forState:UIControlStateNormal];
    [_btnMyQR setImage:[UIImage imageNamed:@"qrcode_scan_btn_myqrcode_down"] forState:UIControlStateHighlighted];
    [_btnMyQR addTarget:self action:@selector(myQRCode) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomItemsView addSubview:_btnFlash];
    [_bottomItemsView addSubview:_btnPhoto];
    [_bottomItemsView addSubview:_btnMyQR];
    
}







- (void)showError:(NSString*)str
{
//    [LBXAlertAction showAlertWithTitle:@"提示" msg:str chooseBlock:nil buttonsStatement:@"知道了",nil];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alert show];
}


//扫描结果
- (void)scanResultWithArray:(NSArray<ScanResult*>*)array
{
    
    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
//    for (ScanResult *result in array) {
//        
//        NSLog(@"scanResult:%@",result.strScanned);
//    }
    
    ScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //震动提醒
    [ScanWrapper systemVibrate];
    //声音提醒
    [ScanWrapper systemSound];
    
    [self showNextVCWithScanResult:scanResult];
    
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
//    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult chooseBlock:^(NSInteger buttonIdx) {
//        
//        //点击完，继续扫码
//        [weakSelf reStartDevice];
//    } buttonsStatement:@"知道了",nil];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"扫码内容" message:strResult delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    [alert show];
}
#pragma mark UIAlertView代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    __weak __typeof(self) weakSelf = self;
    if (buttonIndex == 0) {
        [weakSelf reStartDevice];
    }
}
- (void)showNextVCWithScanResult:(ScanResult*)strResult
{
//    ScanResultViewController *vc = [ScanResultViewController new];
//    vc.imgScan = strResult.imgScanned;
//    
//    vc.strScan = strResult.strScanned;
//    
//    vc.strCodeType = strResult.strBarCodeType;
//    
//    [self.navigationController pushViewController:vc animated:YES];
    if ([strResult.strScanned hasPrefix:@"http"] || [strResult.strScanned hasPrefix:@"https"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strResult.strScanned]];
        [self reStartDevice];
    }else{
//        NSDictionary *dafenqiDic = [Tool dictionaryWithJsonString:dafenqibaowen];
        NSDictionary *dafenqiDic = [Tool dictionaryWithJsonString:strResult.strScanned];
        NSLog(@"%@",dafenqiDic);
        if (!dafenqiDic) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"扫码内容" message:@"客户基本信息有误,请重新扫描!" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
            [alert show];
        }else{
			[[NSUserDefaults standardUserDefaults]setObject:dafenqiDic forKey:@"dafenqiDic"];
			[[NSUserDefaults standardUserDefaults] synchronize];
			MainViewController *applyMainVC = [[MainViewController alloc]init];
			applyMainVC.startPage = @"toStaging.html";
			
			AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
			appDelegate.mainVC = applyMainVC;
			
			[self presentViewController:applyMainVC animated:YES completion:nil];
        }

    }
    
    
    
}


#pragma mark -底部功能项
//打开相册
- (void)openPhoto
{
    if ([ScanWrapper isGetPhotoPermission])
        [self openLocalPhoto];
    else
    {
        [self showError:@"      请到设置->隐私中开启本程序相册权限     "];
    }
}

//开关闪光灯
- (void)openOrCloseFlash
{
    
    [super openOrCloseFlash];
    
    
    if (self.isOpenFlash)
    {
        [_btnFlash setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_down"] forState:UIControlStateNormal];
    }
    else
        [_btnFlash setImage:[UIImage imageNamed:@"qrcode_scan_btn_flash_nor"] forState:UIControlStateNormal];
}


#pragma mark -底部功能项


- (void)myQRCode
{
    MyQRViewController *vc = [MyQRViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
