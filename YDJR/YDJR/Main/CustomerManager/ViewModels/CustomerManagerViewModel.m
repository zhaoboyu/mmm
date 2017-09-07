//
//  CustomerManagerViewModel.m
//  YDJR
//
//  Created by sundacheng on 16/10/31.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CustomerManagerViewModel.h"

@implementation CustomerManagerViewModel

+ (NSString *)getDfqStringId {
    NSString *dfqId;
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    if (tempArr.count > 0) {
        NSDictionary *dic = tempArr[0];
        NSArray *dataArr = [dic objectForKey:@"IDFS000309"];
        
        NSDictionary *dict = dataArr[0];
        dfqId = dict[@"dictvalue"];
    }
    return dfqId;
}

@end
