//
//  HGBScanViewController.m
//  YDJR
//
//  Created by huangguangbao on 2017/3/17.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "HGBScanViewController.h"
#import "MainViewController.h"
#import "HGBCommonScanViewStyle.h"
#import "AppDelegate.h"


@interface HGBScanViewController ()<HGBCommonScanControllerDelegate>
{
	CGRect idCardRangeRect;
}
/**
 样式
 */
@property(strong,nonatomic)HGBCommonScanViewStyle *style;
/**
 扫描
 */
@property(strong,nonatomic)HGBCommonScanController *scanVc;

/**
 成功图片
 */
@property(strong,nonatomic)UIImage *sucessImage;
/**
 成功标志
 */
@property(assign,nonatomic)BOOL sucessFlag;
@end

@implementation HGBScanViewController
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.sucessFlag==NO;
	
}
-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
	[super viewDidDisappear:animated];
	
}
- (void)viewDidLoad {
	[super viewDidLoad];
	[self setupNativeView];
	[self viewSetUp];//ui
	
}
#pragma mark 设置导航栏
- (void)setupNativeView
{
	//    self.navigationItem.title = @"扫一扫";
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"LLF_TouMing_Navbar"] forBarMetrics:UIBarMetricsDefault];
	self.tabBarController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"LLF_icon_normal_back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBarButtonItemAction:)];
	[self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
	[self.navigationItem.leftBarButtonItem setTintColor:[UIColor hexString:@"#FF333333"]];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"LLF_TouMing_Navbar"] forBarMetrics:UIBarMetricsDefault];
	
	self.navigationController.navigationBar.shadowImage =[UIImage imageNamed:@"LLF_TouMing_Navbar"];
	
}

//取消
- (void)leftBarButtonItemAction:(UIBarButtonItem *)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}
//前往输入编码界面
- (void)rightBarButtonItemAction:(UIBarButtonItem *)sender
{
}
#pragma mark 设置view
-(void)viewSetUp{
	
	self.scanVc= [[HGBCommonScanController alloc]init];
	self.scanVc.view.frame=CGRectMake(0,64, kWidth, kHeight-64);
	self.scanVc.delegate=self;
	self.scanVc.style =self.style;
	
	[self.view addSubview:self.scanVc.view];
	//    [self  updateScanRectInView];
	[self drawTitle];
	[self addChildViewController:self.scanVc];
	
	
	
	
	
	
	
	if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		[self.scanVc stopScan];
		//        [HGBPrompt promptPromptWithTitle:@"权限提示" Detail:@"由于您的设备暂不支持摄像头，您无法使用该功能!" andWithSucessBlock:^{
		//            [self dismissViewControllerAnimated:YES completion:nil];
		//        } InParent:self];
	}
	NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
	AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
	if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
		[self.scanVc stopScan];
		NSString *errorStr = @"应用相机权限受限,请在设置中启用";
		//        [HGBPrompt promptPromptWithTitle:@"权限提示" Detail:errorStr andWithSucessBlock:^{
		//            [self dismissViewControllerAnimated:YES completion:nil];
		//        } InParent:self];
	}
}

//绘制扫描区域
- (void)drawTitle
{
	if (!_topTitle)
	{
		self.topTitle = [[UILabel alloc]init];
		_topTitle.frame = CGRectMake(0, kHeight - 215 * hScale, kWidth, 42 * hScale);
		
		
		_topTitle.textAlignment = NSTextAlignmentCenter;
		_topTitle.numberOfLines = 0;
		_topTitle.text = @"将二维码放入框内，即可自动扫描";
		_topTitle.textColor = [UIColor hex:@"#FFBFBFBF"];
		_topTitle.font = [UIFont systemFontOfSize:21.0];
		[self.view addSubview:_topTitle];
	}
}

