//
//  NSString+Encryption.m
//  YDJR
//
//  Created by 吕利峰 on 16/11/21.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "NSString+Encryption.h"
#import "RSAEncryptor.h"
#define saltKey @"zantongyongdayidongzanye"
@implementation NSString (Encryption)
#pragma mark - 32位 大写
- (NSString *)MD5ForUpper32Bate{
    
    //要进行UTF8的转码
    const char *input = self.UTF8String;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}
/**
 md5加密
 
 @return 返回密文
 */
- (NSString *)md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}
#pragma mark - Helpers 
- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length {
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}
/**
 *  MD5($pass.$salt)
 *
 *
 *  @return 加密后的密文
 */
- (NSString *)MD5Salt
{
    // 撒盐：随机地往明文中插入任意字符串
    NSString *salt = [self stringByAppendingString:saltKey];
    return [salt md5String];
}

/**
 *  MD5(MD5($pass))
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
- (NSString *)doubleMD5:(NSString *)text
{
    return [[text md5String] md5String];
}

/**
 *  先加密，后乱序
 *
 *  @param text 明文
 *
 *  @return 加密后的密文
 */
- (NSString *)MD5Reorder:(NSString *)text
{
    NSString *pwd = [text md5String];
    
    // 加密后pwd == 3f853778a951fd2cdf34dfd16504c5d8
    NSString *prefix = [pwd substringFromIndex:2];
    NSString *subfix = [pwd substringToIndex:2];
    
    // 乱序后 result == 853778a951fd2cdf34dfd16504c5d83f
    NSString *result = [prefix stringByAppendingString:subfix];
    
    NSLog(@"\ntext=%@\npwd=%@\nresult=%@", text, pwd, result);
    
    return result;
}

/**
 *  '.der'格式的公钥文件路径
 *
 *  @return 加密后的密文
 */
- (NSString *)encryptionWithRSA
{
    NSString *publicKeyPath = [[NSBundle mainBundle]pathForResource:@"public_key.der" ofType:nil];
    NSString *rsaStr = [RSAEncryptor encryptString:self publicKeyWithContentsOfFile:publicKeyPath];
    return rsaStr;
}
@end
