//
//  Contants.h
//  CTTX
//
//  Created by 吕利峰 on 16/4/24.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contants : NSObject

/** 导航条+状态栏高度 */
UIKIT_EXTERN CGFloat const YDMarginTopHeight;
/*
 SYS_HEAD: {TransServiceCode: 'agree.ydjr.b001.02', Contrast: 'AAAAAAAAAAAAAAAA'},
 ReqInfo: {
 Ids: "",
 ObjectType: "contract",
 ObjectNo: "220002016100169",
 TypeNo: "2012",
 Images: msg + "^vdO/2snovMY=^local@jpg|!||!|!",
 UserId: "test11",
 OrgId: "99000"
 }
 */

#define applyFile          @"applyFile_info"

#define Creat_applyFile_Info  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, ObjectNo TEXT, TypeNo TEXT, filePath TEXT, Type TEXT)",applyFile]

#define feedBackImage          @"feedBackImage_info"

#define Creat_feedBackImage_Info  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, opinionId TEXT, filePath TEXT, Type TEXT)",feedBackImage]

/*
 消息表
 */
#define messageModelInfo          @"messageModle_info"

#define Creat_messageModle_info  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, messageId TEXT, title TEXT, message TEXT, receiveTime TEXT, isRead TEXT, messageType TEXT, jumpName TEXT, jumpType TEXT, customerID TEXT, businessID TEXT, imagelist TEXT,isHandle TEXT,userName TEXT,productType TEXT)",messageModelInfo]

/*
 下载消息信息表
 */
#define queryMessageInfo          @"queryMessage_info"

#define Creat_queryMessage_info  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, messageId TEXT, Type TEXT)",queryMessageInfo]

/*
 request缓存信息表
 */
#define cacheRequestInfo          @"cacheRequest_info"

#define Creat_cacheRequest_info  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, bodyParmaValue TEXT, isSendNotification TEXT, noticeName TEXT, requestMethod TEXT, requestId TEXT)",cacheRequestInfo]
@end
