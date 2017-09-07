//
//  LSBankCardInfoTableViewCell.h
//  YDJR
//
//  Created by 李爽 on 2017/4/6.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSBankCardInfoTableViewCell : UITableViewCell

@property (nonatomic,strong)NSArray *daFenQiApplyInfoTitleArr;
@property (nonatomic,strong)NSArray *daFenQiApplyInfContentArr;

@property (nonatomic,strong)NSMutableArray *controlArray;

@property (nonatomic,strong)UILabel *L_TitleLable;
@property (nonatomic,strong)UILabel *L_subTitleLable;
@property (nonatomic,strong)UILabel *L_ContentLable;

@property (nonatomic,strong)UIView *bottomLineView;

@end
