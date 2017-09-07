//
//  ZBYPersonViewController.h
//  YDJR
//
//  Created by 赵博宇 on 2017/5/4.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZBYPersonViewController :YDJRBaseViewController
- (void)loadNewMessage;
/**
 消息数量
 */
@property (nonatomic,copy)NSString *messageCount;
@end
