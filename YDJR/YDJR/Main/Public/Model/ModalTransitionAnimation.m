//
//  ModalTransitionAnimation.m
//  模态测试
//
//  Created by 吕利峰 on 16/6/1.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "ModalTransitionAnimation.h"
#define kWith [[UIScreen mainScreen]bounds].size.width
@implementation ModalTransitionAnimation
//动画持续时间，单位是秒
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
//动画效果
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    //通过键值UITransitionContextToViewControllerKey获取需要呈现的视图控制器toVC
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    
//    //得到toVC完全呈现后的frame
//    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
//    
//    
////    if ([toVC isKindOfClass:[ModalViewController class]]) {
//        //需要呈现的视图是模态视图，此时将模态视图的frame放到屏幕空间下方，这样才能实现从下方弹出的效果
//        toVC.view.frame = CGRectOffset(finalFrame, [UIScreen mainScreen].bounds.size.width, 0);
////    } else {
////        //需要呈现的视图是主视图，此时将主视图的frame放在屏幕空间上方，这样才能实现从上方放下的效果
////        toVC.view.frame = CGRectOffset(finalFrame, 0, -[UIScreen mainScreen].bounds.size.height);
////    }
//    
//    //切换在containerView中完成，需要将toVC.view加到containerView中
//    UIView *containerView = [transitionContext containerView];
//    [containerView addSubview:toVC.view];
//    
//    
//    //开始动画，这里使用了UIKit提供的弹簧效果动画，usingSpringWithDamping越接近1弹性效果越不明显，此API在IOS7之后才能使用
//    [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                          delay:0
//         usingSpringWithDamping:1
//          initialSpringVelocity:0
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         toVC.view.frame = finalFrame;
//                     } completion:^(BOOL finished) {
//                         //通知系统动画切换完成
//                         [transitionContext completeTransition:YES];
//                     }];
    
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    
    UIView * toView = toViewController.view;
    
    UIView * fromView = fromViewController.view;
    
    
    
    if (self.animationType == AnimationTypePresent) {
        
        
        
        //snapshot方法是很高效的截屏
        
        
        //得到toVC完全呈现后的frame
        CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
        //First放下面
        
//        UIView * snap = [fromView snapshotViewAfterScreenUpdates:YES];
        
//        [transitionContext.containerView addSubview:snap];
        [transitionContext.containerView addSubview:fromView];
        //Third放上面
        
//        UIView * snap2 = [toView snapshotViewAfterScreenUpdates:YES];
        
//        [transitionContext.containerView addSubview:snap2];
        [transitionContext.containerView addSubview:toView];
        
        
        
//        snap2.transform = CGAffineTransformMakeTranslation(-kWith, 0);
        toView.frame = CGRectOffset(finalFrame, [UIScreen mainScreen].bounds.size.width, 0);
        
        
        //进行动画
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
//            snap2.transform = CGAffineTransformIdentity;
            toView.frame = finalFrame;
            
        } completion:^(BOOL finished) {
            
            //删掉截图
            
//            [snap removeFromSuperview];
//            
//            [snap2 removeFromSuperview];
            
            //添加视图
            
            [[transitionContext containerView] addSubview:toView];
            
            //结束Transition
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
        
        
        
        
    } else {
        
        //得到toVC完全呈现后的frame
        CGRect finalFrame = [[UIScreen mainScreen] bounds];
        finalFrame.origin.x = kWith;
        //First 放下面
        
//        UIView * snap = [toView snapshotViewAfterScreenUpdates:YES];
        
        [transitionContext.containerView addSubview:toView];
        
        
        
        //Third 放上面
        
//        UIView * snap2 = [fromView snapshotViewAfterScreenUpdates:YES];
        
        [transitionContext.containerView addSubview:fromView];
        
        fromView.frame = [[UIScreen mainScreen] bounds];
        
        //进行动画
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            fromView.frame = finalFrame;
            
        } completion:^(BOOL finished) {
            
            //删掉截图
            
//            [snap removeFromSuperview];
//            
//            [snap2 removeFromSuperview];
            
            //添加视图
            
            [[transitionContext containerView] addSubview:toView];
            
            //结束Transition
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
        
    }
    
    
}

@end
