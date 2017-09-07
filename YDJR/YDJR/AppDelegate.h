//
//  AppDelegate.h
//  YDJR
//
//  Created by 吕利峰 on 16/9/18.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSCarDetailsViewController;
@class MainViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)MainViewController *mainVC;
+(AppDelegate*) sharedInstance;
//还存数据字典到本地
- (void)saveDicToLocal;
@end

