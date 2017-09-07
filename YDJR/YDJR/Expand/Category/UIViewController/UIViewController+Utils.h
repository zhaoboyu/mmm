//
//  UIViewController+Utils.h
//  CTTX
//
//  Created by 吕利峰 on 16/7/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)
+ (UIViewController *)currentViewController;
#pragma mark 返回根视图控制器
/**
 返回到根视图控制器
 */
-(void)dismissToRootViewController;

-(void)dismissToViewSpecifiedController;
@end
