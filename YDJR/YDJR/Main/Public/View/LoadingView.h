//
//  LoadingView.h
//  CTTX
//
//  Created by 吕利峰 on 16/5/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
@property (nonatomic,strong)CADisplayLink *displayLink;
@property (nonatomic,strong)UIImageView *loadingImageView;//等待图片
@property (nonatomic,strong)UILabel *loadingLabel;//等待提示
@end
