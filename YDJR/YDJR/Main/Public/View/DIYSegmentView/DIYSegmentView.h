//
//  DIYSegmentView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/13.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DIYSegmentViewDelegate <NSObject>

@optional
- (void)passDIYSegmentViewWithIndex:(NSInteger)index;

@end

@interface DIYSegmentView : UIView
@property (nonatomic,weak)id<DIYSegmentViewDelegate>delegate;
@property (nonatomic,assign)NSInteger currentIndex;
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

/**
 更新标题

 @param items 要更新的标题数组
 */
- (void)updataWithItems:(NSArray *)items;
@end
