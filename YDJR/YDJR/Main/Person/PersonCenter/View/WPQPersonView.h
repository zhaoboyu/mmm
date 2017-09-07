//
//  WPQPersonView.h
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/24.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCenter.h"
@interface WPQPersonView : UIView{
    UIView* myBgview;
}
@property (nonatomic,strong) UILabel            *messageCountLabel;
@property (nonatomic,strong) UIImageView        *point;
@property (nonatomic,strong) HGBPromgressHud    *phud;
-(void)WPQPersonViewWillAppear;
@end
