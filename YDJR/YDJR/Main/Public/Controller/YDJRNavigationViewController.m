//
//  YDJRNavigationViewController.m
//  YDJR
//
//  Created by 吕利峰 on 16/9/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "YDJRNavigationViewController.h"
#import "MainViewController.h"
@interface YDJRNavigationViewController ()<UIGestureRecognizerDelegate>
@property(strong,nonatomic)UIPercentDrivenInteractiveTransition *interactiveTransition;
@end

@implementation YDJRNavigationViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UserDataModel sharedUserDataModel].flag = 1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationBarHidden=YES;
//    self.view.userInteractionEnabled = YES;
//    UIScreenEdgePanGestureRecognizer *pan=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(customControllerEdgePopHandle:)];
//    pan.delegate=self;
//    pan.edges=UIRectEdgeLeft;
//    [self.view addGestureRecognizer:pan];
    
    
//    self.navigationBar.barTintColor=[UIColor redColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 侧滑
- (void)customControllerEdgePopHandle:(UIPanGestureRecognizer *)recognizer
{
//    UIViewController *controller=self.topViewController;
//    if(recognizer.state == UIGestureRecognizerStateEnded)
//    {
//        UIViewController *rootVC=controller.navigationController.childViewControllers[0];
//        if(controller==rootVC){
//            [controller dismissViewControllerAnimated:YES completion:nil];
//        }else if ([controller isMemberOfClass:[HGBSucessBundleCardTableViewController class]]){
//            [controller dismissViewControllerAnimated:YES completion:nil];
//        }else if ([controller isMemberOfClass:[HGBCardViewController class]]){
//            [controller dismissViewControllerAnimated:YES completion:nil];
//        }else if ([controller isMemberOfClass:[HGBFeedBackTableViewController class]]){
//            [controller dismissViewControllerAnimated:YES completion:nil];
//        }else{
//            
//            [controller.navigationController popViewControllerAnimated:YES];
//            
//            
//        }
//    }
}
#pragma mark delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    BOOL result = NO;
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        result = YES;
    }
    
    return result;
}
#pragma mark - 旋转横屏控制
//- (BOOL)shouldAutorotate
//{
//    if ([self.visibleViewController isKindOfClass:[MainViewController class]]) {
//        MainViewController *mm = (MainViewController *)self.visibleViewController;
//        if (mm.isHaveTop) {
//            return [self.visibleViewController shouldAutorotate];
//        }
//    }
//    return NO; // RotateAblePushController自动旋转交给改控制器自己控制，其他控制器则不支撑自动旋转
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    if ([self.visibleViewController isKindOfClass:[MainViewController class]]) {
//        return UIInterfaceOrientationMaskPortrait |UIInterfaceOrientationMaskPortraitUpsideDown;
//    }else {
//        return UIInterfaceOrientationMaskLandscape; // RotateAblePushController所支持旋转交给改控制器自己处理，其他控制器则只支持竖屏3
//        
//        
//    }
//}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    NSLog(@"%s",__func__);
//    return  UIInterfaceOrientationLandscapeLeft;
//}

#pragma mark 控制状态栏前景色
//不要调用我自己(就是UINavigationController)的preferredStatusBarStyle方法，而是去调用navigationController.topViewController的preferredStatusBarStyle方法，这样写的话，就能保证当前显示的UIViewController的preferredStatusBarStyle方法能影响statusBar的前景部分

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}
@end
