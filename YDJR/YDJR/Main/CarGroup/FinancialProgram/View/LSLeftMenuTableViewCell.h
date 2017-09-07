//
//  LSLeftMenuTableViewCell.h
//  YDJR
//
//  Created by 李爽 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  对比金融方案Master控制器Cell

#import <UIKit/UIKit.h>

@interface LSLeftMenuTableViewCell : UITableViewCell
@property (nonatomic,strong)UIView *bgView;//背景
@property (nonatomic,strong)UILabel *programTitleLabel;//标题
@property (nonatomic,strong)UILabel *costOfCarLabel;//实际购车成本 标题
@property (nonatomic,strong)UILabel *costAmountLabel;//购车成本
@end
