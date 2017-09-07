//
//  LLFMainPageViewModel.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/31.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLFMainPageViewModel : NSObject
/**
 *  推送信息查询
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */

+ (void)checkMessageWithSuccessBlock:(void (^)(NSMutableArray *messageModelArr,NSString *noMessageCount))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
