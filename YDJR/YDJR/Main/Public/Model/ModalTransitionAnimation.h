//
//  ModalTransitionAnimation.h
//  模态测试
//
//  Created by 吕利峰 on 16/6/1.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//
typedef enum {
    
    AnimationTypePresent,
    
    AnimationTypeDismiss
    
} AnimationType;
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ModalTransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) AnimationType animationType;
@end
