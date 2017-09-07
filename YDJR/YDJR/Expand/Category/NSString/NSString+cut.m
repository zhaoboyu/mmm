//
//  NSString+cut.m
//  YDJR
//
//  Created by 吕利峰 on 16/11/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "NSString+cut.h"

@implementation NSString (cut)
/**
 *  添加金额分割符
 */
- (NSString *)cut
{
    NSArray *strArr = [self componentsSeparatedByString:@"."];
    NSString *str;
    NSString *str1;
    if (strArr.count > 1) {
        str = strArr[0];
        str1 = strArr[1];
        
    }else if (strArr.count > 0){
        str = strArr[0];
    }
    NSMutableString *tempStr = [[NSMutableString alloc]initWithString:str];
    NSInteger j = 0;
    for (NSInteger i = str.length - 1; i >= 0; i--) {
        if ((j % 3 == 2) && !(i == 0)) {
            [tempStr insertString:@"," atIndex:i];
        }
        j++;
    }
    NSString *result;
    if (str1) {
       result = [tempStr stringByAppendingFormat:@".%@",str1];
    }else{
        result = tempStr;
    }
//    NSLog(@"%@",result);
    return result;
}

/**
 若是数字包含.号 保留后两位
 
 @return 保留后两位的数字
 */
-(NSString *)cutOutStringContainsDot
{
	if ([self containsString:@"."]) {
		NSRange dotRange = [self rangeOfString:@"."];
		NSString *tempString = [self substringFromIndex:dotRange.location];
		if (tempString.length > 2) {
			return [self substringToIndex:dotRange.location];
		}else{
			return self;
		}
	}else{
		return self;
	}
}

-(NSString *)cutOutStringContainsDotSupplement
{
	if ([self containsString:@"."]) {
		NSRange dotRange = [self rangeOfString:@"."];
		NSString *tempString = [self substringFromIndex:dotRange.location + 1];
		if (tempString.length > 2) {
			return [self substringToIndex:dotRange.location + 3];
		}else{
			return self;
		}
	}else{
		return self;
	}
}

/**
 去除带有小数点.后面的0

 @return 去掉0后的结果
 */
- (NSString *)cutZeroFromString
{
    if ([self containsString:@"."]) {
        NSRange dotRange = [self rangeOfString:@"."];
        NSString *tempString = [self substringFromIndex:dotRange.location + 1];
        NSString *firstStr = [self substringToIndex:dotRange.location];
        NSInteger m = -1;
        for (NSInteger i = tempString.length - 1; i >= 0; i--) {
            NSString *lastStr = [tempString substringWithRange:NSMakeRange(i, 1)];
            if (![lastStr isEqualToString:@"0"]) {
                m = i;
                break;
            }
            
        }
        NSLog(@"%ld",m);
        if ( m != -1) {
            NSString *lastTempStr = [tempString substringToIndex:m + 1];
            NSString *resultStr = [NSString stringWithFormat:@"%@.%@",firstStr,lastTempStr];
            NSLog(@"%@",resultStr);
            return  resultStr;
        }else{
            return firstStr;
        }
        
        
    }else{
        return self;
    }
}
- (CGSize)labelAutoCalculateRectWith:(NSString *)text FontSize:(CGFloat)fontSize
{
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:fontSize]};
    CGSize size=[text sizeWithAttributes:attrs];
    return size;
}
@end
