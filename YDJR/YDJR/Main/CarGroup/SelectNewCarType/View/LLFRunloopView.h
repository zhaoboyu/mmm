//
//  LLFRunloopView.h
//  YDJR
//
//  Created by 吕利峰 on 2016/12/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLFRunloopModel.h"

@protocol LLFRunloopViewDelegate <NSObject>

@optional

- (void)clickRunloopViewWithIndex:(NSInteger)index;

@end
@interface LLFRunloopView : UIView
@property (nonatomic,strong)LLFRunloopModel *dataModel;
@property(nonatomic,weak)id<LLFRunloopViewDelegate>delegate;
@end
