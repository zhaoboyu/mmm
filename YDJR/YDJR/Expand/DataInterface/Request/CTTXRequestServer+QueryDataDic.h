//
//  CTTXRequestServer+QueryDataDic.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"

@interface CTTXRequestServer (QueryDataDic)
/**
 *  获取数据字典
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkListDicInfoWithSuccessBlock:(void (^)(NSDictionary *insuranceInfoModelDic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
