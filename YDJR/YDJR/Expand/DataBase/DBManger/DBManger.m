//
//  DBManger.m
//  CTTX
//
//  Created by 吕利峰 on 16/4/24.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "DBManger.h"
#import "UploadFileModel.h"
#import "CTTXRequestServer+FileUpload.h"
#import "CTTXRequestServer+fileManger.h"
#import "CTTXRequestServer+statusCodeCheck.h"
#import "MessageModel.h"
#import "MessageCenterViewModel.h"
static DBManger *dbManger = nil;
#define SNum 20
@interface DBManger ()
@property (nonatomic,copy)NSString *fileName;
@property (nonatomic,strong)FMDatabase *db;
@end

@implementation DBManger
+ (instancetype)sharedDMManger
{
    //这段代码只被执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManger = [[DBManger alloc]init];
    });
    return dbManger;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //打开定时器
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        //1.获得数据库文件的路径
        NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
        
        self.fileName = [doc stringByAppendingPathComponent:@"applyFile.sqlite"];
        //2.获取数据库
        self.db = [FMDatabase databaseWithPath:self.fileName];
        if ([self.db open]) {
            NSLog(@"数据库打开成功");
            //创建所需数据库表
            [self createTableList];
        }else{
            NSLog(@"数据库打开失败");
        }
        
    }
    return self;
}
/*
 *创建数据库表
 *
 *parmam
 *sqlStr:创建数据库表的sql语句
 *
 *return
 *Yes:创建表成功
 *NO:创建表失败
 */
- (BOOL)creatDbTableWithSqlStr:(NSString *)sqlStr
{
    //创表
    BOOL result = [self.db executeUpdate:sqlStr];
    NSArray *a = [sqlStr componentsSeparatedByString:@" ("];
    NSArray *new = [[a objectAtIndex:0] componentsSeparatedByString:@" "];
    if (result) {
        NSLog(@"创建数据表:%@成功",[new lastObject]);
        return YES;
    }else{
        //创建表失败
        NSLog(@"创建数据表:%@失败",[new lastObject]);
        return NO;
    }
}
#pragma mark - insert Table
/**
 *	@brief  根据表单名字插入数据
 *
 *	@param  tableName 执行插入表单的表单名
 *	@param  dictionary 执行插入表单的内容，是一个NSDictionary对象（dictionary中的keys要与表单字段名保持一致）
 *
 *	@return  创建结果 BOOL值 (YES:插入成功 NO:插入失败)
 */
