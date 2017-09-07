//
//  FinalApprovalView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/3/23.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLFFinalApprovalModel;
@interface FinalApprovalView : UIView

/**
 初始化

 @param frame frame
 @param finalApprovalModel 终审批复信息
 @return 对象本身
 */
- (instancetype)initWithFrame:(CGRect)frame finalApprovalModel:(LLFFinalApprovalModel *)finalApprovalModel from:(BOOL)benchOrNo;
@end
