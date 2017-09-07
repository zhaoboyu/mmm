//
//  LLFLoginViewController.m
//  YDJR
//
//  Created by 吕利峰 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFLoginViewController.h"
#import "LLFLoginView.h"
#import "CTTXRequestServer+Login.h"
#import "LLFMainPageViewController.h"
#import "YDJRBarViewController.h"
#import "AppDelegate.h"
@interface LLFLoginViewController ()
@property (nonatomic,strong)LLFLoginView *loginView;
@property (nonatomic,strong)HGBPromgressHud *phud;
@end

@implementation LLFLoginViewController
- (void)loadView
{
    [super loadView];
    self.loginView = [[LLFLoginView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.view = self.loginView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
	[self addAction];
    NSString *userName = [Tool getKeychainStringWithKey:UserName];
    NSString *password = [ Tool getKeychainStringWithKey:Password];
    if (userName && userName.length > 0) {
        self.loginView.userNameTextField.text = userName;
    }
    
    if (password && password.length > 0) {
        self.loginView.passwordTextField.text = password;
    }

    // Do any additional setup after loading the view.
}
#pragma mark 为控件添加点击事件
- (void)addAction
{
    [self.loginView.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
#pragma mark 登录按钮响应事件
- (void)loginButtonAction:(UIButton *)sender
{
    [self.loginView.userNameTextField resignFirstResponder];
    [self.loginView.passwordTextField resignFirstResponder];
    
    if (self.loginView.userNameTextField.text.length > 0 && self.loginView.passwordTextField.text.length > 0) {
        [self.phud showHUDSaveAddedTo:self.view];
        CTTXRequestServer *server = [CTTXRequestServer shareInstance];
        [server loginWithUsername:self.loginView.userNameTextField.text password:self.loginView.passwordTextField.text SuccessBlock:^(UserDataModel *userDataModel,SysHeadModel *sysHeadModel) {
            [self.phud hideSave];
            
            if ([sysHeadModel.ReturnCode isEqualToString:@"00"]) {
                //登录成功后保存用户名和密码
                [Tool saveKeyChainForKeyWithKey:UserName value:self.loginView.userNameTextField.text];
                [Tool saveKeyChainForKeyWithKey:Password value:self.loginView.passwordTextField.text];
                //跳转到首页
//                WPQCarGroupViewController *carGroupVC = [[WPQCarGroupViewController alloc]init];
//                YDJRNavigationViewController *mainPageNC = [[YDJRNavigationViewController alloc]initWithRootViewController:carGroupVC];
//                 mainPageNC.navigationBarHidden=YES;
//                [self presentViewController:mainPageNC animated:YES
//                                 completion:nil];
                
                YDJRBarViewController *YDJRbar = [[YDJRBarViewController alloc]init];
                [AppDelegate sharedInstance].window.rootViewController = YDJRbar;
                [[AppDelegate sharedInstance] saveDicToLocal];
                //汽车馆数据
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"carSeriesJkhgc"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
            }else{
                self.phud.promptStr = sysHeadModel.ReturnMessage;
                [self.phud showHUDResultAddedTo:self.view];
            }
        } failedBlock:^(NSError *error) {
            [self.phud hideSave];
            self.phud.promptStr = @"网络状况不好...请稍后重试!";
            [self.phud showHUDResultAddedTo:self.view];

        }];

    }else{
        self.phud.promptStr = @"请输入用户名或密码!";
        [self.phud showHUDResultAddedTo:self.view];
    }
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}


#pragma mark - 旋转横屏控制
//- (BOOL)shouldAutorotate
//{
//    return NO; // RotateAblePushController自动旋转交给改控制器自己控制，其他控制器则不支撑自动旋转
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape; // RotateAblePushController所支持旋转交给改控制器自己处理，其他控制器则只支持竖屏3
//
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    NSLog(@"%s",__func__);
//    return  UIInterfaceOrientationLandscapeLeft;
//}


//支持旋转

-(BOOL)shouldAutorotate{
	
	return YES;
	
}

//支持的方向

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	
	return UIInterfaceOrientationMaskAllButUpsideDown;
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
