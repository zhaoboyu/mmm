//
//  NetworkRequest.m
//  CTTX
//
//  Created by 吕利峰 on 16/4/23.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "NetworkRequest.h"
#import "RSAEncryptor.h"
#import "NSString+AES256.h"
@interface NetworkRequest ()
/// 双向认证证书时的双向认证
@property (nonatomic, copy) NSString *cerFilePath;

/// 双向认证证书密码
@property (nonatomic,copy) NSString *cerFilePassword;
@property (nonatomic,strong)AFURLSessionManager *manager;
@property (nonatomic,copy)NetworkRequestSuccess successBlock;
@property (nonatomic,copy)NetworkRequestFailed failedBlock;

@property (nonatomic,copy)NSString *AES_Key;

@property (nonatomic,assign)BOOL isSendNotification;
@property (nonatomic,copy)NSString *noticeName;
@end

@implementation NetworkRequest
static NSString *randomIDStr= @"V2ymHFg03ehbqgZCaKO6jy";
// 本次上传标示字符串

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        //        configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        self.manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
        self.url=[NSString stringWithFormat:@"%@mobilecall_call",baseNetWorkURL];//上海测试服务器地址
        
        self.requestMethod = @"POST";
        self.sendFormat = FORMAT_NO;
        self.isRepeatRequest = NO;
        self.isDownFile = NO;
    }
    return self;
}
/**
 *	@brief	双向认证设置证书.
 *  证书为P12.
 *
 *	@param 	cerFilePath 	证书路径.
 *  @param  cerPassword     证书密码.
 */
- (void)setHttpsBidirectionalAuthCertificateFilePath:(NSString *)cerFilePath cerPassword:(NSString *)cerPassword
{
    self.cerFilePath = cerFilePath;
    self.cerFilePassword = cerPassword;
    if (self.cerFilePath) {
        // 准备：将证书的二进制读取，放入set中
        //        NSString *cerPath = [[NSBundle mainBundle] pathForResource:self.cerFilePath ofType:nil];
        //        NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
        //        NSSet *set = [[NSSet alloc] initWithObjects:cerData, nil];
        //        self.manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:set]; // 关键语句1
        //        self.manager.securityPolicy.allowInvalidCertificates = YES; // 关键语句2
    }
}
/**
 *	@brief	添加请求body参数.
 *
 *	@param 	parma 	参数名.
 *	@param 	value 	参数数据值.
 */
- (void)appendBodyParma:(NSString *)parma value:(id)value
{
    //    NSString *publicKeyPath = [[NSBundle mainBundle]pathForResource:@"public_key.der" ofType:nil];
    //    NSString *privatekeyPath = [[NSBundle mainBundle]pathForResource:@"private_key.p12" ofType:nil];
    //    value = [RSAEncryptor encryptString:value publicKeyWithContentsOfFile:publicKeyPath];
    //    NSString *jiemiStr = [RSAEncryptor decryptString:value privateKeyWithContentsOfFile:privatekeyPath password:@"agreeydjr"];
    if (!_bodyParams) {
        _bodyParams = [NSString stringWithFormat:@"%@=%@",parma,value];
    }else{
        _bodyParams = [_bodyParams stringByAppendingFormat:@"&%@=%@",parma,value];
    }
}
/**
 设置body参数
 
 @param parma body参数
 */
