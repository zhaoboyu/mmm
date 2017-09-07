//
//  DBManger.h
//  CTTX
//
//  Created by 吕利峰 on 16/4/24.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "Contants.h"
@interface DBManger : NSObject
@property (nonatomic, strong) NSTimer *timer;


+ (instancetype)sharedDMManger;
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
- (BOOL)creatDbTableWithSqlStr:(NSString *)sqlStr;

#pragma mark insert增
/**
 *	@brief  根据表单名字插入数据
 *
 *	@param  tableName 执行插入表单的表单名
 *	@param  dictionary 执行插入表单的内容，是一个NSDictionary对象（dictionary中的keys要与表单字段名保持一致）
 *
 *	@return  创建结果 BOOL值 (YES:插入成功 NO:插入失败)
 */
- (BOOL) insertTable:(NSString *)tableName withObjectDictionary:(NSDictionary *)dictionary;
#pragma mark update改
/**
 *	@brief  根据表单字段的某些字段更新数据
 *
 *	@param  tableName 执行更新表单的表单名
 *	@param  conditions 执行更新表单的条件（可为多条件，conditions中的keys要与表单字段名字相同）
 *	@param  dictionary 执行更新表单的内容，是一个NSDictionary对象（dictionary中的keys要与表单字段名保持一致）
 *
 *	@return  更新结果 BOOL值 (YES:更新成功 NO:更新失败)
 */
- (BOOL) updateTable:(NSString *)tableName updateByConditions:(NSDictionary *)conditions withObjectDictionary:(NSDictionary *)dictionary;
#pragma mark delete删
/**
 *	@brief  根据dictionary内容针对某一table进行条件删除
 *
 *	@param  tableName 执行删除表单的表单名
 *	@param  conditions 执行删除表单的条件，是一个NSDictionary对象（可为多条件，dictionary中的keys要与表单字段名保持一致）
 *
 *	@return  删除结果 BOOL值 (YES:删除成功 NO:删除失败)
 */
- (BOOL) deleteTable:(NSString *)tableName deleteByConditions:(NSDictionary *)conditions;
//删除表
- (BOOL) deletetable:(NSString *)tableName;
#pragma mark query查
/**
 *	@brief  根据sql语句查询某个表单数据
 *
 *	@param  sql 执行查询表单的sql语句
 *
 *	@return  返回内部为NSDictionary的NSArray对象
 */
- (NSArray *) queryTableWithSql:(NSString *)sql;
/**
 根据条件查询某个表单数据
 
 @param tableName 执行查询表单的表单名
 @param conditions 执行查询表单的条件，是一个NSDictionary对象（可为多条件，dictionary中的keys要与表单字段名保持一致）
 @param sortKey 排序字段（sortKey要与表单字段名保持一致）
 @param sortType 是否降序
 @return 返回内部为NSDictionary的NSArray对象
 */
- (NSArray *) queryTable:(NSString *)tableName queryByConditions:(NSDictionary *)conditions  sortByKey:(NSString *) sortKey sortType:(BOOL) sortType;

#pragma mark -其他
/**
 *	@brief  判断某个表内是否存在某些字段，如果存在执行更新，如果不存在，执行插入
 *
 *	@param  tableName 执行更新/插入表单的表单名
 *	@param  conditions 执行更新/插入表单的查询的条件（可为多条件，dictionary中的keys要与表单字段名保持一致）
 *	@param  object 执行更新/插入表单的NSDictionary对象
 *
 *	@return 更新/插入结果 BOOL值 (YES:更新/插入成功 NO:更新/插入失败)
 */
- (BOOL) queryTable:(NSString *)tableName ifExistsWithConditions:(NSDictionary *)conditions withNewObject:(NSDictionary *)object;
@end
