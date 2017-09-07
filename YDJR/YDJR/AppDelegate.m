 //
//  AppDelegate.m
//  YDJR
//
//  Created by 吕利峰 on 16/9/18.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "AppDelegate.h"
#import "LSCarDetailsViewController.h"
#import "LLFLoginViewController.h"
#import "LLFMainPageViewController.h"
#import "CTTXRequestServer+checkCar.h"
#import "CTTXRequestServer+QueryDataDic.h"
#import "CTTXRequestServer+Login.h"
#import "MainViewController.h"
#import "CTTXRequestServer+SMS.h"
#import "CTTXRequestServer+CustomerManager.h"
#import "WPQCarGroupViewController.h"
#import "LLFSelectNewCarTypeViewController.h"
#import "UMMobClick/MobClick.h"
#import "NSString+cut.h"
#import "YDJRBarViewController.h"
//测试文件上传
#import "UploadFileModel.h"
#import "CTTXRequestServer+FileUpload.h"
#import "CTTXRequestServer+uploadContract.h"
#import "CTTXRequestServer+fileManger.h"
#import "UploadFileRequest.h"
//二维码扫描
#import "MessageModel.h"
#import "MessageCenterViewModel.h"
@interface AppDelegate ()<UIAlertViewDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //更改状态栏前景部分颜色
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //统一设置导航栏
    //隐藏导航栏下面的灰色线
    [[UINavigationBar appearance]setShadowImage:[[UIImage alloc]init]];
    //注册推送
    [self registerLocalNotification];
    //开始上传文件
    [DBManger sharedDMManger];
    //判断当前是否是登录状态
    UserDataModel *userModel = [UserDataModel sharedUserDataModel];
   
    if (userModel.isLogin) {
        NSDictionary *userDic = [Tool getUserDicKeyChainWithUserId:userModel.userName];
        [userModel setValuesForKeysWithDictionary:userDic];
        //隐形登录
        NSString *password = nil;
        if ([Tool getKeychainStringWithKey:Password] && [[Tool getKeychainStringWithKey:Password] length] > 0) {
            password = [Tool getKeychainStringWithKey:Password];
        }else{
            password = @"000000";
        }
        CTTXRequestServer *server = [CTTXRequestServer shareInstance];
        [server loginWithUsername:userModel.userName password:password SuccessBlock:^(UserDataModel *userDataModel,SysHeadModel *sysHeadModel) {
            if ([sysHeadModel.ReturnCode isEqualToString:@"00"]) {
                //跳转到首页
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:@"login"];
            }else{
                //隐性登录失败,重新登录
                UIAlertView *updataAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的账号登录失败,请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                updataAlert.tag = 105;
                [updataAlert show];
            }
            
            
        } failedBlock:^(NSError *error) {
            
            //隐性登录失败,重新登录
            UIAlertView *updataAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的账号登录失败,请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            updataAlert.tag = 105;
            [updataAlert show];
        }];
        //显示首页
        //跳转到首页
		
//        YDJRNavigationViewController *mainPageNC = [[YDJRNavigationViewController alloc]initWithRootViewController:carGroupVC];
//        mainPageNC.navigationBarHidden=YES;
//        
//        self.window.rootViewController = mainPageNC;
        YDJRBarViewController *YDJRbar = [[YDJRBarViewController alloc]init];
        self.window.rootViewController = YDJRbar;
        
    }else{
        LLFLoginViewController *loginVC = [[LLFLoginViewController alloc]init];
        self.window.rootViewController = loginVC;
    }
    [self.window makeKeyAndVisible];
    [self saveDicToLocal];
    //开启网络监测
    [self checkNetwork];
    //开启友盟统计
    [self jichengUMConfigInstance];
