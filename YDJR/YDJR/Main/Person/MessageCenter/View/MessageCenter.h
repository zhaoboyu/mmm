//
//  MessageCenter.h
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@protocol messageMessageCountReload <NSObject>

-(void)message;

@end

@interface MessageCenter : UIView
@property(nonatomic,assign)id<messageMessageCountReload>messageDelegate;
@end
