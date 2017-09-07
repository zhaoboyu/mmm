//
//  UploadFileRequest.m
//  CTTX
//
//  Created by 吕利峰 on 16/5/18.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "UploadFileRequest.h"
#define URL @"https://ctkapp.icbc-axa.com/ecip/TbCfCImageUploadServlet.do"//上海文件上传地址
#import "NetworkRequest.h"

@implementation UploadFileRequest
// 拼接字符串
static NSString *boundaryStr = @"--";
// 分隔字符串
static NSString *randomIDStr= @"V2ymHFg03ehbqgZCaKO6jy";
// 本次上传标示字符串
static NSString *uploadID= @"uploadFile";
// 上传(php)脚本中，接收文件字段

/**
 *	@brief	开始上传一个文件
 *
 *	@param 	fileName 	文件名字
 *	@param 	image 	图片
 */
- (void)uploadFileWithFileName:(NSString *)fileName image:(UIImage *)image SuccessBlock:(void (^)(NSString *imageUrl))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    
    NSData *fileData = UIImageJPEGRepresentation(image, 0.1f);
    while ((fileData.length / 1024) > 1000) {
        UIImage *fileImage = [UIImage imageWithData:fileData];
        fileData = UIImageJPEGRepresentation(fileImage, 0.1);
    }
    
    NSMutableDictionary *imageDic = [NSMutableDictionary dictionary];
    [imageDic setValue:fileData forKey:fileName];
    NSMutableDictionary *pramDic = [NSMutableDictionary dictionary];
    [pramDic setValue:@"测试文章标题" forKey:@"title"];
    [pramDic setValue:@"测试的文章内容" forKey:@"content"];
    
    
    NSMutableData *dataM = [NSMutableData data];
    
    //    [dataM appendData:[boundaryStr dataUsingEncoding:NSUTF8StringEncoding]];
    for (NSString *name  in [imageDic allKeys]) {
        NSString *topStr = [self topStringWithMimeType:@"image/png" uploadFile:name];
        [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
        [dataM appendData:[imageDic valueForKey:name]];
    }
    
    for (NSString *name  in [pramDic allKeys]) {
        NSString *bottomStr = [self bottomString:name value:[pramDic valueForKey:name]];
        [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [dataM appendData:[[NSString stringWithFormat:@"%@%@--\r\n", boundaryStr, randomIDStr] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    NetworkRequest *request = [[NetworkRequest alloc]init];
    // 2> 设置Request的头属性
    request.isHttps=YES;
    request.requestMethod = @"POST";
    request.fileData=dataM;
    if((!fileData)||fileName.length==0||fileName==nil){
        failedBlock(nil);
        return;
    }
    
    
    request.url = URL;
    request.isHttps = YES;
    
    request.requestMethod = @"POST";
    [request requestWithSuccessBlock:^(id responseObject) {
        NSError *error = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"huang:%@",dic);
        //保存图片到本地
        NSString *imageurl = [dic objectForKey:@"url"];
        if(imageurl){
            NSString *imagePath = [Tool getImagePathWithImageURL:imageurl];
            //创建一个文件
            NSFileManager *fileManage = [NSFileManager defaultManager];
            [fileManage createFileAtPath:imagePath contents:nil attributes:nil];
            [fileData writeToFile:imagePath options:(NSDataWritingAtomic) error:nil];
            SuccessBlock(imageurl);
        }else{
            failedBlock(error);
        }
        
    } failedBlock:^(NSError *error) {
        //        NSLog(@"%@",error.description);
        failedBlock(error);
        
    }];
}
/**
 *  下载图片
 *
 *  @param url          图片下载地址
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)downloadImageWithUrl:(NSString *)url SuccessBlock:(void (^)(UIImage *image))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NetworkRequest *request = [[NetworkRequest alloc]init];
    request.url = [url stringByAppendingFormat:@"?time=%@",[Tool getTimeStr]];
    //    NSLog(@"%@",request.url);
    request.isHttps = YES;
    request.requestMethod = @"GET";
    [request requestWithSuccessBlock:^(id responseObject) {
        
        NSString *imagePath = [Tool getImagePathWithImageURL:url];
        //创建一个文件
        NSFileManager *fileManage = [NSFileManager defaultManager];
        [fileManage createFileAtPath:imagePath contents:nil attributes:nil];
        [responseObject writeToFile:imagePath options:(NSDataWritingAtomic) error:nil];
        UIImage *image = [UIImage imageWithData:responseObject];
        SuccessBlock(image);
    } failedBlock:^(NSError *error) {
        //        NSLog(@"%@",error.description);
        failedBlock(error);
        
    }];
}
/**
 *  下载文件
 *
 *  @param url          图片下载地址
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)downloadFileWithUrl:(NSString *)url SuccessBlock:(void (^)(NSString *filePath))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NetworkRequest *request = [[NetworkRequest alloc]init];
    request.url = [url stringByAppendingFormat:@"?time=%@",[Tool getTimeStr]];
    request.isHttps = YES;
    request.requestMethod = @"GET";
    [request requestWithSuccessBlock:^(id responseObject) {
        NSString *filePath = [Tool getImagePathWithImageURL:url];
        //创建一个文件
        NSFileManager *fileManage = [NSFileManager defaultManager];
        [fileManage createFileAtPath:filePath contents:nil attributes:nil];
        [responseObject writeToFile:filePath options:(NSDataWritingAtomic) error:nil];
        SuccessBlock(filePath);
    } failedBlock:^(NSError *error) {
        //        NSLog(@"%@",error.description);
        failedBlock(error);
        
    }];
}

- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"\r\n%@%@\r\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", uploadID,uploadFile];
    [strM appendFormat:@"Content-Type: %@\r\n\r\n", mimeType];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

- (NSString *)bottomString:(NSString *)key value:(NSString *)value
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"\r\n%@%@\r\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
    [strM appendFormat:@"%@\r\n",value];
    
    
    NSLog(@"%@", strM);
    return [strM copy];
}
- (void)uploadFileDataWithFilePath:(NSString *)filePath SuccessBlock:(void (^)(NSString *imageUrl))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    //测试用：66df1f53-cc63-44d4-afc3-f8bb3511d030
    [reqinfoDic setObject:@"icon_wushuju" forKey:@"headImageName"];
    [reqinfoDic setObject:@"ydtest1" forKey:@"userId"];
    [dataDic setObject:reqinfoDic forKey:@"ReqInfo"];
    [dataDic setObject:[Tool backSysHeadDicWithTransServiceCode:@"agree.ydjr.up.01" Contrast:reqinfoDic] forKey:@"SYS_HEAD"];
    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"DFQOL201700425-1.pdf" ofType:nil];
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"DFQOL201700425-2.pdf" ofType:nil];

    [[[NetworkRequest alloc] init] requestUploadFileWithPamart:dataDic filePathArr:@[filePath1,filePath2] SuccessBlock:^(id responseObject) {
        
    } failedBlock:^(NSError *error) {
        
    }];
}

- (void)downloadFileWithPamart:(NSString *)pamart SuccessBlock:(void (^)(NSString *url))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //ReqInfo
    NSMutableDictionary *reqinfoDic = [NSMutableDictionary dictionary];
    //测试用：66df1f53-cc63-44d4-afc3-f8bb3511d030
    [reqinfoDic setObject:@"DFQOL201700425-2.pdf" forKey:@"fileName"];
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
        NSString *filePath = [Tool getImagePathWithImageURL:@"DFQOL201700425-2.pdf"];
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
