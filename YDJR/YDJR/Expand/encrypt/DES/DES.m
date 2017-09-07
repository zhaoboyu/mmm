//
//  DES.m
//  CTTX
//
//  Created by huangguangbao on 16/9/29.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "DES.h"

@implementation DES
#define DES_IV @"huangsuo"
//DES_IV 自己定义的一个字符串 八个字节 一定要是八个字节
-(Byte *) getIv{
    
    NSString *testString = DES_IV;
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    //    for(int i=0;i<[testData length];i++)
    //        printf("testByte = %d\n",testByte[i]);
    return (Byte *)[testData bytes];
}
//plainText需加密 字符串 key 定义好的 加密 解密 钥匙
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString*)key{
    
    Byte *iv=[self getIv];
    
    //    NSString *escape=[plainText stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    //    return escape;
    
    NSData* data=[plainText dataUsingEncoding: NSUTF8StringEncoding];
    
    NSUInteger bufferSize=([data length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
    
    char buffer[bufferSize];
    
    memset(buffer, 0,sizeof(buffer));
    
    size_t bufferNumBytes;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          
                                          kCCAlgorithmDES,
                                          
                                          kCCOptionPKCS7Padding,
                                          
                                          [key UTF8String],
                                          
                                          kCCKeySizeDES,
                                          
                                          iv   ,
                                          
                                          [data bytes],
                                          
                                          [data length],
                                          
                                          buffer,
                                          
                                          bufferSize,
                                          
                                          &bufferNumBytes);
    
    if (cryptStatus ==kCCSuccess) {
        
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)bufferNumBytes];
        
        return [ConverUtil parseByteArray2HexString:[data bytes] count:bufferNumBytes] ;
        //        NSLog(@"objccipherTextBytes:%@",[XYDES dataToHex:data]);
        //        ciphertext = [GTMBase64 stringByEncodingData:data];
        //        NSLog(@"objccipherTextBase64:%@",ciphertext);
    }
    
    return nil;
}

-(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key{
    
    Byte *iv=[self getIv];
    
    NSData* data = [ConverUtil parseHexToByteArray:cipherText];
    
    NSUInteger bufferSize=([data length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
    
    char buffer[bufferSize];
    
    memset(buffer, 0,sizeof(buffer));
    
    size_t bufferNumBytes;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          
                                          kCCAlgorithmDES,
                                          
                                          kCCOptionPKCS7Padding,
                                          
                                          [key UTF8String],
                                          
                                          kCCKeySizeDES,
                                          
                                          iv,
                                          
                                          [data bytes],
                                          
                                          [data length],
                                          
                                          buffer,
                                          
                                          bufferSize,
                                          
                                          &bufferNumBytes);
    
    NSString* plainText = nil;
    
    if (cryptStatus ==kCCSuccess) {
        
        NSData *plainData =[NSData dataWithBytes:buffer length:(NSUInteger)bufferNumBytes];
        
        plainText = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    }
    
    return plainText;
}

@end
