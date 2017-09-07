//
//  LLFCarGroupCollectionCellViewModel.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/23.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarGroupCollectionCellViewModel.h"
#import "LLFMechanismCarModel.h"
@implementation LLFCarGroupCollectionCellViewModel

//找寻首字母重复的元素
+(NSArray*)findRepeatFirstLetter:(NSArray*)dataArray{
    
    NSMutableArray* firstLetterarray=[NSMutableArray array];
    //取出第一个元素放入数组 FirstLetterarray
    for (LLFMechanismCarModel*  obj in dataArray) {
        if ([obj isKindOfClass:[LLFMechanismCarModel class]]) {
            [firstLetterarray addObject:[obj.carSeriesName substringToIndex:1]];
        }
    }
    
    NSMutableArray* result=[NSMutableArray array];
    for (int i=0; i<firstLetterarray.count; i++) {
        id obj=firstLetterarray[i];
        firstLetterarray[i]=@"-1";
        if ([firstLetterarray containsObject:obj] && ![result containsObject:obj]) {
            [result addObject:obj];
        }
    }
    return result;    
}


//判断是否是汉字
+(BOOL)isChinese:(NSString*) str
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    
    
    if([predicate evaluateWithObject:str] == YES){
        return  YES;
    }
    return NO;
}

//判断是否是小写字母
+(BOOL)isLowercase:(NSString*) str
{
    NSString *match =@"^[a-z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    if([predicate evaluateWithObject:str] == YES){
        return  YES;
    }
    return NO;
}

@end
