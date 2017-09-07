//
//  LLFInsuranceInfoCollectionViewCell.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLFInsuranceInfoCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *bgItemImageView;
@property (nonatomic,strong)UILabel *insuranceTitleLabel;
@property (nonatomic,strong)UILabel *insuranceContentLabel;
@property (nonatomic,assign)BOOL isSelect;
@end
