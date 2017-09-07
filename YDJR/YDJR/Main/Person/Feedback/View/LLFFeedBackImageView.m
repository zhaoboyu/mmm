//
//  LLFFeedBackImageView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/1/11.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFFeedBackImageView.h"

@interface LLFFeedBackImageView ()
@property(nonatomic, strong)UILongPressGestureRecognizer *longPressGestureRecognizer;
@end

@implementation LLFFeedBackImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.backgroundColor = [UIColor hex:@"#ffffff"];
    
    self.isClose = NO;
    
    self.contentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 18 * hScale, 150 * wScale, 150 * hScale)];
    self.contentImageView.userInteractionEnabled = YES;
    [self addSubview:self.contentImageView];
    
    self.colseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.colseButton.frame = CGRectMake(120 * wScale, 0, 46 * wScale, 46 * wScale);
    [self.colseButton addTarget:self action:@selector(colseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.colseButton setBackgroundImage:[UIImage imageNamed:@"LLF_Person_FeedBack_Close"] forState:(UIControlStateNormal)];
    
    /*create the gesture recognizer*/
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestures:)];
//    self.longPressGestureRecognizer.delegate = self;
    /*the number of fingers that must be present on the screen */
    self.longPressGestureRecognizer.numberOfTouchesRequired = 1;
    /*maximum 100 points of movement allowed before the gesture is recognized*/
    self.longPressGestureRecognizer.allowableMovement = 100.0f;
    /*the user must press two fingers(numberOfTouchesRequired)for at least one second for the gesture to be recognized*/
    self.longPressGestureRecognizer.minimumPressDuration = 1.0;
    /*add this gesture recognizer to the view*/
    [self.contentImageView addGestureRecognizer:self.longPressGestureRecognizer];
    
    
}

#pragma mark 响应事件
- (void)colseButtonAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(sendButtonState:view:)]) {
        
        [_delegate sendButtonState:@"1" view:self];
        [self removeFromSuperview];
    }
}
- (void)setIsClose:(BOOL)isClose
{
    _isClose = isClose;
    if (_isClose) {
        if (![self.colseButton superview]) {
            [self addSubview:self.colseButton];
        }
        
    }else{
        if ([self.colseButton superview]) {
            [self.colseButton removeFromSuperview];
        }
    }
}
-(void)handleLongPressGestures:(UILongPressGestureRecognizer *)paramSender{
    if (paramSender.state == UIGestureRecognizerStateBegan){
        self.isClose = YES;
        if (_delegate && [_delegate respondsToSelector:@selector(sendButtonState:view:)]) {
            [_delegate sendButtonState:@"2" view:self];
        }
    }
}
@end
