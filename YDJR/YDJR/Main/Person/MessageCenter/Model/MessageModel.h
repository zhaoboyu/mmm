//
//  MessageModel.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/31.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
typedef enum
{
    MESSAGETYPE_SYSTEM=0,//系统通知
    MESSAGETYPE_APPLICATION=1,//应用通知
    MESSAGETYPE_BUSINESS=2,//业务通知
}MESSAGETYPE;

@interface MessageModel : NSObject

/**
 消息Id
 */
@property (nonatomic,copy)NSString *messageId;

/**
 消息标题
 */
@property (nonatomic,copy)NSString *title;

/**
 消息内容
 */
@property (nonatomic,copy)NSString *message;

/**
 推送时间
 */
@property (nonatomic,copy)NSString *receiveTime;

/**
 跳转名称
 */
@property (nonatomic,copy)NSString *jumpName;

/**
 跳转类型
 *01:一次影像资料采集
 *02:补件
 *03:二次进件
 *04:补保单
 *05:重启
 */
@property (nonatomic,copy)NSString *jumpType;

/**
 客户ID
 */
@property (nonatomic,copy)NSString *customerID;

/**
 订单号
 */
@property (nonatomic,copy)NSString *businessID;
@property (nonatomic,assign)MESSAGETYPE messageType;

@property (nonatomic,assign)BOOL isRead;

/**
 影像列表
 */
@property (nonatomic,strong)NSMutableArray *imagelist;


/**
 是否已经完成
 */
@property (nonatomic,assign)BOOL isHandle;
@property (nonatomic,copy)NSString *userName;//用户名

/**
 产品类型
 rzzl:融资租赁
 dfq:达分期
 */
@property (nonatomic,copy)NSString *productType;
@end
