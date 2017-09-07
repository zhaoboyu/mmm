//
//  ZBYSelectBrandView.h
//  YDJR
//
//  Created by 赵博宇 on 2017/6/7.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol brandSelected <NSObject>

- (void)brandSelected;
- (void)removeBtnUser;
@end


@interface ZBYSelectBrandView : UIView
@property(nonatomic,weak)id<brandSelected>brandDelegate;

@end
