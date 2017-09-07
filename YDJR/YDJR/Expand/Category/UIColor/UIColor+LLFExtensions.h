//
//  UIColor+LLFExtensions.h
//  CTTX
//
//  Created by 吕利峰 on 16/4/18.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LLFExtensions)
+ (UIColor *) colorWithHexString: (NSString *) hexString;
@end
#pragma mark------tableView的分隔线颜色-----
NS_INLINE UIColor *LLFColorSeparator()
{
    return [UIColor colorWithHexString:@"EEEEEE"];
}

#pragma mark-------大背景色-------
NS_INLINE UIColor *LLFColorBackgrand()
{
    return [UIColor colorWithHexString:@"F3F3F3"];
}
#pragma mark------分隔线颜色-----
NS_INLINE UIColor *LLFColorline()
{
    return [UIColor colorWithHexString:@"#FFD9D9D9"];
}
