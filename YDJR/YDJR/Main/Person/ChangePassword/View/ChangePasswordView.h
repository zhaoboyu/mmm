//
//  ChangePasswordView.h
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTTXRequestServer.h"
#import "CTTXRequestServer+Login.h"

@protocol passwordMessageCountReload <NSObject>

- (void)password;

@end

@interface ChangePasswordView : UIView<UITextFieldDelegate>
@property(nonatomic,weak)id<passwordMessageCountReload>messageDelegate;
@property(nonatomic,strong)UIViewController *VC;
@end

