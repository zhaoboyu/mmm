//
//  LLFMainPageView.m
//  YDJR
//
//  Created by 吕利峰 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFMainPageView.h"

@implementation LLFMainPageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.backgroundColor = [UIColor hexString:@"#FFE6E7EB"];
    
    UIImageView *messagaeBGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(32 * wScale, 32 * hScale, 1984 * wScale, 72 * hScale)];
    messagaeBGImageView.image = [UIImage imageNamed:@"bg_xiaoxi"];
    messagaeBGImageView.userInteractionEnabled = YES;
    [self addSubview:messagaeBGImageView];
    
    UIImageView *messageImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20 * wScale, 20 * hScale, 32 * wScale, 32 * wScale)];
    messageImageView.image = [UIImage imageNamed:@"icon_message"];
    messageImageView.userInteractionEnabled = YES;
    [messagaeBGImageView addSubview:messageImageView];
    
    self.messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(messageImageView.frame) + 24 * wScale, 0, CGRectGetWidth(messagaeBGImageView.frame) - 74 * wScale, 72 * hScale)];
    self.messageLabel.text = @"暂无通知!";
    self.messageLabel.textAlignment = NSTextAlignmentLeft;
    self.messageLabel.textColor = [UIColor hexString:@"#FF666666"];
    self.messageLabel.font = [UIFont systemFontOfSize:14.0];
    self.messageLabel.backgroundColor = [UIColor clearColor];
    [messagaeBGImageView addSubview:self.messageLabel];
    
    self.messageButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.messageButton.frame = messagaeBGImageView.bounds;
    [messagaeBGImageView addSubview:self.messageButton];
    NSString *ppName = [[UserDataModel sharedUserDataModel] ppName];
//    ppName = [NSString stringWithFormat:@"%@ 汽车馆",ppName];
    NSArray *topIconArr = @[@"item_qicheguan",@"item_kehuguanli",@"item_zhishiku"];
    NSArray *titleArr = @[ppName,@"客户管理",@"知识库"];
    NSArray *contentArr = @[@"通过客户选择的车型进行金融产品展业等功能模块",@"全方位维护永达客户信息，跟进汽车金融展业任务",@"养车、用车、汽车金融等常识及冷知识，助您与客户保持一个好的关系"];
    for (int i = 0; i < 3; i ++) {
        UIImageView *carGroupBGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(32 * wScale + 668 * wScale * i, 32 * hScale + CGRectGetMaxY(messagaeBGImageView.frame), 648 * wScale, 1240 * hScale)];
        carGroupBGImageView.image = [UIImage imageNamed:@"bg_card"];
        carGroupBGImageView.userInteractionEnabled = YES;
        [self addSubview:carGroupBGImageView];
        
        UIImageView *carGroupTopIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(32 * wScale, 32 * hScale, 584 * wScale, 420 * hScale)];
        carGroupTopIconImageView.image = [UIImage imageNamed:topIconArr[i]];
        [carGroupBGImageView addSubview:carGroupTopIconImageView];
        
        UILabel *carGroupTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 56 * hScale + CGRectGetMaxY(carGroupTopIconImageView.frame), CGRectGetWidth(carGroupBGImageView.frame), 34 * hScale)];
        carGroupTitleLabel.text = titleArr[i];
        carGroupTitleLabel.font = [UIFont systemFontOfSize:17.0];
        carGroupTitleLabel.textAlignment = NSTextAlignmentCenter;
        carGroupTitleLabel.textColor = [UIColor hexString:@"#FF000000"];
        [carGroupBGImageView addSubview:carGroupTitleLabel];
        
        UILabel *carGroupContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(88 * wScale, 25 * hScale + CGRectGetMaxY(carGroupTitleLabel.frame), 472 * wScale, 80 * hScale)];
        carGroupContentLabel.text = contentArr[i];
        carGroupContentLabel.font = [UIFont systemFontOfSize:13.0];
        carGroupContentLabel.textAlignment = NSTextAlignmentCenter;
        carGroupContentLabel.textColor = [UIColor hexString:@"#FF999999"];
        carGroupContentLabel.numberOfLines = 0;
        [carGroupBGImageView addSubview:carGroupContentLabel];
        
        
        UIButton *tempButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        tempButton.frame = carGroupBGImageView.bounds;
        [tempButton addTarget:self action:@selector(sendIndexToControllerAction:) forControlEvents:(UIControlEventTouchUpInside)];
        tempButton.tag = 100 + i;
        [carGroupBGImageView addSubview:tempButton];
        
        
        UIButton *carGroupButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        carGroupButton.frame = CGRectMake(CGRectGetWidth(carGroupBGImageView.frame) / 2 - 88 * wScale, CGRectGetMaxY(carGroupContentLabel.frame) + 281 * hScale, 176 * wScale, 72 * hScale);
        [carGroupButton setBackgroundImage:[UIImage imageNamed:@"Btn_normal_start"] forState:(UIControlStateNormal)];
        [carGroupButton setBackgroundImage:[UIImage imageNamed:@"Btn_pressed_start"] forState:(UIControlStateHighlighted)];
        [carGroupButton setTitle:@"开始" forState:(UIControlStateNormal)];
        [carGroupButton setTitleColor:[UIColor hexString:@"#FFFFFFFF"] forState:(UIControlStateNormal)];
        [carGroupButton addTarget:self action:@selector(sendIndexToControllerAction:) forControlEvents:(UIControlEventTouchUpInside)];
        carGroupButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        carGroupButton.tag = 100 + i;
        [carGroupBGImageView addSubview:carGroupButton];
    
        
        
        
    }
    
}

- (void)sendIndexToControllerAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(sendButtonIndex:)]) {
        NSString *index = [NSString stringWithFormat:@"%ld",sender.tag - 100];
        [_delegate sendButtonIndex:index];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
