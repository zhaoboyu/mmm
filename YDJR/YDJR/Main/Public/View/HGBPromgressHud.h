//
//  HGBPromgressHud.h
//  CTTX
//
//  Created by huangguangbao on 16/6/23.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
@interface HGBPromgressHud : NSObject
@property(strong,nonatomic)NSString *promptStr;
@property(strong,nonatomic)MBProgressHUD *hud;
@property(strong,nonatomic)MBProgressHUD *promptHud;
@property(assign,nonatomic)BOOL fullScreen;

/**
 *  保存
 *
 *  @param view 显示界面
 */
-(void)showHUDSaveAddedTo:(UIView *)view;
/**
 * //显示结果
 *
 *  @param view 显示界面
 */
-(void)showHUDResultAddedTo:(UIView *)view;
/**
 *  隐藏保存
 */
-(void)hideSave;//隐藏保存
/**
 *  隐藏结果
 */
- (void)hideResultAfterDelay:(NSTimeInterval)delay;
@end
