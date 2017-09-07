//
//  SDCBoxView.m
//  YDJR
//
//  Created by sundacheng on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDCBoxView.h"

@implementation SDCBoxView
{
    UIView *_view;
    UILabel *_titleLabel;
    UILabel *_infoLabel;
    UILabel *_stateLabel;
}

#pragma mark - UI
- (instancetype) initWithFrame:(CGRect)frame andLineStyle:(LineStyle)lineStyle isFirst:(BOOL)isFirst{
    if (self = [super initWithFrame:frame]) {
        if (lineStyle == LineStyleTopLeftBottom) {
            _view = [[UIView alloc] initWithFrame:CGRectMake(0.5, 0.5, frame.size.width - 0.5, frame.size.height - 1)];
        } else {
            _view = [[UIView alloc] initWithFrame:CGRectMake(0.5, 0, frame.size.width - 0.5, frame.size.height)];
        }
        [self createUIWithFrame:frame isFirst:isFirst];
    }
    return self;
}

- (void)createUIWithFrame:(CGRect)frame isFirst:(BOOL)isFirst{
    [self addSubview:_view];
    
    self.backgroundColor = [UIColor hex:@"#D8D8D8"];
    
    _view.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 13, 150, 20)];
    [self addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor hex:@"#999999"];
    _titleLabel.font= [UIFont systemFontOfSize:12];
    
    if (isFirst) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 192/2, 64/2)];
        [self addSubview:_button];
        _button.left = 12;
        _button.top = 76/2;
        _button.titleLabel.font = [UIFont systemFontOfSize:15];
        _button.titleLabel.textColor = [UIColor whiteColor];
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = 5;
        
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame) + 20 * hScale, 235, 20)];
        [self addSubview:_stateLabel];
        _stateLabel.left = 16;
//        _stateLabel.top = 44;
        _stateLabel.textColor = [UIColor hex:@"#333333"];
        _stateLabel.font  = [UIFont systemFontOfSize:16];
    } else {
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 235, 20)];
        [self addSubview:_infoLabel];
        _infoLabel.left = 16;
        _infoLabel.top = 44;
        _infoLabel.textColor = [UIColor hex:@"#333333"];
        _infoLabel.font  = [UIFont systemFontOfSize:16];
    }
}

#pragma mark - setter
- (void)setInfoDict:(NSDictionary *)infoDict {
    NSString *title = infoDict[@"title"];
    _titleLabel.text = title;
    
    NSString *info = infoDict[@"info"];
    
    
    NSString *state = infoDict[@"state"];
    
    NSString *isClick = infoDict[@"isClick"];
    
    if (_stateLabel) {
        NSString *isShow = infoDict[@"isShow"];
        NSString *replenState = infoDict[@"replenState"];
        if ([isShow isEqualToString:@"1"]) {
            _stateLabel.hidden = NO;
            _stateLabel.text = replenState;
            if ([replenState isEqualToString:@"补款中"]) {
                _stateLabel.textColor = [UIColor redColor];
            }else if ([replenState isEqualToString:@"补款成功"]){
                _stateLabel.textColor = [UIColor greenColor];
            }
        }else{
            _stateLabel.hidden = YES;
        }
    }
    
    
    if (_infoLabel) {
        _infoLabel.text = info;
    }
    
    //存在button
    if (_button) {
        CGFloat stateW = [Tool widthForString:state fontSize:17.0 andHight:64 * hScale];
        CGRect btnFrame = _button.frame;
        if ((stateW + 20 * wScale) > 192 * wScale) {
            btnFrame.size.width = stateW + 20 * wScale;
        }else{
            btnFrame.size.width = 192 * wScale;
        }
        _button.frame = btnFrame;
        [_button addTarget:self action:@selector(loadWebAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_button setTitle:state forState:UIControlStateNormal];
        if ([isClick isEqualToString:@"1"]) {
            _button.backgroundColor = [UIColor hex:@"#FC5A5A"];
            _button.enabled = YES;
        }else{
            _button.backgroundColor = [UIColor lightGrayColor];
            _button.enabled = NO;
        }
    }
}

#pragma mark - action
- (void)loadWebAction {
    self.applyTyple();
}


@end
