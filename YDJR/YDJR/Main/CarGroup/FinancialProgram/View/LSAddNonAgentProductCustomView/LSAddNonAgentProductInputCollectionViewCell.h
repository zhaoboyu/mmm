//
//  LSAddNonAgentProductInputCollectionViewCell.h
//  YDJR
//
//  Created by 李爽 on 2016/12/21.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  添加金融方案第二个界面CollectionViewCell

#import <UIKit/UIKit.h>
@class LSTextField;

@interface LSAddNonAgentProductInputCollectionViewCell : UICollectionViewCell
/**
 标题
 */
@property (nonatomic,strong)UILabel *L_titleLabel;
/**
 内容
 */
@property (nonatomic,strong)UITextField *L_contentTextField;
/**
 选框按钮
 */
@property (nonatomic,strong)UIButton *selectBoxButton;
/**
 期数按钮
 */
@property (nonatomic,strong)UIButton *loanYearButton;
@end
