//
//  SDCBoxViewManager.h
//  YDJR
//
//  Created by sundacheng on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDCBoxView;

@interface SDCBoxViewManager : NSObject

@property (nonatomic, copy) NSArray *infoArray;


/**
*  创建boxView
*
*  @param lineMaxNum 一行最大数量
*  @param totalNum   总数量
*  @param SViewWidth 父视图宽度
*
*  @return 视图
*/
- (UIView *)creatBoxeslineMaxNum:(NSUInteger)lineMaxNum
                 totalNum:(NSUInteger)totalNum
             andSViewWidth:(CGFloat)SViewWidth;

@property (nonatomic, strong) SDCBoxView *boxView;

@end
