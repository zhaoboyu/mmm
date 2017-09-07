//
//  LLFDIYInsuranceView.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/12.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLFDIYInsuranceView : UIView
@property (nonatomic,strong)UIImageView *bgImageView;
@property (nonatomic,strong)UILabel *yueLabel;
@property (nonatomic,strong)UILabel *yearLabel;
@property (nonatomic,strong)UILabel *threeYearLabel;
@property (nonatomic,assign)BOOL isSum;
+ (instancetype)initWithFrame:(CGRect)frame;
@end
