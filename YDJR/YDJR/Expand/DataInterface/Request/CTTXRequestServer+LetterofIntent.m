//
//  CTTXRequestServer+LetterofIntent.m
//  YDJR
//
//  Created by 李爽 on 2016/10/16.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+LetterofIntent.h"

@implementation CTTXRequestServer (LetterofIntent)

/**
 *  材料查询
 *
 *  @param dictitem dictitem
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)checkMaterialWithDictitem:(NSString *)dictitem WithType:(int)type SuccessBlock:(void (^)(NSMutableArray *))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    if ([netWork isEqualToString:@"1"]) {
        if (type == 1) {
            SuccessBlock([self getMaterialModelArrWithType:1]);
        }
        if (type == 2) {
            SuccessBlock([self getMaterialModelArrWithType:2]);
        }
        if (type == 101) {
           NSArray *materialDicArr = [NSFileManager loadArrayFromPath:DirectoryTypeMainBundle withFilename:@"zd"];
            NSMutableArray *materialModelArr = [NSMutableArray array];
            if (![materialDicArr isKindOfClass:[NSNull class]]) {
                for (NSDictionary *carDic in materialDicArr) {
                    LSMaterialModel *materialModel = [LSMaterialModel yy_modelWithDictionary:carDic];
                    [materialModelArr addObject:materialModel];
                }
            }
            SuccessBlock(materialModelArr);

        }
        if (type == 100) {
            if ([dictitem isEqualToString:@"IDFS000303"]) {
                NSArray *materialDicArr = [NSFileManager loadArrayFromPath:DirectoryTypeMainBundle withFilename:@"kxc"];
                NSMutableArray *materialModelArr = [NSMutableArray array];
                if (![materialDicArr isKindOfClass:[NSNull class]]) {
                    for (NSDictionary *carDic in materialDicArr) {
                        LSMaterialModel *materialModel = [LSMaterialModel yy_modelWithDictionary:carDic];
                        [materialModelArr addObject:materialModel];
                    }
                }
                SuccessBlock(materialModelArr);
            }
            if ([dictitem isEqualToString:@"IDFS000312"]) {
                NSArray *materialDicArr = [NSFileManager loadArrayFromPath:DirectoryTypeMainBundle withFilename:@"rzzl"];
                NSMutableArray *materialModelArr = [NSMutableArray array];
                if (![materialDicArr isKindOfClass:[NSNull class]]) {
                    for (NSDictionary *carDic in materialDicArr) {
                        LSMaterialModel *materialModel = [LSMaterialModel yy_modelWithDictionary:carDic];
                        [materialModelArr addObject:materialModel];
                    }
                }
                SuccessBlock(materialModelArr);
            }
            if ([dictitem isEqualToString:@"IDFS000313"]) {
                NSArray *materialDicArr =[NSFileManager loadArrayFromPath:DirectoryTypeMainBundle withFilename:@"bmjr"];
                NSMutableArray *materialModelArr = [NSMutableArray array];
                if (![materialDicArr isKindOfClass:[NSNull class]]) {
                    for (NSDictionary *carDic in materialDicArr) {
                        LSMaterialModel *materialModel = [LSMaterialModel yy_modelWithDictionary:carDic];
                        [materialModelArr addObject:materialModel];
                    }
                }
                SuccessBlock(materialModelArr);
            }
        }
        
    }else{
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        //ReqInfo
        NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
        [reqinfoDic setObject:dictitem forKey:@"dictitem"];
        
        [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
        [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.d001.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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
            NSLog(@"===%@",dic);
            NSMutableArray *materialModelArr = [NSMutableArray array];
            NSArray *materialDicArr = [dic objectForKey:@"dicts"];
			//if ([dictitem isEqualToString:@"IDFS000305"]) {
			//	[NSFileManager saveArrayToPath:DirectoryTypeDocuments withFilename:@"zd" array:materialDicArr];
			//	NSLog(@"%@",NSHomeDirectory());
			//}
			//if ([dictitem isEqualToString:@"IDFS000303"]) {
			//	[NSFileManager saveArrayToPath:DirectoryTypeDocuments withFilename:@"kxc" array:materialDicArr];
			//}
			//if ([dictitem isEqualToString:@"IDFS000312"]) {
			//	[NSFileManager saveArrayToPath:DirectoryTypeDocuments withFilename:@"rzzl" array:materialDicArr];
			//}
			//if ([dictitem isEqualToString:@"IDFS000313"]) {
			//	[NSFileManager saveArrayToPath:DirectoryTypeDocuments withFilename:@"bmjr" array:materialDicArr];
			//}
			
            if (![materialDicArr isKindOfClass:[NSNull class]]) {
                for (NSDictionary *carDic in materialDicArr) {
                    LSMaterialModel *materialModel = [LSMaterialModel yy_modelWithDictionary:carDic];
                    [materialModelArr addObject:materialModel];
                }
            }
            SuccessBlock(materialModelArr);
        } failedBlock:^(NSError *error) {
            
            failedBlock(error);
        }];
    }
}
/**
 保存客户
 
 @param dict 客户和意向单信息
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)saveClientWithInfoDict:(NSMutableDictionary *)dict SuccessBlock:(void (^)(NSDictionary *responseObject))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock{
    if ([netWork isEqualToString:@"1"]) {
        //SuccessBlock([self getProductsModelArr]);
    }else{
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        
        [dataDic setObject:dict forKey:@"ReqInfo"];
        [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.i003.01" Contrast:dict] forKey:@"SYS_HEAD"];
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
            SuccessBlock(dic);
            //SuccessBlock(@"成功");
        } failedBlock:^(NSError *error) {
            
            failedBlock(error);
        }];
    }

}
/**
 更新意向单
 
 @param dict 客户和意向单信息
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)updateIntentWithInfoDict:(NSDictionary *)dict SuccessBlock:(void (^)(NSDictionary *responseObject))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock{
    if ([netWork isEqualToString:@"1"]) {
        //SuccessBlock([self getProductsModelArr]);
    }else{
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        
        [dataDic setObject:dict forKey:@"ReqInfo"];
        [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.g001.07" Contrast:dict] forKey:@"SYS_HEAD"];
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
            NSLog(@"agree.ydjr.g001.07:%@",dic);
            SuccessBlock(dic);
            //SuccessBlock(@"成功");
        } failedBlock:^(NSError *error) {
            
            failedBlock(error);
        }];
    }
    
}


-(NSMutableArray *)getMaterialModelArrWithType:(int)type
{
    NSDictionary *dic = nil;
    if (type == 1) {
        dic = @{
                              @"dicts": @[
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"身份证",
                                          @"dictvalue": @"1"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"护照",
                                          @"dictvalue": @"2"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"军官证",
                                          @"dictvalue": @"3"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"武警士兵证",
                                          @"dictvalue": @"4"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"港澳居民往来内地通行证",
                                          @"dictvalue": @"5"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"户口簿",
                                          @"dictvalue":@"6"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"其他证件(个人)",
                                          @"dictvalue": @"7"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"警官证",
                                          @"dictvalue": @"8"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"执行公务证",
                                          @"dictvalue": @"9"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"士兵证",
                                          @"dictvalue": @"A"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"台湾居民来往大陆通行证",
                                          @"dictvalue": @"B"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"临时居民身份证",
                                          @"dictvalue": @"C"
                                          },
                                      @{
                                          @"dictdesc": @"",
                                          @"dictitem": @"IDFS000210",
                                          @"dictname": @"外国人居留证",
                                          @"dictvalue": @"D"
                                          }
                                      ]
                              };

    }
    if (type == 2) {
       dic = @{@"dicts":@[
                  @{@"dictdesc":@"",@"dictitem":@"IDFS000299",@"dictname":@"申请人身份证件",@"dictvalue":@"1"},
                  @{@"dictdesc":@"",@"dictitem":@"IDFS000299",@"dictname":@"申请人个人六个月银行对账单",@"dictvalue":@"2"},
                  @{@"dictdesc":@"",@"dictitem":@"IDFS000299",@"dictname":@"申请人名下自有房产证明",@"dictvalue":@"3"},
                  @{@"dictdesc":@"",@"dictitem":@"IDFS000299",@"dictname":@"还款银行卡",@"dictvalue":@"4"},
                  @{@"dictdesc":@"",@"dictitem":@"IDFS000299",@"dictname":@"征信查询授权书",@"dictvalue":@"5"}
                  ]
               };
    }
        NSMutableArray *productsModelArr = [NSMutableArray array];
    NSArray *productsDicArr = [dic objectForKey:@"dicts"];
    if (![productsDicArr isKindOfClass:[NSNull class]]) {
        for (NSDictionary *carDic in productsDicArr) {
            LSMaterialModel *materialModel = [LSMaterialModel yy_modelWithDictionary:carDic];
            [productsModelArr addObject:materialModel];
        }
    }
    return productsModelArr;
}

@end
