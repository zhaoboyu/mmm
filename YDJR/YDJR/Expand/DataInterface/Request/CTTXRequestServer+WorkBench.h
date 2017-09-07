//
//  CTTXRequestServer+WorkBench.h
//  YDJR
//
//  Created by 吕利峰 on 2017/5/16.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"
#import "LLFWorkBenchModel.h"
@interface CTTXRequestServer (WorkBench)
/**
 代办已办任务查询
 
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)checkWorkBenchWithSuccessBlock:(void (^)(NSMutableArray *workCompleteTaskModelArr,NSMutableArray *waitTaskModelArr,SysHeadModel *sysHeadModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
