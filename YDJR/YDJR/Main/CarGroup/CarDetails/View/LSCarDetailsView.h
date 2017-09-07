//
//  LSCarDetailsView.h
//  YDJR
//
//  Created by 李爽 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSCarDetailsViewController;

@protocol LSCarDetailsViewDelegate <NSObject>
- (void)addViewControllerWithIndex:(NSInteger)index;
@end

@interface LSCarDetailsView : UIView<UIScrollViewDelegate>
@property(strong,nonatomic)LSCarDetailsViewController *parent;
@property (nonatomic,strong)UIScrollView *BackgroundScrollView;
@property (nonatomic,strong)UIImageView *topView;
@property (nonatomic,strong)NSMutableArray *titleButtonArray;
@property (nonatomic,strong)NSMutableArray *lineViewArray;
@property (nonatomic,weak)id<LSCarDetailsViewDelegate>delegate;
@property (nonatomic,strong)UIView *UpView;
@end
