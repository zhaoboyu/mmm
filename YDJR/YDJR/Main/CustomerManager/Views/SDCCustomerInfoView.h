//
//  SDCCustomerInfoView.h
//  YDJR
//
//  Created by sundacheng on 16/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDCCustomerContactModel;

@interface SDCCustomerInfoView : UIView

/**
 *  刷新数据
 *
 *  @param array 客户model数组
 */
- (void)reloadDataWithCustomerArray:(NSArray *)array  outsideflag:(int)flag;
@property (nonatomic, strong) SDCCustomerContactModel *customerContactModel;

@end
