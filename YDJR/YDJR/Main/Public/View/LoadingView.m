//
//  LoadingView.m
//  CTTX
//
//  Created by 吕利峰 on 16/5/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()
{
    int _index;
    CGFloat _lodingIamgeW;
    CGFloat _lodingIamgeH;
}
@property (nonatomic,strong)NSArray *loingImagesArr;

@end

@implementation LoadingView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self  p_setupView];
    }
    return self;
}
- (void)p_setupView
{
    self.loingImagesArr = @[@"Public_icon_loading_1",@"Public_icon_loading_2",@"Public_icon_loading_3",@"Public_icon_loading_4",@"Public_icon_loading_5",@"Public_icon_loading_6"];
    _index = 0;
    _lodingIamgeW = 84 * wScale;
    _lodingIamgeH = 94 * hScale;
//    self.backgroundColor = [UIColor hexString:@"#FFF5F2F2"];
    self.loadingImageView = [[UIImageView alloc]init];
    self.loadingImageView.frame = CGRectMake(self.frame.size.width / 2 - _lodingIamgeW / 2, self.frame.size.height / 2 - _lodingIamgeH / 2, _lodingIamgeW, _lodingIamgeH);
    self.loadingImageView.image = [UIImage imageNamed:@"Public_icon_loading_1"];
    [self addSubview:self.loadingImageView];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    self.displayLink.frameInterval = 6;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

    
    self.loadingLabel = [[UILabel alloc]init];
    self.loadingLabel.frame = CGRectMake(0, 25 * hScale + CGRectGetMaxY(self.loadingImageView.frame), self.frame.size.width, 24 * hScale);
    self.loadingLabel.textColor = [UIColor hexString:@"#FFA6A6A6"];
    self.loadingLabel.backgroundColor = [UIColor clearColor];
    self.loadingLabel.textAlignment = NSTextAlignmentCenter;
    self.loadingLabel.font = [UIFont systemFontOfSize:12.0];
    self.loadingLabel.text = @"正在加载请稍等…";
    [self addSubview:self.loadingLabel];
}
#pragma mark 等待图片旋转
- (void)handleDisplayLink:(CADisplayLink *)displaylink
{
//    CGAffineTransform endAngle = CGAffineTransformMakeRotation(_angle * (M_PI_4 / 180.0f));
    
//    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//        _loadin00000gImageView.transform = endAngle;
        NSString *imageName = self.loingImagesArr[_index];
        self.loadingImageView.image = [UIImage imageNamed:imageName];
        
//    } completion:^(BOOL finished) {
//        _angle += 10;
        if (_index < 5) {
            _index ++;
        }else{
            _index = 0;
        }
        
//    }];
    
}
@end
