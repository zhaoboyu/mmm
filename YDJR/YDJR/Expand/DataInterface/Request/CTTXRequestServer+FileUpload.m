
//
//  CTTXRequestServer+FileUpload.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/30.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+FileUpload.h"

@implementation CTTXRequestServer (FileUpload)
/**
 *  远程上传图片
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)fileUploadWithFileModel:(UploadFileModel *)fileModel WithSuccessBlock:(void (^)(NSString *ReturnCode))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:@"04" forKey:@"SystemChannelFlag"];//平台标志
    [reqinfoDic setObject:@"" forKey:@"Ids"];
    [reqinfoDic setObject:@"contract" forKey:@"ObjectType"];
    [reqinfoDic setObject:fileModel.ObjectNo forKey:@"ObjectNo"];
    [reqinfoDic setObject:fileModel.TypeNo forKey:@"TypeNo"];
    UIImage *image = [UIImage imageNamed:fileModel.filePath];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    NSString *dataStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    NSString *images = [NSString stringWithFormat:@"%@^%@^local@jpg|!||!|!",dataStr,fileModel.filename];
    [reqinfoDic setObject:images forKey:@"Images"];
//    UserDataModel *usermodel = [UserDataModel sharedUserDataModel];
    [reqinfoDic setObject:@"Interface" forKey:@"UserId"];//上传人的用户名---请填写Interface
    [reqinfoDic setObject:@"Interface04" forKey:@"OrgId"];//上传人的机构名---请填写Interface+平台标示（如聚钱填写Interface01）
    [reqinfoDic setObject:@"远程图片上传" forKey:@"Remark"];//备注
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.b001.02" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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
        NSString *result = [dic objectForKey:@"ReturnCode"];
        SuccessBlock(result);
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];

}

/**
 *  上传图片
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)imageUploadWithFileModel:(UploadFileModel *)fileModel WithSuccessBlock:(void (^)(BOOL ReturnCode))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    
    [reqinfoDic setObject:fileModel.opinionId forKey:@"opinionId"];
    [reqinfoDic setObject:fileModel.filename forKey:@"fileName"];
    UIImage *image = [UIImage imageNamed:fileModel.filePath];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSString *dataStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    [reqinfoDic setObject:dataStr forKey:@"fileData"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.f001.02" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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
        BOOL result = (BOOL)[[dic objectForKey:@"SYS_HEAD"] objectForKey:@"result"];
        SuccessBlock(result);
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];
    
}
/**
 *  达分期上传图片
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)uploadImageFileWithFileModel:(UploadFileModel *)fileModel WithSuccessBlock:(void (^)(SysHeadModel *sysHeadModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    
    [reqinfoDic setObject:fileModel.businessID forKey:@"businessID"];
    [reqinfoDic setObject:fileModel.filename forKey:@"imageName"];
    [reqinfoDic setObject:fileModel.TypeNo forKey:@"typeNo"];
    [reqinfoDic setObject:fileModel.operationType forKey:@"operationType"];
    [reqinfoDic setObject:fileModel.productType forKey:@"productType"];
    UIImage *image = [UIImage imageNamed:fileModel.filePath];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    NSString *dataStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    [reqinfoDic setObject:dataStr forKey:@"images"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.x001.05" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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
        NSDictionary *SYS_HEAD = [dic objectForKey:@"SYS_HEAD"];
        SysHeadModel *sysHeadModel = [SysHeadModel yy_modelWithJSON:SYS_HEAD];
        SuccessBlock(sysHeadModel);
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];
}
/**
 达分期订单状态变更接口

 @param businessID 达分期订单号
 @param operaTionType 操作类型 
 01:一次影像资料采集
 02:补件
 03:二次进件
 04:补保单
 17:取消申请
 @param productType 产品类型
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)upDFQStateWithBusinessID:(NSString *)businessID operaTionType:(NSString *)operaTionType productType:(NSString *)productType WithSuccessBlock:(void (^)(NSString *ReturnCode,NSString *ReturnMessage))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    
    [reqinfoDic setObject:businessID forKey:@"businessID"];
    [reqinfoDic setObject:operaTionType forKey:@"operationType"];
    [reqinfoDic setObject:productType forKey:@"productType"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.x001.06" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
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
        NSString *ReturnCode = [[dic objectForKey:@"SYS_HEAD"] objectForKey:@"ReturnCode"];
        NSString *ReturnMessage = [[dic objectForKey:@"SYS_HEAD"] objectForKey:@"ReturnMessage"];
        SuccessBlock(ReturnCode,ReturnMessage);
    } failedBlock:^(NSError *error) {
        
        failedBlock(error);
    }];
}
@end
