//
//  UploadFileModel.m
//  CTTX
//
//  Created by 吕利峰 on 16/5/18.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "UploadFileModel.h"

@implementation UploadFileModel
- (void)setFilePath:(NSString *)filePath
{
    if (!_filePath) {
        _filePath = filePath;
        NSArray *nameArr = [_filePath componentsSeparatedByString:@"/"];
        _filename = [nameArr lastObject];
    }
}
@end
