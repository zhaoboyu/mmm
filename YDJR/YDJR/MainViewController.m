/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  Cordova_TEST
//
//  Created by Yalin on 14-4-23.
//  Copyright com.nationsky 2014年. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "UIWebView+ToFile.h"
#import "LLFPDFManager.h"
#import "LLFPrintPageRenderer.h"
#import "CTTXRequestServer+CustomerManager.h"
#import "SSZipArchive.h"

@interface MainViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UIPrintInteractionControllerDelegate>
@property(nonatomic,strong)ModalTransitionAnimation *animation;//模态动画
@property (nonatomic,strong)UIImageView *headView;
//加载框
@property (nonatomic,strong)HGBPromgressHud *phud;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSString *docmentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"%@",docmentPath);
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSString *wwwPath = [docmentPath stringByAppendingPathComponent:@"/www"];
        if ([fileMgr fileExistsAtPath:wwwPath]) {
            self.wwwFolderName = [NSString stringWithFormat:@"file:///%@",wwwPath];
        }else{
            self.wwwFolderName = @"/www";
        }
//        self.startPage = @"222.html";
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
        
        //        [self createNavigationItem];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
        //        [self createNavigationItem];
        //        self.navigationController.navigationBar.hidden=YES;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    // View defaults to full size.  If you want to customize the view's size, or its subviews (e.g. webView),
    // you can do so here.
    
    [super viewWillAppear:animated];
    [UserDataModel sharedUserDataModel].flag = 1;
//    self.navigationController.navigationBar.hidden = YES;
//     [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
}
- (void)leftBarButtonItemAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [Tool cleanCacheAndCookie];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.animation = [[ModalTransitionAnimation alloc] init];
    self.view.backgroundColor=[UIColor whiteColor];
    self.webView.scalesPageToFit=YES;
    self.webView.delegate=self;
    self.webView.scrollView.delegate = self;
//    self.webView.scrollView.contentSize=CGSizeMake(kWidth,0);
//    UIScreenEdgePanGestureRecognizer *pan=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(customControllerEdgePopHandle:)];
//    pan.delegate=self;
//    pan.edges=UIRectEdgeLeft;
//    [self.webView addGestureRecognizer:pan];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNatiView) name:@"print" object:@"print"];
    if (self.isHaveTop) {
       [self creatNatiView];
    }
    if (self.isApplyTop) {
        [self creatApplyNatiView];
    }
	if (self.isContractTop) {
		[self createContractNatiView];
	}
	
}

#pragma mark 模态动画代理
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    _animation.animationType = AnimationTypePresent;
    return _animation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _animation.animationType = AnimationTypeDismiss;
    return _animation;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

/* Comment out the block below to over-ride */

/*
 - (UIWebView*) newCordovaViewWithFrame:(CGRect)bounds
 {
 return[super newCordovaViewWithFrame:bounds];
 }
 */

#pragma mark UIWebDelegate implementation

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    [self.phud hideSave];
    // Black base color for background matches the native apps

//    theWebView.backgroundColor = [UIColor blackColor];
//    self.view.backgroundColor=[UIColor whiteColor];
//    theWebView.scrollView.backgroundColor=[UIColor whiteColor];

	if (self.isApplyTop) {
		theWebView.scrollView.scrollEnabled=NO;
	}
	if (!self.isHaveTop) {
		theWebView.scrollView.scrollEnabled = NO;
	}
	if (self.isDaFenQiApply) {
		theWebView.scrollView.scrollEnabled = NO;
	}
	if (self.isContractTop) {
		theWebView.scrollView.scrollEnabled = YES;
	}
    NSString *wwwVersinStr = [theWebView stringByEvaluatingJavaScriptFromString:@"versionNumber()"];
    [self versionUpdateDetectionWithWwwVersinStr:wwwVersinStr];
    return [super webViewDidFinishLoad:theWebView];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    NSLog(@"lvlifeng");
    [self.phud showHUDSaveAddedTo:self.webView];
}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    NSLog(@"huanggb");
//    //判断是否是单击
////    if (navigationType == UIWebViewNavigationTypeLinkClicked)
////    {
////        NSURL *url = [request URL];
////        if([[UIApplication sharedApplication]canOpenURL:url])
////        {
////            [[UIApplication sharedApplication]openURL:url];
////        }
////        return NO;
////    }
//    return YES;
//}
/* Comment out the block below to over-ride */

