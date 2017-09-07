//
//  LLFCarBuyTypeListTableViewCell.h
//  YDJR
//
//  Created by 吕利峰 on 2016/12/20.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLFCarBuyTypeListTableViewCell : UITableViewCell

/**
 销售名称
 */
@property (nonatomic,strong)UILabel *carBuyTypeNameLabel;

/**
 分割线
 */
@property (nonatomic,strong)UIImageView *lineImageView;
/**
 左分割线
 */
@property (nonatomic,strong)UIImageView *leftLineImageView;

/**
 设置选中字体颜色

 @param color 字体颜色
 */
- (void)labelTextColorWithColor:(NSString *)color;
@end
