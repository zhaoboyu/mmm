//
//  CTTXRequestServer.h
//  CTTX
//
//  Created by 吕利峰 on 16/5/4.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Encryption.h"
#define NetWorkFailHUD @"网络状况不好,请稍候重试!"
@interface CTTXRequestServer : NSObject
@property (nonatomic,assign)BOOL isCache;
+ (instancetype)shareInstance;
/**
 *  网络判断
 *  @param statu 网络结果
 */
- (void)AFNetworkStatu:(void (^)(AFNetworkReachabilityStatus statu))statu;
@end
