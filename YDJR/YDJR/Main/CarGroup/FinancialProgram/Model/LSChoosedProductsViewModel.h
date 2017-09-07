//
//  LSChoosedProductsViewModel.h
//  YDJR
//
//  Created by 李爽 on 2016/11/1.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSChoosedProductsViewModel : NSObject
/**
 *  获取materialModelArr列表
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
+ (void)getMaterialModelArrWithDictitem:(NSString *)dictitem WithSuccessBlock:(void (^)(NSMutableArray *materialModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end