- (BOOL) insertTable:(NSString *)tableName withObjectDictionary:(NSDictionary *)dictionary
{
    NSMutableDictionary *object = [dictionary mutableCopy]; //转化为可变数组
    NSString *keys = nil;
    NSString *values = nil;
    NSArray *keyArray = [object allKeys];
    
    for (int i = 0; i < [keyArray count]; i ++) {
        
        NSString *key = [NSString stringWithFormat:@"\"%@\"",[keyArray objectAtIndex:i]];
        id value = [NSString stringWithFormat:@"'%@'",[object objectForKey:[keyArray objectAtIndex:i]]];
        //        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
        //
        //            NSData *data = [NSJSONSerialization dataWithJSONObject:[NSString stringWithFormat:@"%@",[object objectForKey:[keyArray objectAtIndex:i]]] options:NSJSONWritingPrettyPrinted error:nil];
        //            value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //            value = [NSString stringWithFormat:@"'%@'",value];
        //        }
        
        if (i == 0) {
            keys = key;
            values = value;
        }
        else {
            keys = [keys stringByAppendingFormat:@",%@",key];
            values = [values stringByAppendingFormat:@",%@",value];
        }
    }
    //插入SQL语句
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@) values (%@);",tableName,keys,values];
    
    BOOL res;
    res = [self.db executeUpdate:sql];
    if (res == NO) {
        
        NSLog(@"数据插入 %@ 失败",tableName);
        return NO;
    }
    else {
        
        NSLog(@"数据插入 %@ 成功",tableName);
    }
    return res;
}
//更新
- (BOOL) updateTable:(NSString *)tableName updateByConditions:(NSDictionary *)conditions withObjectDictionary:(NSDictionary *)dictionary {
    
    NSLog(@"数据存在 执行修改");
    NSString *updateString = [[NSString alloc] init];
    NSArray *keyArray = [dictionary allKeys];
    //设置更新全部内容
    for (int i = 0; i < [keyArray count]; i ++) {
        NSString *key = [keyArray objectAtIndex:i];
        id value = [dictionary objectForKey:key];
        //        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
        //
        //            NSData *data = [NSJSONSerialization dataWithJSONObject:[dictionary objectForKey:key] options:NSJSONWritingPrettyPrinted error:nil];
        //            value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        }
        NSString *newStr = [NSString stringWithFormat:@"\"%@\" = '%@'",key,value];
        if (i == 0) {
            
            updateString = newStr;
        }
        else {
            
            updateString = [updateString stringByAppendingFormat:@", %@",newStr];
        }
    }
    //设置更新条件
    NSString *conditionsString = [[NSString alloc] init];
    NSArray *conditionsKeyArray = [conditions allKeys];
    if (conditionsKeyArray.count != 0) {
        
        for (int i = 0; i < [conditionsKeyArray count]; i ++) {
            
            NSString *key = [conditionsKeyArray objectAtIndex:i];
            id value = [conditions objectForKey:key];
            //            if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            //                NSData *data = [NSJSONSerialization dataWithJSONObject:[conditions objectForKey:key] options:NSJSONWritingPrettyPrinted error:nil];
            //                value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //            }
            
            NSString *newStr = [NSString stringWithFormat:@"\"%@\" = '%@'",key,value];
            
            if (i == 0) {
                
                conditionsString = newStr;
            }
            else {
                
                conditionsString = [conditionsString stringByAppendingFormat:@" and %@",newStr];
            }
        }
    }
    else {
        
        conditionsString = @"'1' = '1'";
    }
    //更新语句
    NSString *sqlString = [NSString stringWithFormat:
                           @"update %@ set %@ where %@",
                           tableName,updateString,
                           conditionsString];
    BOOL res;
    res = [self.db executeUpdate:sqlString];
    if (res == NO) {
        
        NSLog(@"%@ 数据 %@ 更新失败",tableName,conditionsString);
        return NO;
    }
    else {
        
        NSLog(@"%@ 数据 %@ 更新成功",tableName,conditionsString);
        return YES;
    }
}
#pragma mark - delete Table
/**
 *	@brief  根据dictionary内容针对某一table进行条件删除
 *
 *	@param  tableName 执行删除表单的表单名
 *	@param  conditions 执行删除表单的条件，是一个NSDictionary对象（可为多条件，dictionary中的keys要与表单字段名保持一致）
 *
 *	@return  删除结果 BOOL值 (YES:删除成功 NO:删除失败)
 */
- (BOOL) deleteTable:(NSString *)tableName deleteByConditions:(NSDictionary *)conditions {
    
    NSString *conditionsString = [[NSString alloc] init];
    NSArray *keyArray = [conditions allKeys];
    for (int i = 0; i < [keyArray count]; i ++) {
        
        NSString *key = [keyArray objectAtIndex:i];
        id value = [conditions objectForKey:key];
        //        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
        //            NSData *data = [NSJSONSerialization dataWithJSONObject:[conditions objectForKey:key] options:NSJSONWritingPrettyPrinted error:nil];
        //            value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //        }
        
        NSString *newStr = [NSString stringWithFormat:@"\"%@\" = '%@'",key,value];
        
        if (i == 0) {
            
            conditionsString = newStr;
        }
        else {
            
            conditionsString = [conditionsString stringByAppendingFormat:@" and %@",newStr];
        }
    }
    NSString *sqlString = [NSString stringWithFormat:@"delete from %@ where %@", tableName,conditionsString];
    BOOL res;
    res = [self.db executeUpdate:sqlString];
    if (res == NO) {
        
        NSLog(@"%@ 数据删除失败",tableName);
        return NO;
    }
    else {
        
        NSLog(@"%@ 数据删除成功",tableName);
        return YES;
    }
}