//    NSString *tempStr = @"1.00";
//    NSLog(@"%@",[tempStr cutZeroFromString]);
    //接受相册打开的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeRotate:) name:@"changeRotate" object:nil];
    //测试代码
    [self ceshi];
    
    return YES;
}
- (void)changeRotate:(NSNotification *)noti{
    if ([noti.object isEqualToString:@"0"]) {
//        _MyInterfaceOrientationMask = UIInterfaceOrientationMaskLandscapeRight;
        [UserDataModel sharedUserDataModel].flag = 1;
    }else{
//        _MyInterfaceOrientationMask = UIInterfaceOrientationMaskAll;
        [UserDataModel sharedUserDataModel].flag = 0;
    }
}
- (void)registerLocalNotification
{
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}
//测试方法
- (void)ceshi{
//    NSString  *imgPath = [[NSBundle mainBundle] pathForResource:@"10.jpg" ofType:nil];
//    [[CTTXRequestServer shareInstance] uploadFileHeadImageWithFilePath:imgPath SuccessBlock:^(BOOL result) {
//        
//    } failedBlock:^(NSError *error) {
//        
//    }];
//    [[CTTXRequestServer shareInstance] downloadFileWithPamart:nil SuccessBlock:^(UIImage *headImage) {
//        
//    } failedBlock:^(NSError *error) {
//        
//    }];
    
}

//友盟统计集成
- (void)jichengUMConfigInstance
{
    UMConfigInstance.appKey = @"58624053734be40623000d65";
    UMConfigInstance.channelId = @"App Store";
//    UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
}
//还存数据字典到本地
- (void)saveDicToLocal
{
    [[CTTXRequestServer shareInstance] checkListDicInfoWithSuccessBlock:^(NSDictionary *insuranceInfoModelDic) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *arry = [NSMutableArray array];
        if (insuranceInfoModelDic) {
            [arry addObject:insuranceInfoModelDic];
            [self versionUpdateDetectionWithDataDic:insuranceInfoModelDic];
            [Tool archiverWithObjectArr:arry fileName:DATALISTPATH];
            [defaults setObject:@"1" forKey:@"isCheckListDicInfo"];
        }else{
            [defaults setObject:@"0" forKey:@"isCheckListDicInfo"];
        }
        [defaults synchronize];
    } failedBlock:^(NSError *error) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"0" forKey:@"isCheckListDicInfo"];
        [defaults synchronize];
    }];
}
//版本更新的检测
- (void)versionUpdateDetectionWithDataDic:(NSDictionary *)dataDic
{
    NSArray *arr = [dataDic objectForKey:@"IDFS000325"];
    if (arr.count > 1) {
        NSDictionary *versionDic = arr[0];
        NSString *newVersion = [versionDic objectForKey:@"dictdesc"];
        NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSDictionary *isUpdataDic = arr[2];
        NSString *isUpdataStr = [isUpdataDic objectForKey:@"dictdesc"];
        if ([newVersion compare:localVersion options:NSNumericSearch] == NSOrderedDescending) {
            NSString *updataStr = [NSString stringWithFormat:@"请升级到最新版本(%@),以免影响您的使用体验",newVersion];
            if ([isUpdataStr isEqualToString:@"1"]) {
                UIAlertView *updataAlert = [[UIAlertView alloc]initWithTitle:@"版本升级" message:updataStr delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles: nil];
                updataAlert.tag = 101;
                [updataAlert show];
            }else{
                UIAlertView *updataAlert = [[UIAlertView alloc]initWithTitle:@"版本升级" message:updataStr delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"立即更新", nil];
                updataAlert.tag = 102;
                [updataAlert show];
            }
            
        }
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        NSArray *localArr = [Tool unarcheiverWithfileName:DATALISTPATH];
        NSDictionary *dataDic = localArr[0];
        NSArray *arr = [dataDic objectForKey:@"IDFS000325"];
        if (arr.count > 1) {
            NSDictionary *versionDic = arr[0];
            NSString *newVersion = [versionDic objectForKey:@"dictdesc"];
            NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            if ([newVersion compare:localVersion options:NSNumericSearch] == NSOrderedDescending) {
                NSDictionary *appDownloadUrlDic = arr[1];
                NSString *appDownloadUrl = [appDownloadUrlDic objectForKey:@"dictdesc"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appDownloadUrl]];
            }
        }
    }else if (alertView.tag == 102){
        if (buttonIndex == 1) {
            NSArray *localArr = [Tool unarcheiverWithfileName:DATALISTPATH];
            NSDictionary *dataDic = localArr[0];
            NSArray *arr = [dataDic objectForKey:@"IDFS000325"];
            if (arr.count > 1) {
                NSDictionary *versionDic = arr[0];
                NSString *newVersion = [versionDic objectForKey:@"dictdesc"];
                NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                if ([newVersion compare:localVersion options:NSNumericSearch] == NSOrderedDescending) {
                    NSDictionary *appDownloadUrlDic = arr[1];
                    NSString *appDownloadUrl = [appDownloadUrlDic objectForKey:@"dictdesc"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appDownloadUrl]];
                }
            }
        }
    }else if (alertView.tag == 105){
        //隐性登录失败,重新登录
        UserDataModel *userModel = [UserDataModel sharedUserDataModel];
        [userModel logOut];
        LLFLoginViewController *loginVC = [[LLFLoginViewController alloc]init];
        self.window.rootViewController = loginVC;
    }
    
}
#pragma mark 启动网络监测工具
- (void)checkNetwork
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        if (status != AFNetworkReachabilityStatusNotReachable) {
            [self queryDataListToLocal];
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/**
 加载数据字典到本地
 */
- (void)queryDataListToLocal
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"isCheckListDicInfo"] && [[defaults objectForKey:@"isCheckListDicInfo"] isEqualToString:@"0"]) {
        [self saveDicToLocal];
    }
}
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return [[UserDataModel sharedUserDataModel] interfaceOrientationMask];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //检测版本更新
//    NSArray *localArr = [Tool unarcheiverWithfileName:DATALISTPATH];
//    NSDictionary *dataDic = localArr[0];
//    [self versionUpdateDetectionWithDataDic:dataDic];
    [self saveDicToLocal];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 注册推送通知之后