- (void)setParmaBodyWithParma:(NSMutableDictionary *)parma
{
    //    NSMutableDictionary *ReqInfo = [parma objectForKey:@"ReqInfo"];
    //    NSString *reqInfoStr = [Tool JSONString:ReqInfo];
    //
    //    NSString *cipherText = [reqInfoStr aes128_encrypt:self.AES_Key];
    //    NSLog(@"加密:%@",cipherText);
    //    NSString *mingwen = [reqInfoStr aes128_decrypt:self.AES_Key];
    //    NSLog(@"解密:%@",mingwen);
    //    [parma setObject:cipherText forKey:@"ReqInfo"];
    //
    //    NSMutableDictionary *SYS_HEAD = [parma objectForKey:@"SYS_HEAD"];
    //    NSString *publicKeyPath = [[NSBundle mainBundle]pathForResource:@"public_key.der" ofType:nil];
    //    NSString *rsa_aes_key = [RSAEncryptor encryptString:self.AES_Key publicKeyWithContentsOfFile:publicKeyPath];
    //    [SYS_HEAD setObject:rsa_aes_key forKey:@"rsa_aes_key"];
    //    [parma setObject:SYS_HEAD forKey:@"SYS_HEAD"];
    NSString *jsonStr = [Tool JSONString:parma];
    if (self.isRepeatRequest) {
        [Tool cacheRequestToDBWithBodyParmaValue:jsonStr isSendNotification:self.isSendNotification noticeName:self.noticeName requestMethod:self.requestMethod requestId:self.AES_Key];
    }
    [self appendBodyParma:@"msg" value:jsonStr];
    
}
/**
 设置是否需要发起通知
 
 @param isSendNotification yes:需要,no:不需要
 @param noticeName 通知名
 */
- (void)setIsSendNotification:(BOOL)isSendNotification noticeName:(NSString *)noticeName
{
    self.isSendNotification = isSendNotification;
    self.noticeName = noticeName;
}
#pragma mark - block机制支持
/**
 *	@brief	设置回调block
 *
 *	@param 	successBlock 	成功block
 *	@param 	failedBlock 	失败block
 */
- (void)requestWithSuccessBlock:(NetworkRequestSuccess)successBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    
    self.successBlock = successBlock;
    self.failedBlock = failedBlock;
    if (self.sendFormat == FORMAT_NO) {
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }else if (self.sendFormat == FORMAT_JSON){
        /*
         - `application/json`
         - `text/json`
         - `text/javascript`
         */
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }else if (self.sendFormat == FORMAT_XML){
        /*
         - `application/xml`
         - `text/xml`
         */
        self.manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    }
    NSLog(@"%@",self.bodyParams);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:self.url] cachePolicy:(NSURLRequestReloadIgnoringLocalAndRemoteCacheData) timeoutInterval:120];
    request.HTTPMethod = self.requestMethod;
    NSArray *keyArr = [self.headParms allKeys];
    if ([keyArr count] > 0) {
        for (NSString *key in keyArr) {
            [request setValue:[self.headParms objectForKey:key] forHTTPHeaderField:key];
        }
    }
    
    if ([self.requestMethod isEqualToString:@"GET"]) {
        self.url = [self.url stringByAppendingString:[NSString stringWithFormat:@"?%@",self.bodyParams]];
    }else{
        self.bodyParams = [self stringEncodingWithStr:self.bodyParams];
        [request setHTTPBody:[self.bodyParams dataUsingEncoding:NSUTF8StringEncoding]];
    }
    //文件上传数据
    if (self.fileData.length > 0) {
        // 3> 设置Content-Length
        NSString *strLength = [NSString stringWithFormat:@"%ld", (long)self.fileData.length];
        [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
        
        // 4> 设置Content-Type
        NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
        [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
        // dataM出了作用域就会被释放,因此不用copy
        request.HTTPBody = self.fileData;
    }
    
    if (self.isHttps) {
        self.manager.securityPolicy.validatesDomainName = NO;
        self.manager.securityPolicy.allowInvalidCertificates = YES;
    }
    //    NSLog(@"%@",request.allHTTPHeaderFields );
    //     NSLog(@"huangguangbao:%@",self.bodyParams);
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        //        NSLog(@"request:%@",request);
        //        NSLog(@"response------------------------llf:%@",response);
        //        [self saveCookieTolocal];
        
        NSLog(@"responseObject------------------LLF-测试查看json前的返回报文-LLF------------------------%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if (error) {
            //            NSLog(@"%@ %@", response, responseObject);
            NSLog(@"Error: %@", error.description);
            
            failedBlock(error);
        } else {
            //            NSLog(@"%@ %@", response, responseObject);
            //            NSLog(@"%@",_bodyParams);
            NSError *errorDic = nil;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&errorDic];
//            NSLog(@"%@",dic);
            if (self.isRepeatRequest) {
                [Tool removecacheRequestWithRequestId:self.AES_Key];
            }
            if (self.isDownFile) {
                successBlock(responseObject);
            }else{
                if (!errorDic) {
                    successBlock(responseObject);
                }else{
                    failedBlock(errorDic);
                }
            }
            
            
        }
    }];
    [dataTask resume];
    
}