#pragma mark - query Table
/**
 *	@brief  根据sql语句查询某个表单数据
 *
 *	@param  sql 执行查询表单的sql语句
 *
 *	@return  返回内部为NSDictionary的NSArray对象
 */
- (NSArray *) queryTableWithSql:(NSString *)sql {
    
    FMResultSet *rs = [self.db executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    while ([rs next]) {
        
        [array addObject:[rs resultDictionary]];
    }
    return array;
}

/**
 根据条件查询某个表单数据
 
 @param tableName 执行查询表单的表单名
 @param conditions 执行查询表单的条件，是一个NSDictionary对象（可为多条件，dictionary中的keys要与表单字段名保持一致）
 @param sortKey 排序字段（sortKey要与表单字段名保持一致）
 @param sortType 是否降序
 @return 返回内部为NSDictionary的NSArray对象
 */
- (NSArray *) queryTable:(NSString *)tableName queryByConditions:(NSDictionary *)conditions  sortByKey:(NSString *) sortKey sortType:(BOOL) sortType {
    
    NSString *conditionsString = [[NSString alloc] init];
    NSMutableArray *keyArray = [[NSMutableArray alloc] initWithCapacity:0];
    if ([conditions count] != 0) {
        //查询条件不为空
        keyArray = (NSMutableArray *)[conditions allKeys];
        NSLog(@"%@",keyArray[0]);
        for (int i = 0; i < [keyArray count]; i ++) {
            
            NSString *key = [keyArray objectAtIndex:i];
            id value = [conditions objectForKey:key];
            if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                NSData *data = [NSJSONSerialization dataWithJSONObject:[conditions objectForKey:key] options:NSJSONWritingPrettyPrinted error:nil];
                value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
            NSString *newStr = nil;
            //判断是否为区间字段
            if ([key isEqual:@"SUBMITTIME"]) {
                newStr = [NSString stringWithFormat:@"%@ %@",key,value];
                NSLog(@"%@",newStr);
            }else{
                //单一查询条件
                newStr = [NSString stringWithFormat:@"\"%@\" = '%@'",key,value];
                NSLog(@"=====%@",newStr);
            }
            
            
            if (i == 0) {
                
                conditionsString = newStr;
            }
            else {
                
                conditionsString = [conditionsString stringByAppendingFormat:@" and %@",newStr];
            }
        }
        conditionsString = [NSString stringWithFormat:@" where %@",conditionsString];
    }
    
    if (sortKey.length != 0) {
        if (sortType) {
            NSString *orderBy = [NSString stringWithFormat:@" order by \"%@\" desc",sortKey];
            conditionsString = [conditionsString stringByAppendingString:orderBy];
        }else{
            NSString *orderBy = [NSString stringWithFormat:@" order by \"%@\"",sortKey];
            conditionsString = [conditionsString stringByAppendingString:orderBy];
        }
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"select * from %@%@",tableName,conditionsString];
    FMResultSet *rs = [self.db executeQuery:sqlString];
    NSMutableArray *returnArray = [NSMutableArray array];
    while ([rs next]) {
        
        [returnArray addObject:[rs resultDictionary]];
        NSLog(@"%@",[rs resultDictionary]);
    }
    return returnArray;
}


//删除表
- (BOOL) deletetable:(NSString *)tableName
{
    NSString *sqlString = [NSString stringWithFormat:@"delete from %@",tableName];
    BOOL res;
    res = [self.db executeUpdate:sqlString];
    
    if (res== YES ) {
        
        NSLog(@"%@ 数据删除成功",tableName);
        return YES;
    }else{
        NSLog(@"%@ 数据删除失败",tableName);
        return NO;
    }
}

/**
 *	@brief  判断某个表内是否存在某些字段，如果存在执行更新，如果不存在，执行插入
 *
 *	@param  tableName 执行更新/插入表单的表单名
 *	@param  conditions 执行更新/插入表单的查询的条件（可为多条件，dictionary中的keys要与表单字段名保持一致）
 *	@param  object 执行更新/插入表单的NSDictionary对象
 *
 *	@return 更新/插入结果 BOOL值 (YES:更新/插入成功 NO:更新/插入失败)
 */
- (BOOL) queryTable:(NSString *)tableName ifExistsWithConditions:(NSDictionary *)conditions withNewObject:(NSDictionary *)object {
    
    //设置更新条件
    NSString *conditionsString = [[NSString alloc] init];
    NSArray *conditionsKeyArray = [conditions allKeys];
    for (int i = 0; i < [conditionsKeyArray count]; i ++) {
        
        NSString *key = [conditionsKeyArray objectAtIndex:i];
        id value = [conditions objectForKey:key];
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:[conditions objectForKey:key] options:NSJSONWritingPrettyPrinted error:nil];
            value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
        
        NSString *newStr = [NSString stringWithFormat:@"\"%@\" = '%@'",key,value];
        
        if (i == 0) {
            
            conditionsString = newStr;
        }
        else {
            
            conditionsString = [conditionsString stringByAppendingFormat:@" and %@",newStr];
        }
    }
    
    NSString *sqlString = [NSString stringWithFormat:@"select * from %@ where %@",tableName,conditionsString];
    FMResultSet *rs = [self.db executeQuery:sqlString];
    BOOL res;
    
    if([rs next]) {
        
        res = [self updateTable:tableName updateByConditions:conditions withObjectDictionary:object];
        return res;
    }
    else {
        
        res = [self insertTable:tableName withObjectDictionary:object];
        return res;
    }
    return res;
}
//创建文件上传表
- (void) createTableList
{
    [self creatDbTableWithSqlStr:Creat_applyFile_Info];
    
    [self creatDbTableWithSqlStr:Creat_feedBackImage_Info];
    
    [self creatDbTableWithSqlStr:Creat_messageModle_info];
    
    [self creatDbTableWithSqlStr:Creat_queryMessage_info];
    
    [self creatDbTableWithSqlStr:Creat_cacheRequest_info];
}

