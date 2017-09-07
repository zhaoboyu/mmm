//
//  LSCancelApplyPlugin.m
//  YDJR
//
//  Created by 李爽 on 2017/3/19.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LSCancelApplyPlugin.h"
#import "WPQCarGroupViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"

@implementation LSCancelApplyPlugin

-(void)cancelApply:(CDVInvokedUrlCommand *)command
{
	if (command.arguments.count > 0) {
		NSNumber * isRoot = command.arguments[0];
		if ([isRoot.description isEqualToString:@"0"]) {
			[[UIViewController currentViewController]dismissToViewSpecifiedController];
		}else{
			//[[UIViewController currentViewController] dismissViewControllerAnimated:YES completion:nil];
			
			AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
			MainViewController *mainVC = appDelegate.mainVC;
			[mainVC dismissViewControllerAnimated:YES completion:nil];
		}
        [Tool cleanCacheAndCookie];
	}
}

@end