#pragma mark commonScanDelegate
-(void)commonScanImage:(UIImage *)commonImage andWithSize:(CGSize)commonSize{
	
	NSString *resultString=[self identifyCodeImage:commonImage];
	
	NSLog(@"%@",resultString);
	if(self.sucessFlag){
		return;
	}
	if(resultString&&resultString.length>2&&(![resultString isEqualToString:@"null"])){
		self.sucessFlag=YES;
		[self.scanVc stopScan];
		AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
		AudioServicesPlaySystemSound(1007);
		
		//{"customerNo":"666666","idType":"身份证","idsNum":"123456”,”phoneNum”:”15800000000","bankCardNum":"62220000000000”,”userName":"张三"}
		NSMutableDictionary *dafenqiDic = [[Tool dictionaryWithJsonString:resultString] mutableCopy];
		NSMutableDictionary *transferDict = [NSMutableDictionary dictionary];
		transferDict[@"customerNo"] = dafenqiDic[@"CustomerNo"];
		transferDict[@"idsType"] = dafenqiDic[@"idType"];
		transferDict[@"idsNumber"] = dafenqiDic[@"idNum"];
		transferDict[@"customerPhone"] = dafenqiDic[@"phoneNum"];
		transferDict[@"bankCardNum"] = dafenqiDic[@"bankCardNum"];
		transferDict[@"customerName"] = dafenqiDic[@"userName"];
		transferDict[@"cardList"] = dafenqiDic[@"cardList"];
		//操作员编号
		[transferDict setValue:[UserDataModel sharedUserDataModel].operatorCode forKey:@"operatorCode"];
		//        //证件类别
		//        [transferDict setValue:@"IDFS000210" forKey:@"credentialsType"];
		//是否是扫描
		[transferDict setValue:@"0" forKey:@"isScan"];
		NSString *customerSex = [Tool sexStrFromIdentityCard:dafenqiDic[@"idNum"]];
		[transferDict setValue:customerSex forKey:@"customerSex"];
		[[NSUserDefaults standardUserDefaults]setObject:transferDict forKey:@"dafenqiDic"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		MainViewController *applyMainVC = [[MainViewController alloc]init];
        
		applyMainVC.startPage = [Tool getWWWPackAddressWithIndexName:@"toStaging.html"];
		applyMainVC.isDaFenQiApply = YES;
		
		dispatch_async(dispatch_get_main_queue(), ^{
			AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
			appDelegate.mainVC = applyMainVC;
			[self presentViewController:applyMainVC animated:YES completion:nil];
		});
	}
	
}

-(CGRect)getImageSize:(CGSize)imageSize byCardRect:(CGRect)R
{
	CGRect screenBound = self.view.bounds;
	CGFloat tempWidth = screenBound.size.width;
	CGFloat tempHight = screenBound.size.height;
	screenBound.size.height = tempWidth;
	screenBound.size.width = tempHight;
	
	float screenWidth = screenBound.size.width;
	float screenHeight = screenBound.size.height;
	float screenRadio = screenHeight/screenWidth;
	
	float imageWidth = imageSize.width;
	float imageHeight = imageSize.height;
	float imageRadio = imageHeight/imageWidth;
	
	CGRect  imageRect = CGRectZero;
	if (screenRadio<imageRadio)
	{
		float radio = screenWidth/imageWidth;
		float offsetheigh = imageSize.height*radio - screenHeight;
		float realHeight = imageHeight*radio;
		imageRect = CGRectMake((R.origin.x)/realHeight*imageSize.height, (R.origin.y+offsetheigh/2)/screenWidth*imageSize.width, R.size.width/realHeight*imageSize.height, R.size.height/screenWidth*imageSize.width);
	}else
	{
		float radio = screenHeight/imageHeight;
		float offsetWidth = imageSize.width*radio - screenWidth;
		float realWith = imageWidth*radio;
		imageRect = CGRectMake((R.origin.x+offsetWidth/2)/screenHeight*imageSize.height,(R.origin.y)/realWith*imageSize.width, R.size.width/screenHeight*imageSize.height,R.size.height/realWith*imageSize.width);
	}
	
	return imageRect;
}

-(NSString *)identifyCodeImage:(UIImage *)image{
	//2.初始化一个监测器
	CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyLow }];
	//监测到的结果数组
	NSArray *features ;
	if([detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]]){
		features=[detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
	}
	if (features.count >=1) {
		/**结果对象 */
		CIQRCodeFeature *feature = [features objectAtIndex:0];
		NSString *result = feature.messageString;
		return result;
	}
	return nil;
	
}
#pragma mark updateScanRect
-(void)updateScanRectInView{
	CGRect selfBound = self.scanVc.view.bounds;
	CGFloat tempWidth = selfBound.size.width;
	CGFloat tempHight = selfBound.size.height;
	
	float idCardSize_width=tempWidth-self.style.xScanRetangleOffset*2;
	float idCardSize_heigt = idCardSize_width/self.style.whRatio;
	idCardRangeRect = CGRectMake( (tempHight - idCardSize_heigt)*0.5,(tempWidth -idCardSize_width)*0.5+44, idCardSize_heigt,idCardSize_width);
}
#pragma mark get
-(HGBCommonScanViewStyle *)style{
	if(_style==nil){
		HGBCommonScanViewStyle *style = [[HGBCommonScanViewStyle alloc]init];
		style.centerUpOffset = 100 * hScale;
		style.photoframeAngleStyle = HGBScanViewPhotoframeAngleStyle_On;
		style.photoframeLineW = 4;
		style.photoframeAngleW = 88*wScale;
		style.photoframeAngleH = 88*hScale;
		style.isNeedShowRetangle = YES;
		style.promptImage=[UIImage imageNamed:@"icon_erweima"];
		//        style.HorizontalScan=YES;
		style.anmiationStyle = HGBScanViewAnimationStyle_NetGrid;
		style.colorAngle = [UIColor hex:@"#FF000000"];
		//矩形框离左边缘及右边缘的距离
		style.xScanRetangleOffset =(kWidth-1060*wScale)*0.5;
		UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
		
		
		if (orientation == UIInterfaceOrientationPortrait)
		{
			if(style.xScanRetangleOffset<0){
				style.xScanRetangleOffset=100*wScale;
			}
			
		}else if (orientation == UIInterfaceOrientationLandscapeRight) // home键靠右
		{
			
			
			
		}else if (
				  orientation ==UIInterfaceOrientationLandscapeLeft) // home键靠左
		{
			
		}else if (orientation == UIInterfaceOrientationPortraitUpsideDown)
		{
			if(style.xScanRetangleOffset<0){
				style.xScanRetangleOffset=100*wScale;
			}
			
		}
		
		
		//使用的支付宝里面网格图片
		UIImage *imgPartNet = [UIImage imageNamed:@"qrcode_scan_part_net"];
		
		style.whRatio =1;
		
		
		style.animationImage = imgPartNet;
		_style=style;
	}
	return _style;
}

@end
