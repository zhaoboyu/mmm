//
//  WPQCarGroupViewController.h
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/20.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPQButtonBox.h"
#import "SDCCustomerManagerController.h"
#import "LLFKnowledgeBaseViewController.h"
#import "RevisePassworderPopView.h"
#import "LLFLoginViewController.h"
typedef enum{
    allButtonTag,
    homebredButtonTag,
    importButtonTag,
    scrollViewDidScrollTag
}buttonFlag;
@interface WPQCarGroupViewController : YDJRBaseViewController<UIScrollViewDelegate,RevisePassworderPopViewDelegate>{
    
    
}
@property (nonatomic,strong) UIScrollView* myScrollView;
@property (nonatomic,strong) UIButton* allButton;
@property (nonatomic,strong) UIButton* homebredButton;
@property (nonatomic,strong) UIButton* importButton;

-(void)lineViewMove:(CGFloat)offX moveY:(CGFloat)offY buttonActionTag:(NSInteger)Tag;
-(void)backAction;
//获取消息
- (void)loadMessageData;
@end
