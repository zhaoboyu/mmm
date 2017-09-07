//
//  LLFSUMView.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/11.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLFSUMViewDelegate <NSObject>

- (void)sendSouceButtonstate:(float)state view:(UIView *)view;

@end

@interface LLFSUMView : UIView

@property (nonatomic,strong)UILabel *souceLabel;

+ (instancetype)initWithFrame:(CGRect)frame sumTitle:(NSString *)sumTitle souce:(float)souce delegate:(id<LLFSUMViewDelegate>)delegate isSum:(BOOL)isSum lestValue:(float)lestValue;
@end
