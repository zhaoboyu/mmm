//
//  SDCBoxViewManager.m
//  YDJR
//
//  Created by sundacheng on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDCBoxViewManager.h"
#import "SDCBoxView.h"

@implementation SDCBoxViewManager
{
    NSMutableArray *_marray;
}

#pragma mark - UI
- (UIView *)creatBoxeslineMaxNum:(NSUInteger)lineMaxNum
                 totalNum:(NSUInteger)totalNum
             andSViewWidth:(CGFloat)SViewWidth {
    
    _marray = [[NSMutableArray alloc] init];
    
    CGFloat boxWidth = SViewWidth/lineMaxNum;
    CGFloat boxHeight = 120;
    
    NSUInteger lineCount;
    if (totalNum%lineMaxNum == 0) {
        lineCount = totalNum/lineMaxNum;
    } else {
        lineCount = totalNum/lineMaxNum + 1;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SViewWidth, lineCount * boxHeight)];
    
    NSInteger count;
    if (totalNum%lineMaxNum == 0) {
        count = totalNum/lineMaxNum;
    } else {
        count = totalNum/lineMaxNum + 1;
    }
    
    for (NSInteger i = 0; i < count; i++) {
        
        if (i == count - 1) {
            if (totalNum%lineMaxNum == 0) {
                for (NSInteger j = 0; j < lineMaxNum; j++) {
                    if (i == 0 && j == 0) {
                        SDCBoxView *boxView = [[SDCBoxView alloc] initWithFrame:CGRectMake(j*boxWidth, i*boxHeight, boxWidth, boxHeight) andLineStyle:LineStyleTopLeftBottom isFirst:YES];
                        self.boxView = boxView;
                        
                        [view addSubview:boxView];
                        
                        [_marray addObject:boxView];
                    } else {
                        SDCBoxView *boxView = [[SDCBoxView alloc] initWithFrame:CGRectMake(j*boxWidth, i*boxHeight, boxWidth, boxHeight) andLineStyle:LineStyleTopLeftBottom isFirst:NO];
                        [view addSubview:boxView];
                        
                        [_marray addObject:boxView];
                    }
                }
                
            } else {
                for (NSInteger j = 0; j < totalNum%lineMaxNum; j++) {
                    SDCBoxView *boxView = [[SDCBoxView alloc] initWithFrame:CGRectMake(j*boxWidth, i*boxHeight, boxWidth, boxHeight) andLineStyle:LineStyleTopLeftBottom isFirst:NO];
                    [view addSubview:boxView];
                    
                    [_marray addObject:boxView];
                }
            }
            
            break;
        } else {
            for (NSInteger j = 0; j < lineMaxNum; j++) {
                SDCBoxView *boxView;
                if (i == 0) {
                    if (j == 0) {
                        boxView = [[SDCBoxView alloc] initWithFrame:CGRectMake(j*boxWidth, i*boxHeight, boxWidth, boxHeight) andLineStyle:LineStyleTopLeftBottom isFirst:YES];
                        self.boxView = boxView;
                        
                    } else {
                        boxView = [[SDCBoxView alloc] initWithFrame:CGRectMake(j*boxWidth, i*boxHeight, boxWidth, boxHeight) andLineStyle:LineStyleTopLeftBottom isFirst:NO];
                    }
                } else {
                    boxView = [[SDCBoxView alloc] initWithFrame:CGRectMake(j*boxWidth, i*boxHeight, boxWidth, boxHeight)andLineStyle:LineStyleLeft isFirst:NO];
                }
                
                [view addSubview:boxView];
                
                [_marray addObject:boxView];
            }
        }
    }
    
    return view;
}

#pragma mark - getter and setter
- (void)setInfoArray:(NSArray *)infoArray {
    NSInteger i = 0;
    for (SDCBoxView *boxView in _marray) {
        NSDictionary *infoDict = infoArray[i];
        boxView.infoDict = infoDict;
        i++;
    }
}

@end
