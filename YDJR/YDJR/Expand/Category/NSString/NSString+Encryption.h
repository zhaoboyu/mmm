//
//  NSString+Encryption.h
//  YDJR
//
//  Created by 吕利峰 on 16/11/21.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 加密分类
 */
@interface NSString (Encryption)
/**
 *  MD5加密, 32位 大写
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)MD5ForUpper32Bate;
/**
 md5加密

 @return 返回密文
 */
- (NSString *)md5String;
/**
 *  MD5($pass.$salt)
 *
 *  @return 加密后的密文
 */
- (NSString *)MD5Salt;

/**
 *  MD5(MD5($pass))
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
- (NSString *)doubleMD5:(NSString *)text;

/**
 *  先加密，后乱序
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
- (NSString *)MD5Reorder:(NSString *)text;

/**
 *  '.der'格式的公钥文件路径
 *
 *  @return 加密后的密文
 */
- (NSString *)encryptionWithRSA;
@end
