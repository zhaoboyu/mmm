//
//  UIViewController+Utils.m
//  CTTX
//
//  Created by 吕利峰 on 16/7/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "UIViewController+Utils.h"
#import "YDJRNavigationViewController.h"
#import "WPQCarGroupViewController.h"
@implementation UIViewController (Utils)
+ (UIViewController *)findBestViewController:(UIViewController *)vc
{
    if (vc.presentedViewController) {
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[YDJRNavigationViewController class]]) {
        // Return top view
        YDJRNavigationViewController *svc = (YDJRNavigationViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}
+ (UIViewController *)currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

-(void)dismissToRootViewController
{
	UIViewController *vc = self;
	while (vc.presentingViewController) {
		vc = vc.presentingViewController;
	}
	[vc dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissToViewSpecifiedController
{
	UIViewController *vc = self;
	while (vc.presentingViewController) {
		//NSLog(@"%@",NSStringFromClass([vc.presentingViewController class]));
		if([vc.presentingViewController isKindOfClass:[YDJRNavigationViewController class]]){
			YDJRNavigationViewController *nav=(YDJRNavigationViewController*)vc.presentingViewController;
			UIViewController *v=nav.viewControllers[0];
			vc = vc.presentingViewController;
			//NSLog(@"%@",NSStringFromClass([v class]));
			if([v isKindOfClass:[WPQCarGroupViewController class]]){
				break;
			}
			
		}else{
			vc = vc.presentingViewController;
		}
		
	}
	[vc dismissViewControllerAnimated:YES completion:nil];
	
}

@end
