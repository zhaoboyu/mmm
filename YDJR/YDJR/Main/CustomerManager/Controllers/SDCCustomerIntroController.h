//
//  SDCCustomerIntroController.h
//  YDJR
//
//  Created by sundacheng on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDCCustomerContactModel;

/**
 *  客户简介
 */
@interface SDCCustomerIntroController : UIViewController

/**
 *  是否选中
 */
@property (nonatomic, assign) BOOL isSelected;

/**
 *  客户联系方式model
 */
@property (nonatomic, strong) SDCCustomerContactModel *customerContactModel;

@property (nonatomic,assign) NSInteger indexForRow;
@end
