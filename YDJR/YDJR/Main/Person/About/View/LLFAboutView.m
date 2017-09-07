//
//  LLFAboutView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/1/10.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFAboutView.h"
#import "LLFPersonCenterPopView.h"
@implementation LLFAboutView
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
    
    [self creatTopUI];
}
#pragma mark UI布局
//顶部导航栏
- (void)creatTopUI
{
//    UIImageView* backImageview=[[UIImageView alloc] initWithFrame:CGRectMake(20*wScale, 33*hScale, 18*wScale, 30*hScale)];
//    backImageview.image=[UIImage imageNamed:@"L_icon_back"];
//    backImageview.userInteractionEnabled=NO;
//    [self addSubview:backImageview];
//    
//    UILabel* backLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(backImageview.frame) + 10 * wScale, 32*hScale, 70*wScale, 32*hScale)];
//    backLabel.text=@"返回";
//    backLabel.font=[UIFont systemFontOfSize:16];
//    backLabel.textColor=[UIColor hex:@"#FF666666"];
//    [self addSubview:backLabel];
    
//    UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
//    bt.frame=CGRectMake(0, 0, 118*wScale, 96*hScale);
//    [bt addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:bt];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(96*hScale, 0, CGRectGetWidth(self.frame) -96*hScale * 2, 96 * hScale)];
    titleLabel.text = @"关于我们";
    titleLabel.textColor = [UIColor hex:@"#333333"];
    titleLabel.font = [UIFont systemFontOfSize:17.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(self.frame), 2 * hScale)];
    lineView.backgroundColor = [UIColor hex:@"#D9D9D9"];
    [self addSubview:lineView];
    
    [self creatContentUIWithLineView:lineView];
    
}
//内容
- (void)creatContentUIWithLineView:(UIView *)lineView
{
    UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - 180 * wScale) / 2, CGRectGetMaxY(lineView.frame) + 70 * hScale, 180 * wScale, 180 * hScale)];
    iconImageView.image = [UIImage imageNamed:@"LLF_Person_About_icon"];
    [self addSubview:iconImageView];
    
    UILabel *appNmaeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(iconImageView.frame), CGRectGetMaxY(iconImageView.frame) + 26 * hScale, CGRectGetWidth(iconImageView.frame), 38 * hScale)];
    appNmaeLabel.text = @"永达金融";
    appNmaeLabel.textColor = [UIColor hex:@"#333333"];
    appNmaeLabel.font = [UIFont systemFontOfSize:19.0];
    appNmaeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:appNmaeLabel];
    
    NSString *localVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    UILabel *versonLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(appNmaeLabel.frame), CGRectGetMaxY(appNmaeLabel.frame) + 24 * hScale, CGRectGetWidth(appNmaeLabel.frame), 26 * hScale)];
    versonLabel.text = localVersion;
    versonLabel.textColor = [UIColor hex:@"#333333"];
    versonLabel.font = [UIFont systemFontOfSize:13.0];
    versonLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:versonLabel];
    
    UILabel *aboutLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(versonLabel.frame) + 107 * hScale, CGRectGetWidth(self.frame), 38 * hScale)];
    aboutLabel.text = @"软件介绍";
    aboutLabel.textColor = [UIColor hex:@"#333333"];
    aboutLabel.font = [UIFont systemFontOfSize:19.0];
    aboutLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:aboutLabel];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - 920 * wScale) / 2, CGRectGetMaxY(aboutLabel.frame) + 23 * hScale, 920 * wScale, 0)];
    contentLabel.font = [UIFont systemFontOfSize:19.0];
//    contentLabel.text = @"改变传统口述、宣传单等形式的展业方式，将传统展业通过iPad进行，满足永达汽车金融对移动展业的基本需求，包括产品展示、营销、客户资料录入等工作，保证数据准确、安全。";
    NSString *temp = @"永达-移动展业是专为永达集团汽车销售团队所开发的一款在线展示类的营销工具。全方位的改变传统的产品展示方式，满足集团员工对于业务知识的学习以及业务推广的需求。";
    NSString *contentStr = @"永达-移动展业是专为永达集团汽车销售团队所开发的一款在线展示类的营销工具。全方位的改变传统的产品展示方式，满足集团员工对于业务知识的学习以及业务推广的需求。\n规范填单：确保单据录入的及时性与准确性。\n高效审批：加快流程审批，提高成交率。\n及时通知：产品更新及学习，政策调整的知悉。";
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle01.headIndent = 0.0f;//行首缩进
    //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    CGFloat emptylen = contentLabel.font.pointSize * 2;
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    paraStyle01.tailIndent = 0.0f;//行尾缩进
    paraStyle01.lineSpacing = 5.0f;//行间距
    NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:contentStr];
    [attrText addAttribute:NSParagraphStyleAttributeName value:paraStyle01 range:NSMakeRange(0,  [temp length])];
    
    NSMutableParagraphStyle *paraStyle02 = [[NSMutableParagraphStyle alloc] init];
    paraStyle02.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle02.headIndent = 0.0f;//行首缩进
    paraStyle02.tailIndent = 0.0f;//行尾缩进
    paraStyle02.lineSpacing = 5.0f;//行间距
    [attrText addAttribute:NSParagraphStyleAttributeName value:paraStyle02 range:NSMakeRange(temp.length,  contentStr.length - temp.length)];
    contentLabel.attributedText = attrText;
    contentLabel.textColor = [UIColor hex:@"#999999"];
    
//    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 0;
    [contentLabel sizeToFit];
    [self addSubview:contentLabel];
    
    UILabel *leftBottonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,1275*hScale, CGRectGetWidth(self.frame) / 2 - 10 * wScale, 26 * hScale)];
    leftBottonLabel.text = @"永达金融";
    leftBottonLabel.textColor = [UIColor hex:@"#999999"];
    leftBottonLabel.font = [UIFont systemFontOfSize:13.0];
    leftBottonLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:leftBottonLabel];
    
    UILabel *rightBottonLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftBottonLabel.frame) + 20 * wScale, 1275*hScale, CGRectGetWidth(self.frame) / 2 - 10 * wScale, 26 * hScale)];
    rightBottonLabel.text = @"版权所有";
    rightBottonLabel.textColor = [UIColor hex:@"#999999"];
    rightBottonLabel.font = [UIFont systemFontOfSize:13.0];
    rightBottonLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:rightBottonLabel];
    
}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    [self.messageDelegate about];
  
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
