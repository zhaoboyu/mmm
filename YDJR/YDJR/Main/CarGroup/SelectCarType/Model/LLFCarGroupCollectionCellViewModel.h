//
//  LLFCarGroupCollectionCellViewModel.h
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/23.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLFCarGroupCollectionCellViewModel : NSObject

+(NSArray*)findRepeatFirstLetter:(NSMutableArray*)dataArray;
+(BOOL)isChinese:(NSString*) str;
+(BOOL)isLowercase:(NSString*) str;
@end
