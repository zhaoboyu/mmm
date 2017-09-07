//
//  MessageModel.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/31.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    return [self yy_modelInitWithCoder:aDecoder];
}
- (id)copyWithZone:(NSZone *)zone
{
    return [self yy_modelCopy];
}
-(NSString *)description
{
    return [self yy_modelDescription];
}
// 当 JSON 转为 Model 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *messageTypeStr = dic[@"messageType"];
    if ([messageTypeStr isEqualToString:@"0"]) {
        _messageType = MESSAGETYPE_SYSTEM;
    }else if ([messageTypeStr isEqualToString:@"1"]){
        _messageType = MESSAGETYPE_APPLICATION;
    }else if ([messageTypeStr isEqualToString:@"2"]){
        _messageType = MESSAGETYPE_BUSINESS;
    }
    NSString *isReadStr = dic[@"isRead"];
    if ([isReadStr isEqualToString:@"1"]) {
        _isRead = YES;
    }else{
        _isRead = NO;
    }
    NSString *isHandleStr = dic[@"isHandle"];
    if ([isHandleStr isEqualToString:@"1"]) {
        _isHandle = YES;
    }else{
        _isHandle = NO;
    }
    return YES;
}
@end
