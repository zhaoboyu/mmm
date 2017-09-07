//
//  UploadFileRequest.h
//  CTTX
//
//  Created by 吕利峰 on 16/5/18.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UploadFileDelegate <NSObject>
//传值
- (void)passValue:(NSDictionary *)aString;
@end
@interface UploadFileRequest : NSObject
@property(nonatomic,assign)id<UploadFileDelegate> delegate;
/**
 *	@brief	开始上传一个文件
 *
 *	@param 	fileName 	文件名字
 *	@param 	image 	图片
 */
- (void)uploadFileWithFileName:(NSString *)fileName image:(UIImage *)image SuccessBlock:(void (^)(NSString *imageUrl))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;

/**
 *  下载图片
 *
 *  @param url          图片下载地址
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)downloadImageWithUrl:(NSString *)url SuccessBlock:(void (^)(UIImage *image))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
/**
 *  下载文件
 *
 *  @param url          图片下载地址
 *  @param SuccessBlock 成功返回
 *  @param failedBlock  失败返回
 */
- (void)downloadFileWithUrl:(NSString *)url SuccessBlock:(void (^)(NSString *filePath))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;

- (void)uploadFileDataWithFilePath:(NSString *)filePath SuccessBlock:(void (^)(NSString *imageUrl))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
- (void)downloadFileWithPamart:(NSString *)pamart SuccessBlock:(void (^)(NSString *url))SuccessBlock failedBlock:(NetworkRequestFailed)failedBlock;
@end