//在此接收设备令牌
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
	//判断当前是否是登录状态
	UserDataModel *userModel = [UserDataModel sharedUserDataModel];
	
	if (userModel.isLogin) {
		NSDictionary *userDic = [Tool getUserDicKeyChainWithUserId:userModel.userName];
		[userModel setValuesForKeysWithDictionary:userDic];
		//隐形登录
		NSString *password = nil;
		if ([Tool getKeychainStringWithKey:Password] && [[Tool getKeychainStringWithKey:Password] length] > 0) {
			password = [Tool getKeychainStringWithKey:Password];
		}else{
			password = @"000000";
		}
		CTTXRequestServer *server = [CTTXRequestServer shareInstance];
		[server loginWithUsername:userModel.userName password:password SuccessBlock:^(UserDataModel *userDataModel,SysHeadModel *sysHeadModel) {
			if ([sysHeadModel.ReturnCode isEqualToString:@"00"]) {
				//跳转到首页
//				[[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:@"login"];
			}
			
			
		} failedBlock:^(NSError *error) {
			
			//
		}];
		
	}
    [Tool saveDeviceToken:deviceToken];
    NSLog(@"device token:%@",deviceToken);
}
#pragma mark 获取device token失败后
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError:%@",error.localizedDescription);
//    [self saveDeviceToken:nil];
}
#pragma mark 接收到推送通知之后
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"处于前台时:receiveRemoteNotification,userInfo is %@",userInfo);
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"处于后台时:receiveRemoteNotification,userInfo is %@",userInfo);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1007);
    NSString *messageId = [userInfo objectForKey:@"messageID"];
    if (messageId && messageId.length > 0) {
        [Tool saveMessageToLocalWithMessageId:messageId];
        NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        
        [alert show];
    }
    
    
}
+(AppDelegate*) sharedInstance{
    return ((AppDelegate*) [[UIApplication sharedApplication] delegate]);
}
@end
