//
//  DafenqiApplyInfoView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/4/5.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLFDafenqiBusinessModel.h"
typedef void (^back)();
@interface DafenqiApplyInfoView : UIView

@property (nonatomic, strong) LLFDafenqiBusinessModel *dafenqiBusinessModel;
@property (nonatomic,copy)back back;
@end