//开启定时器检查有没有要上传的图片文件
- (void)timerAction:(NSTimer *)sender
{
    //    [[CTTXRequestServer shareInstance] AFNetworkStatu:^(AFNetworkReachabilityStatus statu) {
    //
    //    }];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //无网络
            
        }else{
            NSLog(@"开始检测数据库时,关闭定时器!");
            [self.timer invalidate];
            self.timer = nil;
            //检测影像资料图片
            NSString *applySqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ where Type == '1'",applyFile];
            NSArray *resultArr = [self queryTableWithSql:applySqlStr];
            if (resultArr.count > 0) {
                [self uploadFileInfoWithResultArr:resultArr];
            }else{
                //检测意见反馈图片
                NSString *feedBackSqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ where Type == '1'",feedBackImage];
                NSArray *tempArr = [self queryTableWithSql:feedBackSqlStr];
                if (tempArr.count > 0) {
                    [self uploadFeedBackImageWithResultArr:tempArr];
                }else{
                    //检测要下载的消息
                    NSString *queryMessageSqlStr = [NSString stringWithFormat:@"SELECT * FROM %@ where Type == '1'",queryMessageInfo];
                    NSArray *messageIdArr = [self queryTableWithSql:queryMessageSqlStr];
                    if (messageIdArr.count > 0) {
                        [self queryMessageWithMessageIdArr:messageIdArr];
                    }else{
                        //没有要上传的文件时,开始定时器
                        NSLog(@"没有要上传的文件时,开启定时器!");
                        self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
                    }
                    
                }
                
            }
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

//上传影像资料
- (void)uploadFileInfoWithResultArr:(NSArray *)resultArr
{
    //开始上传文件
    UploadFileModel *fileModel = [[UploadFileModel alloc]init];
    fileModel.filePath = [resultArr[0] objectForKey:@"filePath"];
    fileModel.ObjectNo = [resultArr[0] objectForKey:@"ObjectNo"];
    fileModel.TypeNo = [resultArr[0] objectForKey:@"TypeNo"];
    if ([Tool isExistWithImagePath:fileModel.filePath]) {
        //上传文件
        NSLog(@"开始上传文件!");
        [[CTTXRequestServer shareInstance] fileUploadWithFileModel:fileModel WithSuccessBlock:^(NSString *ReturnCode) {
            //上送成功
            if ([ReturnCode isEqualToString:@"success"]) {
                NSDictionary *conditions = @{@"filePath":fileModel.filePath};
                [self deleteTable:applyFile deleteByConditions:conditions];
            }else{
                NSDictionary *conditions = @{@"filePath":fileModel.filePath};
                NSDictionary *conditions1 = @{@"Type":@"0"};
                [self updateTable:applyFile updateByConditions:conditions withObjectDictionary:conditions1];
            }
            self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        } failedBlock:^(NSError *error) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        }];
        NSLog(@"结束循环!");
    }else{
        NSLog(@"文件不存在,结束循环!");
        NSDictionary *conditions = @{@"filePath":fileModel.filePath};
        NSDictionary *conditions1 = @{@"Type":@"0"};
        [self updateTable:applyFile updateByConditions:conditions withObjectDictionary:conditions1];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
    
    
}
//上穿意见反馈图片
- (void)uploadFeedBackImageWithResultArr:(NSArray *)resultArr
{
    //开始上传文件
    UploadFileModel *fileModel = [[UploadFileModel alloc]init];
    fileModel.filePath = [resultArr[0] objectForKey:@"filePath"];
    fileModel.opinionId = [resultArr[0] objectForKey:@"opinionId"];
    if ([Tool isExistWithImagePath:fileModel.filePath]) {
        //上传文件
        NSLog(@"开始上传文件!");
        [[CTTXRequestServer shareInstance] fileUploadOpinionIdWithFileModel:fileModel WithSuccessBlock:^(BOOL ReturnCode) {
            //上送成功
            if (ReturnCode) {
                NSDictionary *conditions = @{@"filePath":fileModel.filePath};
                [self deleteTable:feedBackImage deleteByConditions:conditions];
            }else{
                NSDictionary *conditions = @{@"filePath":fileModel.filePath};
                NSDictionary *conditions1 = @{@"Type":@"0"};
                [self updateTable:feedBackImage updateByConditions:conditions withObjectDictionary:conditions1];
            }
            self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        } failedBlock:^(NSError *error) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        }];
//        [[CTTXRequestServer shareInstance] imageUploadWithFileModel:fileModel WithSuccessBlock:^(BOOL ReturnCode) {
//            //上送成功
//            if (ReturnCode) {
//                NSDictionary *conditions = @{@"filePath":fileModel.filePath};
//                [self deleteTable:feedBackImage deleteByConditions:conditions];
//            }else{
//                NSDictionary *conditions = @{@"filePath":fileModel.filePath};
//                NSDictionary *conditions1 = @{@"Type":@"0"};
//                [self updateTable:feedBackImage updateByConditions:conditions withObjectDictionary:conditions1];
//            }
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
//        } failedBlock:^(NSError *error) {
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
//        }];
        NSLog(@"结束循环!");
    }else{
        NSLog(@"文件不存在,结束循环!");
        NSDictionary *conditions = @{@"filePath":fileModel.filePath};
        NSDictionary *conditions1 = @{@"Type":@"0"};
        [self updateTable:feedBackImage updateByConditions:conditions withObjectDictionary:conditions1];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }
}
//下载消息
- (void)queryMessageWithMessageIdArr:(NSArray *)messageIdArr
{
    NSLog(@"开始下载消息!");
    NSString *messageId = [messageIdArr[0] objectForKey:@"messageId"];
    [[CTTXRequestServer shareInstance] checkStatusCodeMessageWithMessageId:messageId SuccessBlock:^(MessageModel *messageModel) {
        NSDictionary *conditions = @{@"messageId":messageModel.messageId};
        [self deleteTable:queryMessageInfo deleteByConditions:conditions];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        
    } failedBlock:^(NSError *error) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:SNum target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    }];
}
- (void)checkCacheRequestInfo
{
    //检测影像资料图片
    NSString *requestSqlStr = [NSString stringWithFormat:@"SELECT * FROM %@",cacheRequestInfo];
//    NSArray *resultArr = [self queryTableWithSql:requestSqlStr];
}
@end
