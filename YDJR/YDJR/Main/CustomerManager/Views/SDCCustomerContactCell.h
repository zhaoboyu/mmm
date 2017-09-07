//
//  SDCCustomerContactCell.h
//  YDJR
//
//  Created by sundacheng on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDCCustomerContactModel;

/**
 *  用户联系方式
 */
@interface SDCCustomerContactCell : UITableViewCell

@property (nonatomic, strong) UILabel *customName; //用户名

/**
 *  初始化
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView;

/**
 *  刷新数据
 *
 *  @param model 数据model
 */
- (void)reloadDataWithModel:(SDCCustomerContactModel *)model;

@end
