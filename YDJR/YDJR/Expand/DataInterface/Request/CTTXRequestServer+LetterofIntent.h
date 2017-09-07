//
//  CTTXRequestServer+LetterofIntent.h
//  YDJR
//
//  Created by 李爽 on 2016/10/16.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer.h"
#import "LSMaterialModel.h"
@interface CTTXRequestServer (LetterofIntent)
/**
 证件类型 材料查询

 @param dictitem 字典编号
 @param type type
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)checkMaterialWithDictitem:(NSString *)dictitem WithType:(int)type SuccessBlock:(void (^)(NSMutableArray *materialModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 保存客户

 @param dict 客户和意向单信息
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)saveClientWithInfoDict:(NSMutableDictionary *)dict SuccessBlock:(void (^)(NSDictionary * responseObject))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 更新意向单

 @param dict 客户和意向单信息
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)updateIntentWithInfoDict:(NSDictionary *)dict SuccessBlock:(void (^)(NSDictionary *responseObject))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
