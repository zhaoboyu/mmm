//
//  LSUniversalAlertView.h
//  YDJR
//
//  Created by 李爽 on 2016/11/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSUniversalAlertView : UIView
/**
 底部白色背景图片
 */
@property (nonatomic,strong)UIView *backGroundView;
/**
 关闭按钮
 */
@property (nonatomic,strong)UIButton *closeButton;
/**
 标题label
 */
@property (nonatomic,strong)UILabel *titleLabel;
/**
 右边按钮
 */
@property (nonatomic,strong)UIButton *rightButton;
/**
 分割线
 */
@property (nonatomic,strong)UIView *cuttingLine;
@end
