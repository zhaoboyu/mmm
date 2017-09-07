//
//  HGBEncryptTool.m
//  CTTX
//
//  Created by huangguangbao on 16/11/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "HGBEncryptTool.h"
#import "RSAEncryptor.h"

@implementation HGBEncryptTool
#pragma mark RSA
//rsa加密
+(NSString *)encryptStringWithRSA:(NSString *)string{
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
  NSString *encryptStr= [RSAEncryptor encryptString:string publicKeyWithContentsOfFile:publicKeyPath];
    return encryptStr;
}
//rsa解密
+(NSString *)decryptStringStringWithRSA:(NSString *)string{
     NSString* privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    NSString* decryptString = [RSAEncryptor decryptString:string privateKeyWithContentsOfFile:privateKeyPath password:@"agree123456"];
    return decryptString;
}
@end
