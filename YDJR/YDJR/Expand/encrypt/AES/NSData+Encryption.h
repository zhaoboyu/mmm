//
//  NSData+Encryption.h
//  CTTX
//
//  Created by huangguangbao on 16/10/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
@interface NSData (Encryption)
- (NSData *)AES256ParmEncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256ParmDecryptWithKey:(NSString *)key;   //解密

- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv;

//加密

- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;

//解密

- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;
@end
