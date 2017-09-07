//
//  LSChangeFinancialProductPlugin.h
//  YDJR
//
//  Created by 李爽 on 2016/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
@class LSAddProgramDetailsView;
@interface LSChangeFinancialProductPlugin : CDVPlugin
/**
 *	@brief	更换金融方案
 *
 */
- (void)changeFinancialProduct:(CDVInvokedUrlCommand *)command;
@end