/**
 文件上传

 @param pamart 文件上传参数字典
 @param filePathArr 文件路径数组
 @param successBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)requestUploadFileWithPamart:(NSDictionary *)pamart filePathArr:(NSArray *)filePathArr SuccessBlock:(void (^)(id  _Nullable responseObject))successBlock failedBlock:(NetworkRequestFailed)failedBlock
{
    //AFN3.0+基于封住HTPPSession的句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置请求头
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"charset=utf-8", @"text/plain", @"multipart/form-data", nil];
    //封装请求参数
    NSString *jsonStr = [Tool JSONString:pamart];
    if (self.isRepeatRequest) {
        [Tool cacheRequestToDBWithBodyParmaValue:jsonStr isSendNotification:self.isSendNotification noticeName:self.noticeName requestMethod:self.requestMethod requestId:self.AES_Key];
    }
    NSDictionary *dict = @{@"msg":jsonStr};
    NSString *uploadUrl = [NSString stringWithFormat:@"%@YdImageAction_uploadImg",baseNetWorkURL];
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:uploadUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString *filePath in filePathArr) {
            NSArray *nameArr = [filePath componentsSeparatedByString:@"/"];
            NSString *fileName = [nameArr lastObject];
//            UIImage *image =[UIImage imageNamed:fileName];
//            NSData *data = UIImagePNGRepresentation(image);
            NSData *data = [NSData dataWithContentsOfFile:filePath options:0 error:nil];
            
            //上传
            /*
             此方法参数
             1. 要上传的[二进制数据]
             2. 对应网站上[upload.php中]处理文件的[字段"file"]
             3. 要保存在服务器上的[文件名]
             4. 上传文件的[mimeType]
             */
            [formData appendPartWithFileData:data name:@"uploadFile" fileName:fileName mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {

        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"responseObject------------------LLF-测试查看json前的返回报文-LLF------------------------%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
//        NSError *errorDic = nil;
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&errorDic];
//        NSLog(@"%@",dic);
        if (self.isRepeatRequest) {
            [Tool removecacheRequestWithRequestId:self.AES_Key];
        }
        NSString *returnMessage = [[responseObject objectForKey:@"SYS_HEAD"] objectForKey:@"ReturnMessage"];
        NSLog(@"%@",[self decodeString:returnMessage]);
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failedBlock(error);
    }];
}
//NSString *encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlString, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8);
- (NSString *)stringEncodingWithStr:(NSString *)str
{
//    NSString *encodedString = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)str,NULL,(CFStringRef)@"!*'();:@&=+ $,/?%#[]",kCFStringEncodingUTF8));
//    return outputStr;
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
//    encodedString = [encodedString stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
    return encodedString;
}
/**
 *  把cookie保存到本地
 */
- (void)saveCookieTolocal
{
    NSMutableArray *cookieArray = [[NSMutableArray alloc] init];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [cookieArray addObject:cookie.name];
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        [cookieProperties setObject:cookie.name forKey:NSHTTPCookieName];
        [cookieProperties setObject:cookie.value forKey:NSHTTPCookieValue];
        [cookieProperties setObject:cookie.domain forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:cookie.path forKey:NSHTTPCookiePath];
        [cookieProperties setObject:[NSNumber numberWithInteger:cookie.version] forKey:NSHTTPCookieVersion];
        
        [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
        
        [[NSUserDefaults standardUserDefaults] setValue:cookieProperties forKey:cookie.name];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:cookieArray forKey:@"cookieArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark 属性的get/set方法
- (NSString *)AES_Key
{
    if (!_AES_Key) {
        _AES_Key = [NSString stringWithFormat:@"%@-%d",[Tool getTimeStr],arc4random() % 10000];
    }
    return _AES_Key;
}
- (NSString *)decodeString:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}
@end
