//
//  LLFWorkBenchLeftItemView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/5/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLFWorkBenchLeftItemViewDelegate <NSObject>
@optional
- (void)selectMechanismName:(NSString *)mechanismName;
@end
@interface LLFWorkBenchLeftItemView : UIView
@property (nonatomic,weak)id<LLFWorkBenchLeftItemViewDelegate>delegate;
@property (nonatomic,strong)NSMutableArray *titleArr;
@end