/*
 
 - (void) webViewDidStartLoad:(UIWebView*)theWebView
 {
 return [super webViewDidStartLoad:theWebView];
 }
 
 - (void) webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
 {
 return [super webView:theWebView didFailLoadWithError:error];
 }
 */

/**
 打印申请书
 */
- (void)creatNatiView
{

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_Nav"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back_Nav"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor hexString:@"#FFFFFFFF"]];
    
    self.navigationItem.title = @"客户申请";
    NSMutableDictionary *titleAttributesDic = [NSMutableDictionary dictionary];
    [titleAttributesDic setObject:[UIColor hexString:@"#FFFFFFFF"] forKey:NSForegroundColorAttributeName];
    [titleAttributesDic setObject:[UIFont systemFontOfSize:18.0] forKey:NSFontAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributesDic];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"打印申请书" style:UIBarButtonItemStyleDone target:self action:@selector(printApplyInfoAction:)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor hexString:@"#FFFFFFFF"]];

    
    
}
/**
 查看申请书
 */
- (void)creatApplyNatiView
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_Nav"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back_Nav"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
    [self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor hexString:@"#FFFFFFFF"]];
    
    self.navigationItem.title = @"查看申请书";
    NSMutableDictionary *titleAttributesDic = [NSMutableDictionary dictionary];
    [titleAttributesDic setObject:[UIColor hexString:@"#FFFFFFFF"] forKey:NSForegroundColorAttributeName];
    [titleAttributesDic setObject:[UIFont systemFontOfSize:18.0] forKey:NSFontAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributesDic];
    
    if ([self.productstate isEqualToString:@"1"]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消申请" style:UIBarButtonItemStyleDone target:self action:@selector(cancleApplyAction:)];
        [self.navigationItem.rightBarButtonItem setTintColor:[UIColor hexString:@"#FFFFFFFF"]];
    }
    
    
    
    
}

/**
 查看合同
 */
- (void)createContractNatiView
{
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_Nav"] forBarMetrics:UIBarMetricsDefault];
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_back_Nav"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBarButtonItemAction:)];
	[self.navigationItem.leftBarButtonItem setImageInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
	[self.navigationItem.leftBarButtonItem setTintColor:[UIColor hexString:@"#FFFFFFFF"]];
	
	self.navigationItem.title = @"查看合同";
	NSMutableDictionary *titleAttributesDic = [NSMutableDictionary dictionary];
	[titleAttributesDic setObject:[UIColor hexString:@"#FFFFFFFF"] forKey:NSForegroundColorAttributeName];
	[titleAttributesDic setObject:[UIFont systemFontOfSize:18.0] forKey:NSFontAttributeName];
	[self.navigationController.navigationBar setTitleTextAttributes:titleAttributesDic];
}

/**
 取消申请

 @param sender 取消申请
 */
- (void)cancleApplyAction:(UIButton *)sender
{
    [self cancelApplyAction];
}
#pragma mark - action
- (void)cancelApplyAction {
    
    NSLog(@"%@ %@",self.intentID,self.productID);
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您正在撤回申请，是否继续当前操作？" preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf cancelApi];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVc addAction:confirmAction];
    [alertVc addAction:cancelAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)cancelApi {
    [self.phud showHUDSaveAddedTo:self.view];
    [[CTTXRequestServer shareInstance] stateChangeWithApproveStatus:@"05" intentID:self.intentID productID:self.productID SuccessBlock:^(NSString *code, NSString *msg) {
        [self.phud hideSave];
        if (code && code.intValue == 0) {
            [self leftBarButtonItemAction:nil];
            
        } else {
            self.phud.promptStr = @"取消申请失败!";
            [self.phud showHUDResultAddedTo:self.view];
        }
        
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        self.phud.promptStr = @"取消申请失败!";
        [self.phud showHUDResultAddedTo:self.view];
    }];
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}
- (void)printApplyInfoAction:(UIButton *)sender
{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择打印方式!" preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"存储到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf saveApplyInfoToLocal];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"直接打印" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf print];
    }];
    
    [alertVc addAction:confirmAction];
    [alertVc addAction:cancelAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}
