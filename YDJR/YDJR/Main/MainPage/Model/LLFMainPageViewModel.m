//
//  LLFMainPageViewModel.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/31.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFMainPageViewModel.h"
#import "CTTXRequestServer+Login.h"
#import "MessageModel.h"
@implementation LLFMainPageViewModel
/**
 *  推送信息查询
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */

+ (void)checkMessageWithSuccessBlock:(void (^)(NSMutableArray *messageModelArr,NSString *noMessageCount))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    [[CTTXRequestServer shareInstance] checkMessageWithSuccessBlock:^(NSMutableArray *messageModelArr) {
        NSArray *tempArr = [Tool unarcheiverWithfileName:MessagePath];
        for (int i = 0; i < messageModelArr.count; i++) {
            MessageModel *model = messageModelArr[i];
            //判断是否未读
            NSString *isNewPreStr = [NSString stringWithFormat:@"id == '%@'",model.messageId];
            NSPredicate *isNewdicate = [NSPredicate predicateWithFormat:isNewPreStr];
            NSArray *isNewdicateArr = [tempArr filteredArrayUsingPredicate:isNewdicate];
            if (isNewdicateArr.count > 0) {
                MessageModel *messageModel = isNewdicateArr[0];
                if (messageModel.isRead) {
                    model.isRead = YES;
                }
            }
            messageModelArr[i] = model;
        }
        
    
        [Tool archiverWithObjectArr:messageModelArr fileName:MessagePath];
        NSString *messagecount = [NSString stringWithFormat:@"%ld",[self sumWithMessageArr:messageModelArr]];
        SuccessBlock(messageModelArr,messagecount);
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}
+ (NSInteger)sumWithMessageArr:(NSArray *)messageArr
{
    NSInteger num = 0;
    for (MessageModel *model in messageArr) {
        if (!model.isRead) {
            num+=1;
        }
    }
    return num;
}
@end
