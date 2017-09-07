//
//  MessageCenterViewModel.m
//  YDJR
//
//  Created by 吕利峰 on 2017/3/10.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "MessageCenterViewModel.h"
#import "MessageModel.h"
@implementation MessageCenterViewModel
/**
 不存在的话插入,存在的话更新
 */
+ (BOOL)updataMessageModelWithMessageModel:(MessageModel *)messageModel
{
    //查询条件
    NSDictionary *conditions = [NSDictionary dictionaryWithObject:messageModel.messageId forKey:@"messageId"];
    //插入或更新对象
    NSMutableDictionary *object = [NSMutableDictionary dictionary];
    [object setObject:messageModel.messageId forKey:@"messageId"];
    [object setObject:messageModel.title forKey:@"title"];
    [object setObject:messageModel.message forKey:@"message"];
    [object setObject:messageModel.receiveTime forKey:@"receiveTime"];
    [object setObject:messageModel.userName forKey:@"userName"];
    if (messageModel.productType.length > 0) {
        [object setObject:messageModel.productType forKey:@"productType"];
    }else{
        [object setObject:@" " forKey:@"productType"];
    }
    
    if (messageModel.jumpName) {
        [object setObject:messageModel.jumpName forKey:@"jumpName"];
    }else{
        [object setObject:@" " forKey:@"jumpName"];
    }
    if (messageModel.businessID) {
        [object setObject:messageModel.businessID forKey:@"businessID"];
    }else{
        [object setObject:@" " forKey:@"businessID"];
    }
    
    if (messageModel.jumpType) {
        [object setObject:messageModel.jumpType forKey:@"jumpType"];
    }else{
        [object setObject:@" " forKey:@"jumpType"];
    }
    if (messageModel.customerID) {
        [object setObject:messageModel.customerID forKey:@"customerID"];
    }else{
        [object setObject:@" " forKey:@"customerID"];
    }
    
    //消息类型转换
    if (messageModel.messageType == MESSAGETYPE_SYSTEM) {
        [object setObject:@"0"forKey:@"messageType"];
    }else if (messageModel.messageType == MESSAGETYPE_APPLICATION){
        [object setObject:@"1"forKey:@"messageType"];
    }else if (messageModel.messageType == MESSAGETYPE_BUSINESS){
        [object setObject:@"2"forKey:@"messageType"];
    }
    //消息是否未读转换
    if (messageModel.isRead) {
        [object setObject:@"1" forKey:@"isRead"];
    }else{
        [object setObject:@"2" forKey:@"isRead"];
    }
    //是否已经操作完成
    if (messageModel.isHandle) {
        [object setObject:@"1" forKey:@"isHandle"];
    }else{
        [object setObject:@"0" forKey:@"isHandle"];
    }
    //影像列表
    if (messageModel.imagelist.count > 0) {
        NSDictionary *messageDic = [messageModel yy_modelToJSONObject];
        NSArray *imageList = [messageDic objectForKey:@"imagelist"];
        NSString *imageListStr = [Tool JSONArrToString:imageList];
        [object setObject:imageListStr forKey:@"imagelist"];
    }else{
        [object setObject:@" " forKey:@"imagelist"];
    }
    
    return [[DBManger sharedDMManger] queryTable:messageModelInfo ifExistsWithConditions:conditions withNewObject:object];
    
}

/**
 根据消息分类获取消息数组
 */
+ (NSArray *)queryMessageModelArrWithMessageType:(MESSAGETYPE)messageType
{
    //查询不同类型的消息数组
    //查询条件
    NSMutableDictionary *conditions = [NSMutableDictionary dictionary];
    if (messageType == MESSAGETYPE_SYSTEM) {
        [conditions setObject:@"0" forKey:@"messageType"];
    }else if (messageType == MESSAGETYPE_APPLICATION){
        [conditions setObject:@"1" forKey:@"messageType"];
    }else if (messageType == MESSAGETYPE_BUSINESS){
        [conditions setObject:@"2" forKey:@"messageType"];
    }
    [conditions setObject:[[UserDataModel sharedUserDataModel] userName] forKey:@"userName"];
    NSArray *resultArr = [[DBManger sharedDMManger] queryTable:messageModelInfo queryByConditions:conditions sortByKey:@"messageType" sortType:YES];
    NSMutableArray *messageModelArr = [NSMutableArray array];
    for (NSDictionary *messageDic in resultArr) {
        NSMutableDictionary *messageMDic = [[NSMutableDictionary dictionaryWithDictionary:messageDic] mutableCopy];
        NSString *imageListStr = [messageDic objectForKey:@"imagelist"];
        if (imageListStr && imageListStr.length > 0) {
            NSArray *imageList = [Tool arrayWithJsonString:imageListStr];
            if (imageList && imageList.count > 0) {
                [messageMDic setObject:imageList forKey:@"imagelist"];
            }else{
                [messageMDic setObject:@" " forKey:@"imagelist"];
            }
            
        }
        
        MessageModel *messageModel = [MessageModel yy_modelWithDictionary:messageMDic];
        [messageModelArr addObject:messageModel];
    }
    return messageModelArr;
}


