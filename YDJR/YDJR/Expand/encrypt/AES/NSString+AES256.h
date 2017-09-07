//
//  NSString+AES256.h
//  YDJR
//
//  Created by 吕利峰 on 2017/1/20.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "NSData+Encryption.h"
@interface NSString (AES256)
-(NSString *)aes256_encrypt:(NSString *)key;
-(NSString *)aes256_decrypt:(NSString *)key;

-(NSString *)aes128_encrypt:(NSString *)key;
-(NSString *)aes128_decrypt:(NSString *)key;
@end