- (void)saveApplyInfoToLocal
{
    UIImage *ApplyImage = [self.webView imageRepresentation];
    NSData *imageData = UIImagePNGRepresentation(ApplyImage);
    NSString *filePath = [NSString stringWithFormat:@"%@123.png",NSTemporaryDirectory()];
    //Save PDF to directory for usage
    if (imageData) {
        [imageData writeToFile:filePath atomically: YES];
    }
    else
    {
        NSLog(@"PDF couldnot be created");
    }
     UIImageWriteToSavedPhotosAlbum(ApplyImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败";
    }else{
        msg = @"保存图片成功";
    }
    self.phud.promptStr = msg;
    [self.phud showHUDResultAddedTo:self.view];
}
- (void)print
{
    
    UIPrintInteractionController *printC = [UIPrintInteractionController sharedPrintController];//显示出打印的用户界面。
    printC.delegate = self;
    NSString *fileName = @"apply";
//    [self.webView PDFDataWithFileName:fileName];
    //    NSString *filePath = [LLFPDFManager pdfDestPath:fileName];
//    NSString *filePath = [NSString stringWithFormat:@"%@tmp.pdf",NSTemporaryDirectory()];
    
//    filePath = [NSString stringWithFormat:@"file:///%@",filePath];
//    NSLog(@"printAction_______%@",filePath);
    
//    NSURL *fileUrl = [NSURL URLWithString:filePath];
    
//    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];

    
    //    UIImage *img = [self.webView imageRepresentation];
    //    NSData *data = [NSData dataWithData:UIImagePNGRepresentation(img)];
//    NSData *data = [self makeImage];
    UIImage *ApplyImage = [self.webView imageRepresentation];
    NSData *imageData = UIImagePNGRepresentation(ApplyImage);
    if (printC && [UIPrintInteractionController canPrintData:imageData]) {
        
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];//准备打印信息以预设值初始化的对象。
//        printInfo.duplex = UIPrintInfoDuplexNone;
        printInfo.outputType = UIPrintInfoOutputGrayscale;//设置输出类型。
        printC.showsPageRange = YES;//显示的页面范围
        printInfo.orientation = UIPrintInfoOrientationPortrait;
        printInfo.jobName = fileName;
        
        printC.printInfo = printInfo;
        printC.showsPaperSelectionForLoadedPapers = YES;
//        UIViewPrintFormatter *viewFormatter = [self.webView viewPrintFormatter];
//        viewFormatter.startPage = 0;
//        printC.printFormatter = viewFormatter;
                printC.printingItem = imageData;
        //        NSLog(@"printinfo-%@",printC.printInfo);
//        printC.printingItem = data;//single NSData, NSURL, UIImage, ALAsset
        //        NSLog(@"printingitem-%@",printC);
        
        
        //    等待完成
		
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
        ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"可能无法完成，因为印刷错误: %@", error);
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"打印失败!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else if (!completed){
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"打印取消" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"打印成功!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }
        };
        
//                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        
//                    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:sender];//调用方法的时候，要注意参数的类型－下面presentFromBarButtonItem:的参数类型是 UIBarButtonItem..如果你是在系统的UIToolbar or UINavigationItem上放的一个打印button，就不需要转换了。
//                    [printC presentFromBarButtonItem:item animated:YES completionHandler:completionHandler];//在ipad上弹出打印那个页面
//        //            [printC presentAnimated:YES completionHandler:completionHandler];//在iPhone上弹出打印那个页面
//        
//        
//                } else {
        [printC presentAnimated:YES completionHandler:completionHandler];//在iPhone上弹出打印那个页面
//                }
        
        
    }
}
#pragma mark 生成image

- (NSData *)makeImage

{

    LLFPrintPageRenderer *render = [[LLFPrintPageRenderer alloc] init];
    [render addPrintFormatter:self.webView.viewPrintFormatter startingAtPageAtIndex:0];
    
    ////provide padding ---- increase these values according to your requirement
    float topPadding = 10.0f;
    float bottomPadding = 10.0f;
    float leftPadding = 10.0f;
    float rightPadding = 10.0f;
    
    //provide rect for printing and for actual PDF Rect of page
    CGRect printableRect = CGRectMake(leftPadding,
                                      topPadding,
                                      kPaperSizeA4.width-leftPadding-rightPadding,
                                      kPaperSizeA4.height-topPadding-bottomPadding);
    CGRect paperRect = CGRectMake(0, 0, kPaperSizeA4.width, kPaperSizeA4.height);
    [render setValue:[NSValue valueWithCGRect:paperRect] forKey:@"paperRect"];
    [render setValue:[NSValue valueWithCGRect:printableRect] forKey:@"printableRect"];
    //
    ////category created above is used here
    NSData *pdfData = [render printToPDF];
    NSString *filePath = [NSString stringWithFormat:@"%@tmp.pdf",NSTemporaryDirectory()];
    //Save PDF to directory for usage
    if (pdfData) {
        [pdfData writeToFile:filePath atomically: YES];
    }
    else
    {
        NSLog(@"PDF couldnot be created");
    }
    
    NSLog(@"------------%@",filePath);
    
    return pdfData;

    
}
//www包版本更新的检测
- (void)versionUpdateDetectionWithWwwVersinStr:(NSString *)wwwVersinStr
{
    NSArray *localArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *dataDic = localArr[0];
    NSArray *arr = [dataDic objectForKey:@"IDFS000325"];
    if (arr.count > 2) {
        NSDictionary *versionDic = arr[3];
        NSString *newVersion = [versionDic objectForKey:@"dictdesc"];
        if ([newVersion compare:wwwVersinStr options:NSNumericSearch] == NSOrderedDescending) {
            NSString *updataStr = [NSString stringWithFormat:@"请升级到最新版本(%@),以免影响您的使用体验",newVersion];
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"版本升级" message:updataStr preferredStyle:UIAlertControllerStyleAlert];
            
            __weak typeof(self) weakSelf = self;
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf versionUpdate];
            }];
            
            [alertVc addAction:confirmAction];
            
            [self presentViewController:alertVc animated:YES completion:nil];
