//
//  LLFDIYCardView.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/11.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLFDIYCardViewDelegate <NSObject>

- (void)cardViewButtonstate:(NSString *)state;

@end
@interface LLFDIYCardView : UIView
@property (nonatomic,assign)float allMoney;
@property (nonatomic,assign)float myMoney;
@property (nonatomic,strong)UIImageView *bgImageView;
+ (instancetype)initWithFrame:(CGRect)frame sumTitle:(NSString *)sumTitle allMoney:(float)allMoney  myMoney:(float)myMoney delegate:(id<LLFDIYCardViewDelegate>)delegate;
@end
