//
//  LLFCarGroupViewController.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPQButtonBox.h"
#import "SDCCustomerManagerController.h"
#import "LLFKnowledgeBaseViewController.h"
@interface LLFCarGroupViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView* myScrollView;
@property (nonatomic,strong) UIButton* allButton;
@property (nonatomic,strong) UIButton* homebredButton;
@property (nonatomic,strong) UIButton* importButton;
//@property (nonatomic,strong)  LLFCarGroupCollectionView* allCollectionView;

-(void)lineViewMove:(CGFloat)offX moveY:(CGFloat)offY buttonActionTag:(NSInteger)Tag;
@end
