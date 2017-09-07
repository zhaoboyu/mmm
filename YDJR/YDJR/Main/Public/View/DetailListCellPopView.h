//
//  DetailListCellPopView.h
//  YongDaFinance
//
//  Created by 吕利峰 on 16/8/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//
/*
 使用私立
 sender为目标view
 AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
 CGRect originInSuperview = [appDelegate.window convertRect:sender.bounds fromView:sender];
 DetailListCellPopView *detailListCellPopView = [[DetailListCellPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds] ListFrame:originInSuperview listArr:tempArr];
 detailListCellPopView.delegate = self;
 [detailListCellPopView showPopView];
 */
#import "PopView.h"

@protocol DetailListCellPopViewDelegate <NSObject>
@optional
- (void)sendMessageWithMessage:(NSString *)messge;

-(void)popViewHide;
@end

@interface DetailListCellPopView : PopView
@property (nonatomic,weak)id<DetailListCellPopViewDelegate>delegate;

@property (nonatomic, copy) void (^confirmBlock)(NSString *str);

- (instancetype)initWithFrame:(CGRect)frame ListFrame:(CGRect)listFrame listArr:(NSArray *)listArr isOtherTitle:(BOOL)isOtherTitle;

//出现
- (void)showPopView;
//取消
- (void)hidePopView;

@end
