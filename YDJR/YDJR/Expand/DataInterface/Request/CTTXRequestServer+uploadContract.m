//
//  CTTXRequestServer+uploadContract.m
//  YDJR
//
//  Created by 李爽 on 2017/3/17.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+uploadContract.h"

@implementation CTTXRequestServer (uploadContract)

/**
 上传合同
 
 @param param 请求参数
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
-(void)uploadContractWithRequestParam:(NSDictionary *)param SuccessBlock:(void (^)(NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
	NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
	[dataDic setObject:param forKey:@"ReqInfo"];
	[dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.x001.04" Contrast:param] forKey:@"SYS_HEAD"];
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
 采集影像是上传

 @param businessID 订单号
 @param typeNo 影像代码
 @param operationType 操作类型
 @param imageName 合同号
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)uploadContractInBGWithBusinessID:(NSString *)businessID typeNo:(NSString *)typeNo operationType:(NSString *)operationType imageName:(NSString *)imageName SuccessBlock:(void (^)(NSDictionary *dic))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    //测试用：66df1f53-cc63-44d4-afc3-f8bb3511d030
    [reqinfoDic setObject:businessID forKey:@"businessID"];
    [reqinfoDic setObject:typeNo forKey:@"typeNo"];
    [reqinfoDic setObject:operationType forKey:@"operationType"];
    [reqinfoDic setObject:imageName forKey:@"imageName"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.x001.13" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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
 下载合同

 @param businessID 订单号
 @param fileName 合同号
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)downContractWithBusinessID:(NSString *)businessID fileName:(NSString *)fileName SuccessBlock:(void (^)(NSString *contractPath))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NetworkRequest *request = [[NetworkRequest alloc]init];
    request.url = [NSString stringWithFormat:@"%@DownLoadServlet.do?businessID=%@&fileName=%@",baseNetWorkURL,businessID,fileName];
    request.requestMethod = @"GET";
    request.isDownFile = YES;
    
    [request requestWithSuccessBlock:^(id responseObject) {
        NSString *filePath = [Tool getImagePathWithImageURL:fileName];
//        NSLog(@"%@----%@",filePath,responseObject);
        //创建一个文件
        NSFileManager *fileManage = [NSFileManager defaultManager];
        [fileManage createFileAtPath:filePath contents:nil attributes:nil];
        BOOL result = [responseObject writeToFile:filePath options:(NSDataWritingAtomic) error:nil];
        if (result) {
            SuccessBlock(filePath);
        }else{
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"icon_wushuju" ofType:nil];
            SuccessBlock(filePath);
        }
        
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];
}
@end
