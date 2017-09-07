//
//  MessageView.h
//  YDJR
//
//  Created by wanpeiqiang on 2016/10/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageView : UIView{
    UIView* bgview;
    UIScrollView* scrollView;
}
@property(nonatomic) BOOL Important;
@property(nonatomic,copy) NSString* contentStr;
@end
