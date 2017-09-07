//
//  LSFinancialProgramCollectionViewCell.h
//  YDJR
//
//  Created by 李爽 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  金融方案Cell

#import <UIKit/UIKit.h>

@interface LSFinancialProgramCollectionViewCell : UICollectionViewCell
/**
 金融方案标题
 */
@property (nonatomic,strong)UILabel *financialProgramTitleLabel;
/**
 最优方案
 */
@property (nonatomic,strong)UIImageView *bestProgramImageView;
/**
 融资规模(元)
 */
@property (nonatomic,strong)UILabel *financialSizeLabel;
/**
 //贷款期限(月)
 */
@property (nonatomic,strong)UILabel *loanPeriodLabel;
/**
 首付比例
 */
@property (nonatomic,strong)UILabel *downpaymentsLabel;
/**
 月供金额(元)
 */
@property (nonatomic,strong)UILabel *monthlyMoneyLabel;
/**
 实际购车成本
 */
@property (nonatomic,strong)UILabel *costOfCarLabel;
/**
 选择按钮
 */
@property (nonatomic,strong)UIButton *chooseBtn;
/**
 删除按钮
 */
@property (nonatomic,strong)UIButton *deleteButton;
/**
 添加金融方案
 */
@property (nonatomic,strong)UIImageView *addFinancialProgramImgView;
/**
 编辑按钮
 */
@property (nonatomic,strong)UIButton *editBtn;
/**
 背景图
 */
@property (nonatomic,strong)UIImageView *pictuerImageView;

@end
