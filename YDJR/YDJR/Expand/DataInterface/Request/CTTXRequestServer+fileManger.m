//
//  CTTXRequestServer+fileManger.m
//  YDJR
//
//  Created by 吕利峰 on 2017/6/12.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "CTTXRequestServer+fileManger.h"
#import "UploadFileModel.h"
@implementation CTTXRequestServer (fileManger)

/**
 上传用户头像

 @param filePath 头像路径
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)uploadFileHeadImageWithFilePath:(NSString *)filePath SuccessBlock:(void (^)(BOOL result))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    NSString *userId = [UserDataModel sharedUserDataModel].operatorCode;
    [reqinfoDic setObject:userId forKey:@"userId"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.up.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    [[[NetworkRequest alloc] init] requestUploadFileWithPamart:dataDic filePathArr:@[filePath] SuccessBlock:^(id responseObject) {
        if ([[[responseObject objectForKey:@"SYS_HEAD"] objectForKey:@"ReturnCode"] isEqualToString:@"00"]) {
            [UserDataModel sharedUserDataModel].headpic = [[responseObject objectForKey:@"RespInfo"]objectForKey:@"headpic"];
            NSDictionary *userDic = [[UserDataModel sharedUserDataModel] yy_modelToJSONObject];
            [Tool saveUserDicKeyChainWithUserDic:userDic userId:[UserDataModel sharedUserDataModel].userName];
            
            SuccessBlock(YES);
        }else{
            SuccessBlock(NO);
        }
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}
- (void)downloadFileWithPamart:(NSString *)pamart SuccessBlock:(void (^)(UIImage *headImage))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    [reqinfoDic setObject:@"10.jpg" forKey:@"fileName"];
    [reqinfoDic setObject:@"ydtest1" forKey:@"userId"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.dw.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    //    NSString *jsonStr = [Tool JSONString:dataDic];
    
    NetworkRequest *request = [[NetworkRequest alloc]init];
    request.url = [NSString stringWithFormat:@"%@YdImageAction_downLoadImg",baseNetWorkURL];
    [request setParmaBodyWithParma:dataDic];
    request.requestMethod = @"POST";
    request.isDownFile = YES;
    
    [request requestWithSuccessBlock:^(id responseObject) {
        NSString *filePath = [Tool getImagePathWithImageURL:@"10.jpg"];
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

/**
 达分期上传合同

 @param param 参数对象
 @param loanContractNoPath 借款合同地址
 @param commissionContractNoPath 委托合同地址
 @param SuccessBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)uploadContractWithRequestParam:(NSDictionary *)param loanContractNoPath:(NSString *)loanContractNoPath commissionContractNoPath:(NSString *)commissionContractNoPath SuccessBlock:(void (^)(NSDictionary *responseDict))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setObject:param forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.up.03" Contrast:param] forKey:@"SYS_HEAD"];
    [[[NetworkRequest alloc] init] requestUploadFileWithPamart:dataDic filePathArr:@[loanContractNoPath,commissionContractNoPath] SuccessBlock:^(id responseObject) {
        SuccessBlock(responseObject);
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}

/**
 *  意见反馈上传图片
 *
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)fileUploadOpinionIdWithFileModel:(UploadFileModel *)fileModel WithSuccessBlock:(void (^)(BOOL ReturnCode))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    
    [reqinfoDic setObject:fileModel.opinionId forKey:@"opinionId"];
    [reqinfoDic setObject:fileModel.filename forKey:@"fileName"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.up.02" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    [[[NetworkRequest alloc] init] requestUploadFileWithPamart:dataDic filePathArr:@[fileModel.filePath] SuccessBlock:^(id responseObject) {
        if ([[[responseObject objectForKey:@"SYS_HEAD"] objectForKey:@"ReturnCode"] isEqualToString:@"00"]) {
            SuccessBlock(YES);
        }else{
            SuccessBlock(NO);
        }
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
- (void)fileUploadImageFileWithFileModel:(UploadFileModel *)fileModel WithSuccessBlock:(void (^)(SysHeadModel *sysHeadModel))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
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
//    NSFileManager *fileManage = [NSFileManager defaultManager];
//    [fileManage createFileAtPath:imagePath contents:nil attributes:nil];
    
    [imageData writeToFile:fileModel.filePath options:(NSDataWritingAtomic) error:nil];
//    NSString *dataStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
//    [reqinfoDic setObject:dataStr forKey:@"images"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.up.04" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    [[[NetworkRequest alloc] init] requestUploadFileWithPamart:dataDic filePathArr:@[fileModel.filePath] SuccessBlock:^(id responseObject) {
        NSDictionary *SYS_HEAD = [responseObject objectForKey:@"SYS_HEAD"];
        SysHeadModel *sysHeadModel = [SysHeadModel yy_modelWithJSON:SYS_HEAD];
        SuccessBlock(sysHeadModel);
    } failedBlock:^(NSError *error) {
        failedBlock(error);
    }];
}
@end
