//
//  WPQCarGroupTopViw.h
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBYSelectBrandView.h"
@protocol WPQCarGroupTopViwDelegate <NSObject>

- (void)dafenqiApplyScanButtonAction:(id)state;
- (void)brandSeletedReload;

@end
@interface WPQCarGroupTopViw : UIView{
    UIView *_lineView;

}
@property (nonatomic,weak)id<WPQCarGroupTopViwDelegate>delegate;
@property (nonatomic,strong) UIButton* allButton;//全部
@property (nonatomic,strong) UIButton* homebredButton;//国产
@property (nonatomic,strong) UIButton* importButton;//进口

@property (nonatomic,strong) UIButton *dafenqiApplyScanButton;//达分期申请扫一扫按钮

@property (nonatomic,strong) UIButton *selectBrandBtn;//品牌选择按钮

@property(nonatomic,strong) UIViewController *presentVC;
@property(nonatomic,strong)   ZBYSelectBrandView *brand;
/**
 scrollVie移动事件

 @param Scale scrollview移动到第几页
 */
-(void)moveToScrollviewBorderScale:(CGFloat)Scale;
@end
