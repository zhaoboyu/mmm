//
//  SDCCustomerOrderIntstCell.h
//  YDJR
//
//  Created by sundacheng on 16/10/12.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDCCustomerIntrestModel;

/**
 *  用户订单意向
 */
@interface SDCCustomerOrderIntstCell : UITableViewCell

/**
 *  初始化
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView;

/**
 *  刷新数据
 *
 *  @param model 客户意向model
 */
- (void)reloadDataWithModel:(id)model;

@end
