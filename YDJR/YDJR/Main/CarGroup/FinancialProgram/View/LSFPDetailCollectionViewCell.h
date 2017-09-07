//
//  LSFPDetailCollectionViewCell.h
//  YDJR
//
//  Created by 李爽 on 2016/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  添加方案详情Cell

#import <UIKit/UIKit.h>
@class LSTextField;
@interface LSFPDetailCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UILabel *conditionTilteLabel;//条件标题
@property (nonatomic,strong)LSTextField *conditionTextField;//条件
/**
 条件button
 */
@property (nonatomic,strong)UIButton *conditionButton;
@property (nonatomic,strong)UILabel *moneyTitleLabel;
@property (nonatomic,strong)UILabel *moneyLabel;
@end
