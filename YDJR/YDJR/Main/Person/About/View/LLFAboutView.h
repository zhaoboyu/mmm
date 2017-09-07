//
//  LLFAboutView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/1/10.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol aboutMessageCountReload <NSObject>

- (void)about;

@end

@interface LLFAboutView : UIView
@property(nonatomic,weak)id<aboutMessageCountReload>messageDelegate;
@end
