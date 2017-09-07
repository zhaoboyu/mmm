//
//  CTTXRequestServer+financialProgram.m
//  YDJR
//
//  Created by 李爽 on 2016/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+financialProgram.h"

@implementation CTTXRequestServer (financialProgram)
/**
 *  跟据销售名称查询金融产品名称
 *
 *  @param catModelDetailID catModelDetailID
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkProductsWithCatModelDetailID:(NSString *)catModelDetailID SuccessBlock:(void (^)(NSMutableArray *productsModelArr))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    if ([netWork isEqualToString:@"1"]) {
        NSArray *productsDicArr = [NSFileManager loadArrayFromPath:DirectoryTypeMainBundle withFilename:@"lb"];
        NSMutableArray *productsModelArr = [NSMutableArray array];
        if (![productsDicArr isKindOfClass:[NSNull class]]) {
            for (NSDictionary *carDic in productsDicArr) {
                LSFinancialProductsModel *productsModel = [LSFinancialProductsModel yy_modelWithDictionary:carDic];
                [productsModelArr addObject:productsModel];
            }
        }
        SuccessBlock(productsModelArr);
    }else{
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        //ReqInfo
        NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
        [reqinfoDic setObject:catModelDetailID forKey:@"catModelDetailID"];
        
        [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
        [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.c002.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
        //把参数字典转换成JSON字符串
//        NSString *jsonStr = [Tool JSONString:dataDic];
        NetworkRequest *request = [[NetworkRequest alloc]init];
        
//        [request appendBodyParma:@"msg" value:jsonStr];
        [request setParmaBodyWithParma:dataDic];
        //    request.isHttps = YES;
        request.requestMethod = @"POST";
        
        [request requestWithSuccessBlock:^(id responseObject) {
            NSError *error = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",dic);
            NSMutableArray *productsModelArr = [NSMutableArray array];
            NSArray *productsDicArr = [dic objectForKey:@"products"];
            //[NSFileManager saveArrayToPath:DirectoryTypeDocuments withFilename:@"lb" array:productsDicArr];
            //NSLog(@"%@",NSHomeDirectory());
            if (![productsDicArr isKindOfClass:[NSNull class]]) {
                for (NSDictionary *carDic in productsDicArr) {
                    LSFinancialProductsModel *productsModel = [LSFinancialProductsModel yy_modelWithDictionary:carDic];
                    [productsModelArr addObject:productsModel];
                }
            }
            SuccessBlock(productsModelArr);
        } failedBlock:^(NSError *error) {
            
            failedBlock(error);
        }];
    }
}
/**
 根据意向单ID查询意向单
 
 @param intentID 意向单ID
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)checkIntentWithIntentID:(NSString *)intentID SuccessBlock:(void (^)(NSDictionary *intentDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:intentID forKey:@"intentID"];
    
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.g001.06" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    //把参数字典转换成JSON字符串
//    NSString *jsonStr = [Tool JSONString:dataDic];
    NetworkRequest *request = [[NetworkRequest alloc]init];
    
//    [request appendBodyParma:@"msg" value:jsonStr];
    [request setParmaBodyWithParma:dataDic];
    //    request.isHttps = YES;
    request.requestMethod = @"POST";
    
    [request requestWithSuccessBlock:^(id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",dic);
        SuccessBlock(dic);
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];
}
/**
 根据产品ID和条件计算代理产品
 
 @param param 请求信息
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)countAgentProductsTemplateInfoWithRequestParam:(NSMutableDictionary *)param SuccessBlock:(void (^)(NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
	if ([netWork isEqualToString:@"1"]) {

	}else{
		NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
		//ReqInfo
		[dataDic setObject:param forKey:@"ReqInfo"];
		[dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.c002.03" Contrast:param] forKey:@"SYS_HEAD"];
		//把参数字典转换成JSON字符串
//		NSString *jsonStr = [Tool JSONString:dataDic];
		NetworkRequest *request = [[NetworkRequest alloc]init];
		
//		[request appendBodyParma:@"msg" value:jsonStr];
        [request setParmaBodyWithParma:dataDic];
		//    request.isHttps = YES;
		request.requestMethod = @"POST";
		
		[request requestWithSuccessBlock:^(id responseObject) {
			NSError *error = nil;
			NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
			NSLog(@"%@",dic);
			//NSMutableArray *templateModelArray = [NSMutableArray array];
			//NSArray *templateDictArray = [dic objectForKey:@"products"];
			////[NSFileManager saveArrayToPath:DirectoryTypeDocuments withFilename:@"lb" array:productsDicArr];
			////NSLog(@"%@",NSHomeDirectory());
			//if (![templateDictArray isKindOfClass:[NSNull class]]) {
			//	for (NSDictionary *templateDict in templateDictArray) {
			//		LSAgentProductsTemplateModel *templateModel = [LSAgentProductsTemplateModel yy_modelWithDictionary:templateDict];
			//		[templateModelArray addObject:templateModel];
			//	}
			//}
			SuccessBlock(dic);
		} failedBlock:^(NSError *error) {
			
			failedBlock(error);
		}];
	}
}
/**
 根据产品ID查询代理产品模板信息
 
 @param productID 请求信息
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)checkAgentProductsTemplateInfoWithProductID:(NSString *)productID SuccessBlock:(void (^)(NSMutableArray *templateModelArray))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
	if ([netWork isEqualToString:@"1"]) {
		//NSArray *templateDictArray = [NSFileManager loadArrayFromPath:DirectoryTypeMainBundle withFilename:@"lb"];
		//NSMutableArray *templateModelArray = [NSMutableArray array];
		//if (![templateDictArray isKindOfClass:[NSNull class]]) {
		//	for (NSDictionary *templateDict in templateDictArray) {
		//		LSAgentProductsTemplateModel *templateModel = [LSAgentProductsTemplateModel yy_modelWithDictionary:templateDict];
		//		[templateModelArray addObject:templateModel];
		//	}
		//}
		//SuccessBlock(templateModelArray);
	}else{
		NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
		//ReqInfo
		NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
		[reqinfoDic setObject:productID forKey:@"productID"];
		
		[dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
		[dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.c002.02" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
		//把参数字典转换成JSON字符串
//		NSString *jsonStr = [Tool JSONString:dataDic];
		NetworkRequest *request = [[NetworkRequest alloc]init];
		
//		[request appendBodyParma:@"msg" value:jsonStr];
        [request setParmaBodyWithParma:dataDic];
		//    request.isHttps = YES;
		request.requestMethod = @"POST";
		
		[request requestWithSuccessBlock:^(id responseObject) {
			NSError *error = nil;
			NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
			NSLog(@"%@",dic);
			NSMutableArray *templateModelArray = [NSMutableArray array];
			NSArray *templateDictArray = [dic objectForKey:@"products"];
			//[NSFileManager saveArrayToPath:DirectoryTypeDocuments withFilename:@"lb" array:productsDicArr];
			//NSLog(@"%@",NSHomeDirectory());
			if (![templateDictArray isKindOfClass:[NSNull class]]) {
				for (NSDictionary *templateDict in templateDictArray) {
					LSAgentProductsTemplateModel *templateModel = [LSAgentProductsTemplateModel yy_modelWithDictionary:templateDict];
					[templateModelArray addObject:templateModel];
				}
			}
			SuccessBlock(templateModelArray);
		} failedBlock:^(NSError *error) {
			
			failedBlock(error);
		}];
	}

}
@end
