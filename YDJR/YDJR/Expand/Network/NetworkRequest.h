//
//  NetworkRequest.h
//  CTTX
//
//  Created by 吕利峰 on 16/4/23.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//
/// 客户端与服务器沟通时用到的类.
#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum
{
    FORMAT_NO,
    FORMAT_JSON,        //!< json格式报文 /
    FORMAT_XML,         //!< xml格式报文 */
    
}DATA_SEND_FORMAT;
/**
 *	@brief	请求成功时调用block.
 *
 *	@param 	responseObject 	请求成功后生成的数据对象.
 */

typedef void (^NetworkRequestSuccess)(id responseObject);

/**
 *	@brief	请求失败时调用的block.
 */
typedef void (^NetworkRequestFailed)(NSError *error);
@interface NetworkRequest : NSObject
@property (nonatomic, copy) NSString      *url;
/**
 *	@brief	是否需要https.
 */
@property (nonatomic,assign) BOOL isHttps;


/**
 *  请求方法 默认Post
 */
@property (nonatomic , assign)NSString *requestMethod;
/**
 *	@brief	数据报文格式(默认FORMAT_NO).
 */
@property (nonatomic, assign) DATA_SEND_FORMAT  sendFormat;

@property (nonatomic,strong)NSString *bodyParams;
/**
 *  请求头设置
 */
@property (nonatomic,strong)NSMutableDictionary *headParms;
/**
 *  文件上传数据
 */
@property (nonatomic,strong)NSData *fileData;

/**
 是否支持失败后重新发起请求
 */
@property (nonatomic,assign)BOOL isRepeatRequest;

/**
 是否下载文件
 */
@property (nonatomic,assign)BOOL isDownFile;
/**
 设置是否需要发起通知
 
 @param isSendNotification yes:需要,no:不需要
 @param noticeName 通知名
 */
- (void)setIsSendNotification:(BOOL)isSendNotification noticeName:(NSString *)noticeName;
/**
 *	@brief	双向认证设置证书.
 *  证书为P12.
 *
 *	@param 	cerFilePath 	证书路径.
 *  @param  cerPassword     证书密码.
 */
- (void)setHttpsBidirectionalAuthCertificateFilePath:(NSString *)cerFilePath cerPassword:(NSString *)cerPassword;

/**
 *	@brief	添加请求body参数.
 *
 *	@param 	parma 	参数名.
 *	@param 	value 	参数数据值.
 */
- (void)appendBodyParma:(NSString *)parma value:(id)value;
#pragma mark - block机制支持
/**
 *	@brief	设置回调block
 *
 *	@param 	successBlock 	成功block
 *	@param 	failedBlock 	失败block
 */
- (void)requestWithSuccessBlock:(NetworkRequestSuccess)successBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 文件上传
 
 @param pamart 文件上传参数字典
 @param filePathArr 文件路径数组
 @param successBlock 成功返回
 @param failedBlock 失败返回
 */
- (void)requestUploadFileWithPamart:(NSDictionary *)pamart filePathArr:(NSArray *)filePathArr SuccessBlock:(void (^)(id  _Nullable responseObject))successBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 设置body参数
 
 @param parma body参数
 */
- (void)setParmaBodyWithParma:(NSMutableDictionary *)parma;
@end
