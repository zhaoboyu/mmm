//
//  LSAgentProductsTemplateModel.m
//  YDJR
//
//  Created by 李爽 on 2016/11/14.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//  

#import "LSAgentProductsTemplateModel.h"

@implementation LSAgentProductsTemplateModel
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
//返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{@"roles" : [LLFUserRoleModel class]};
//}
- (void)setProcolumdefaut:(NSString *)procolumdefaut
{
	if (IS_STRING_NOT_EMPTY(procolumdefaut)) {
		NSDictionary *dic = [self dictionaryWithJsonString:procolumdefaut];
		self.procolumdefautArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"d"]];
	}
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
	if (jsonString == nil) {
		return nil;
	}
	
	NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
	NSError *err;
	NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
														options:NSJSONReadingMutableContainers
														  error:&err];
	if(err) {
		NSLog(@"json解析失败：%@",err);
		return nil;
	}
	return dic;
}
@end
