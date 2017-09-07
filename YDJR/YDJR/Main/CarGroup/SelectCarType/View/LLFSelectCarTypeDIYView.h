//
//  LLFSelectCarTypeDIYView.h
//  YDJR
//
//  Created by 吕利峰 on 16/12/1.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLFSelectCarTypeDIYViewDelegate <NSObject>
/**
 选中的汽车分类
 
 @param carType 1:进口,0:国产
 */
- (void)selectIndexWithCarType:(NSString *)carType;

@end
@interface LLFSelectCarTypeDIYView : UIView
@property (nonatomic,weak)id<LLFSelectCarTypeDIYViewDelegate>delegate;
@end
