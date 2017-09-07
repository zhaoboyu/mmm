//
//  LSInfoInputCollectionViewCell.h
//  YDJR
//
//  Created by 李爽 on 2016/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  客户信息录入Cell

#import <UIKit/UIKit.h>
@class LSTextField;
@interface LSInfoInputCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)LSTextField *contentTextField;
@end