//            UIAlertView *updataAlert = [[UIAlertView alloc]initWithTitle:@"版本升级" message:updataStr delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles: nil];
//            updataAlert.tag = 101;
//            [updataAlert show];
            
        }
    }
    
}
- (void)versionUpdate
{
    NSString *url = [NSString stringWithFormat:@"%@www.zip",baseNetWorkURL];
    NetworkRequest *request = [[NetworkRequest alloc]init];
    request.url = [url stringByAppendingFormat:@"?time=%@",[Tool getTimeStr]];
    request.requestMethod = @"GET";
    request.isDownFile = YES;
    self.phud.promptStr = @"版本更新中,请稍后...";
    [self.phud showHUDResultAddedTo:self.view];
    [request requestWithSuccessBlock:^(id responseObject) {
        [self.phud hideSave];
        NSString *docmentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"%@",docmentPath);
        NSString *unzipPath = [docmentPath stringByAppendingPathComponent:@"/www"];
        NSString *zipPath = [docmentPath stringByAppendingPathComponent:@"/www.zip"];
        //创建一个文件
        NSFileManager *fileManage = [NSFileManager defaultManager];
        if ([fileManage fileExistsAtPath:zipPath]) {
            NSError *err;
            [fileManage removeItemAtPath:zipPath error:&err];
        }
        [fileManage createFileAtPath:zipPath contents:nil attributes:nil];
        [responseObject writeToFile:zipPath options:(NSDataWritingAtomic) error:nil];
        if ([fileManage fileExistsAtPath:unzipPath]) {
            NSError *err;
            [fileManage removeItemAtPath:unzipPath error:&err];
        }
        //解压缩
        [SSZipArchive unzipFileAtPath:zipPath toDestination:docmentPath];
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"版本更新成功,请重新进入!" preferredStyle:UIAlertControllerStyleAlert];
        
        __weak typeof(self) weakSelf = self;
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf leftBarButtonItemAction:nil];
        }];
        
        [alertVc addAction:confirmAction];
        
        [self presentViewController:alertVc animated:YES completion:nil];
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"版本更新失败,请重新尝试!" preferredStyle:UIAlertControllerStyleAlert];
        
        __weak typeof(self) weakSelf = self;
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf versionUpdate];
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf leftBarButtonItemAction:nil];
        }];
        
        [alertVc addAction:confirmAction];
        [alertVc addAction:cancleAction];
        
        [self presentViewController:alertVc animated:YES completion:nil];
    }];
}
- (BOOL)shouldAutorotate
{
    return YES;
}
@end

@implementation MainCommandDelegate

/* To override the methods, uncomment the line in the init function(s)
 in MainViewController.m
 */

#pragma mark CDVCommandDelegate implementation

- (id)getCommandInstance:(NSString*)className
{
    return [super getCommandInstance:className];
}

/*
 NOTE: this will only inspect execute calls coming explicitly from native plugins,
 not the commandQueue (from JavaScript). To see execute calls from JavaScript, see
 MainCommandQueue below
 */
//- (BOOL)execute:(CDVInvokedUrlCommand*)command
//{
//    return [super execute:command];
//}

- (NSString*)pathForResource:(NSString*)resourcepath;
{
    return [super pathForResource:resourcepath];
}

@end

@implementation MainCommandQueue

/* To override, uncomment the line in the init function(s)
 in MainViewController.m
 */
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}

@end
