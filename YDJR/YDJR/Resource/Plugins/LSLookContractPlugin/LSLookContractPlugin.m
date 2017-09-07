//
//  LSLookContractPlugin.m
//  YDJR
//
//  Created by 李爽 on 2017/3/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LSLookContractPlugin.h"
#import "AppDelegate.h"
#import "MainViewController.h"

@implementation LSLookContractPlugin

-(void)lookContract:(CDVInvokedUrlCommand *)command
{
	if (command.arguments.count >= 1) {
		NSString *firstContract = command.arguments[0];
		
		MainViewController *applyMainVC = [[MainViewController alloc]init];
        
		applyMainVC.startPage = [Tool getWWWPackAddressWithIndexName:firstContract];
		applyMainVC.isContractTop = YES;
		UINavigationController *applyMianNC = [[UINavigationController alloc]initWithRootViewController:applyMainVC];
		AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		MainViewController *mainVC = appDelegate.mainVC;
		[mainVC presentViewController:applyMianNC animated:YES completion:nil];
	}
}

@end
