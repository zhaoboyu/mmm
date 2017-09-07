//
//  ZBYPersonalDetailsView.h
//  YDJR
//
//  Created by 赵博宇 on 2017/5/8.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol messageCountReload <NSObject>

- (void)messageCountReload;

@end

@interface ZBYPersonalDetailsView : UIView
@property(nonatomic,weak)id<messageCountReload>messageDelegate;
@property(nonatomic,strong)UIViewController *VC;
@end
