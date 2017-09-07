//
//  ScanResult.m
//  二维码扫描与生成模拟
//
//  Created by 吕利峰 on 16/4/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "ScanResult.h"

@implementation ScanResult
- (instancetype)initWithScanString:(NSString*)str imgScan:(UIImage*)img barCodeType:(NSString*)type
{
    if (self = [super init]) {
        
        self.strScanned = str;
        self.imgScanned = img;
        self.strBarCodeType = type;
    }
    
    return self;
}

@end
