//
//  DES.h
//  CTTX
//
//  Created by huangguangbao on 16/9/29.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import "ConverUtil.h"
//#import "Constants.h"

@interface DES : NSObject
//加密
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString*)key;
//解密
-(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
@end