/**
 查询各类消息未读数量
 
 @return 返回各类消息未读数量
 */
+ (NSArray *)queryMessageTypesNum
{
    //查询不同类型的消息数组
    //查询条件
    NSMutableDictionary *conditions1 = [NSMutableDictionary dictionary];
    [conditions1 setObject:@"0" forKey:@"messageType"];
    [conditions1 setObject:@"2" forKey:@"isRead"];
    [conditions1 setObject:[[UserDataModel sharedUserDataModel] userName] forKey:@"userName"];
    NSArray *resultArr1 = [[DBManger sharedDMManger] queryTable:messageModelInfo queryByConditions:conditions1 sortByKey:@"messageType" sortType:YES];
    
    NSMutableDictionary *conditions2 = [NSMutableDictionary dictionary];
    [conditions2 setObject:@"1" forKey:@"messageType"];
    [conditions2 setObject:@"2" forKey:@"isRead"];
    [conditions2 setObject:[[UserDataModel sharedUserDataModel] userName] forKey:@"userName"];
    NSArray *resultArr2 = [[DBManger sharedDMManger] queryTable:messageModelInfo queryByConditions:conditions2 sortByKey:@"messageType" sortType:YES];
    
    NSMutableDictionary *conditions3 = [NSMutableDictionary dictionary];
    [conditions3 setObject:@"2" forKey:@"messageType"];
    [conditions3 setObject:@"2" forKey:@"isRead"];
    [conditions3 setObject:[[UserDataModel sharedUserDataModel] userName] forKey:@"userName"];
    NSArray *resultArr3 = [[DBManger sharedDMManger] queryTable:messageModelInfo queryByConditions:conditions3 sortByKey:@"messageType" sortType:YES];
    
    NSMutableArray *messageTypesNumArr = [NSMutableArray array];
    if (resultArr1) {
        [messageTypesNumArr addObject:[NSString stringWithFormat:@"%ld",resultArr1.count]];
    }else{
        [messageTypesNumArr addObject:@"0"];
    }
    
    if (resultArr2) {
        [messageTypesNumArr addObject:[NSString stringWithFormat:@"%ld",resultArr2.count]];
    }else{
        [messageTypesNumArr addObject:@"0"];
    }
    
    if (resultArr3) {
        [messageTypesNumArr addObject:[NSString stringWithFormat:@"%ld",resultArr3.count]];
    }else{
        [messageTypesNumArr addObject:@"0"];
    }
    [messageTypesNumArr addObject:[NSString stringWithFormat:@"%ld",resultArr1.count + resultArr2.count +resultArr3.count]];
    return messageTypesNumArr;
}

/**
 根据条件查询消息
 
 @param businessID 订单号
 @param jumpType 跳转类型
 @return 消息model
 */
+ (MessageModel *)queryMessageModelWithBusinessID:(NSString *)businessID jumpType:(NSString *)jumpType
{
    NSMutableDictionary *conditions3 = [NSMutableDictionary dictionary];
    [conditions3 setObject:jumpType forKey:@"jumpType"];
    [conditions3 setObject:businessID forKey:@"businessID"];
    [conditions3 setObject:@"0" forKey:@"isHandle"];
    NSArray *resultArr = [[DBManger sharedDMManger] queryTable:messageModelInfo queryByConditions:conditions3 sortByKey:@"receiveTime" sortType:YES];
    if (resultArr.count > 0) {
        NSDictionary *messageDic = resultArr[0];
        MessageModel *messageModel = [MessageModel yy_modelWithJSON:messageDic];
        return messageModel;
    }else{
        return nil;
    }
    
}
/**
 根据messageID查询消息
 
 @param messageId 消息id
 @return 消息model
 */
+ (MessageModel *)queryMessageModelWithMessageId:(NSString *)messageId
{
    NSMutableDictionary *conditions3 = [NSMutableDictionary dictionary];
    [conditions3 setObject:messageId forKey:@"messageId"];
    NSArray *resultArr = [[DBManger sharedDMManger] queryTable:messageModelInfo queryByConditions:conditions3 sortByKey:@"receiveTime" sortType:YES];
    if (resultArr.count > 0) {
        NSDictionary *messageDic = resultArr[0];
        MessageModel *messageModel = [MessageModel yy_modelWithJSON:messageDic];
        return messageModel;
    }else{
        return nil;
    }
}
@end
