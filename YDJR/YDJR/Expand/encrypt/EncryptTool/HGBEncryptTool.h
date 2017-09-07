//
//  HGBEncryptTool.h
//  CTTX
//
//  Created by huangguangbao on 16/11/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGBEncryptTool : NSObject
#pragma mark RSA
//rsa加密
+(NSString *)encryptStringWithRSA:(NSString *)string;
//rsa解密
+(NSString *)decryptStringStringWithRSA:(NSString *)string;
@end
