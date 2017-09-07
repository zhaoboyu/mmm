//
//  UIWebView+ToFile.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (ToFile)
- (UIImage *)imageRepresentation;

- (void)PDFDataWithFileName:(NSString *)fileName SuccessBlock:(void (^)(void))SuccessBlock;

- (void)PDFDataWithFileName:(NSString *)fileName;
@end
