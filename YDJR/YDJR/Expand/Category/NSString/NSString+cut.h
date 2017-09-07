//
//  NSString+cut.h
//  YDJR
//
//  Created by 吕利峰 on 16/11/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (cut)
/**
 *  添加金额分割符
 */
- (NSString *)cut;

/**
 若是数字包含.号 保留后两位

 @return 保留后两位的数字
 */
-(NSString *)cutOutStringContainsDot;
-(NSString *)cutOutStringContainsDotSupplement;
/**
 去除带有小数点.后面的0
 
 @return 去掉0后的结果
 */
- (NSString *)cutZeroFromString;


//计算字符串的长度和高度
- (CGSize)labelAutoCalculateRectWith:(NSString *)text FontSize:(CGFloat)fontSize;
@end
