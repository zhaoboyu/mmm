//
//  HGBPromgressHud.m
//  CTTX
//
//  Created by huangguangbao on 16/6/23.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "HGBPromgressHud.h"

@interface HGBPromgressHud()
@property(strong,nonatomic)UIView *backView;
@end
@implementation HGBPromgressHud
static MBProgressHUD *hud2=nil;
static MBProgressHUD *promptHud2=nil;
static UIView *backView2=nil;
/**
 *  保存
 *
 *  @param view 显示界面
 */
-(void)showHUDSaveAddedTo:(UIView *)view
{
    if([hud2 superview]){
        [hud2 removeFromSuperview];
    }
    if([promptHud2 superview]){
        [promptHud2 removeFromSuperview];
    }
    if([backView2 superview]){
        [backView2 removeFromSuperview];
    }
    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    self.backView.backgroundColor=[UIColor clearColor];
    backView2=self.backView;
    [view addSubview:self.backView];
    self.hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud2=self.hud;
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
}
/**
 *  隐藏保存
 */
-(void)hideSave
{
    [self.backView removeFromSuperview];
    [self.hud hide:YES];
}
/**
 * //显示结果
 *
 *  @param view 显示界面
 */
-(void)showHUDResultAddedTo:(UIView *)view{
    if([hud2 superview]){
        [hud2 removeFromSuperview];
    }
    if([promptHud2 superview]){
        [promptHud2 removeFromSuperview];
    }
    if([backView2 superview]){
        [backView2 removeFromSuperview];
    }
    self.promptHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.promptHud.mode = MBProgressHUDModeText;
    self.promptHud.labelText = @"提示";
    promptHud2=self.promptHud;
    self.promptHud.detailsLabelText=self.promptStr;
    [self hideResultAfterDelay:2];
}
/**
 *  隐藏结果
 */
-(void)hideResultAfterDelay:(NSTimeInterval)delay
{
    //[self.backView removeFromSuperview];
    [self.promptHud hide:YES afterDelay:delay];
}
@end
