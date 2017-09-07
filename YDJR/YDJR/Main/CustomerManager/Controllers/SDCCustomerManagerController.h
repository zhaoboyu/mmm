//
//  SDCCustomerManagerController.h
//  YDJR
//
//  Created by sundacheng on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCCustomerIntroController.h"
//@class SDCCustomerIntroController;
/**
 *  客户管理页面
 */
@interface SDCCustomerManagerController : YDJRBaseViewController

//客户id
@property (nonatomic, copy) NSString *customerId;

//数据源
@property (strong, nonatomic) NSMutableArray *dataSource;

//未选中时的view
@property (nonatomic, strong) UIView *noSelectShowView;

//通讯录
@property (nonatomic, strong) UITableView *addressListView;
@property (nonatomic, strong)SDCCustomerIntroController *rightVC;//右侧的视图控制器
/**
 *  添加客户简介控制器
 *
 *  @param count 数目
 */
- (void)addChildControllersWithCount:(NSInteger)count;

/**
 *  根据客户id选择控制器
 *
 *  @param customerId 客户id
 */
- (void)showChildVcWithCustomerId:(NSString *)customerId;

@end
