//
//  MessageView.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/10/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "MessageView.h"

@implementation MessageView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor darkGrayColor]colorWithAlphaComponent:0.7f];
        [self setupView];
    }
    
    return self;
}
-(void)setupView{
    
    bgview=[[UIView alloc] initWithFrame:CGRectMake(644.0/4080* kWidth, 370.0/3070*self.frame.size.height, (1-2*644.0/4080)* kWidth, (1-2*370.0/3070)*self.frame.size.height)];
    bgview.backgroundColor=[UIColor whiteColor];
    bgview.layer.masksToBounds=YES;
    bgview.layer.cornerRadius=5;
    [self addSubview:bgview];
    

    CGRect frame=bgview.frame;
    UILabel* titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2-30, 10*wScale, 200*wScale, 30)];
    titleLabel.text=@"消息详情";
    titleLabel.center=CGPointMake(bgview.frame.size.width/2, titleLabel.center.y);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor hex:@"#FF333333"];
    titleLabel.font = [UIFont systemFontOfSize:18.0];
    [bgview addSubview:titleLabel];

    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"关闭" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor hex:@"#FF666666"]];
    button.titleLabel.font = [UIFont systemFontOfSize:16.0];
    button.frame=CGRectMake(0, 20*wScale, 100*wScale, 40*wScale);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:button];
    
    
    UIView* line=[[UIView alloc] initWithFrame:CGRectMake(0, titleLabel.frame.size.height+20*wScale, CGRectGetWidth(bgview.frame), 1)];
    line.backgroundColor=LLFColorline();
    [bgview addSubview:line];
    
    
    CGFloat width=CGRectGetWidth(bgview.frame);
    CGFloat height=CGRectGetHeight(bgview.frame);
    scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(360.0/2780*width, 200.0/2100*height, (1-2*360.0/2780)*width, (1-420.0/2100)*height)];
    scrollView.contentSize=CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height+1);
    [bgview addSubview:scrollView];
    
    
}

-(void)setContentStr:(NSString *)contentStr{
    _contentStr=contentStr;
    [self crContentLabel];
}

-(void)crContentLabel{

//    UIFont *font=[UIFont fontWithName:nil size:17];
//    CGSize titleSize = [_contentStr sizeWithFont:font] ;

    
    
    
    
    UILabel*contentLabel=[[UILabel alloc] initWithFrame:CGRectMake(10*wScale, 10*wScale, 200, 200)];
    contentLabel.numberOfLines=0;
    contentLabel.text=_contentStr;
    contentLabel.textColor = [UIColor hex:@"#FF666666"];
    contentLabel.font = [UIFont systemFontOfSize:13.0];
//    contentLabel.frame=CGRectMake(10*wScale, 10*wScale, titleSize.width, titleSize.height);
    contentLabel.frame=CGRectZero;
    
    contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(scrollView.frame.size.width-20*wScale, 9999);//labelsize的最大值
    //关键语句
    CGSize expectSize = [contentLabel sizeThatFits:maximumLabelSize];
    //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
    contentLabel.frame = CGRectMake(10*wScale, 10*wScale, expectSize.width, expectSize.height);
    [scrollView addSubview:contentLabel];
    
    
    
    
    if (_Important == YES) {
        UILabel*ImportantLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40*wScale)];
        ImportantLable.textAlignment=NSTextAlignmentLeft;
        ImportantLable.text=@"重要通知";
        ImportantLable.font=[UIFont systemFontOfSize:17.0];
        ImportantLable.textColor = [UIColor hex:@"#FF333333"];
        [scrollView addSubview:ImportantLable];
        
        CGRect frame=contentLabel.frame;
        contentLabel.frame=CGRectMake(frame.origin.x, frame.origin.y+50*wScale, frame.size.width, frame.size.height);
    }
}

-(void)buttonAction{
    [self removeFromSuperview];
}


-(BOOL)isInArea:(CGRect)rect    withpoint:(CGPoint)point  {
    CGMutablePathRef pathRef=CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, rect.origin.x, rect.origin.y);
    CGPathAddLineToPoint(pathRef, NULL, rect.origin.x+rect.size.width, rect.origin.y);
    CGPathAddLineToPoint(pathRef, NULL, rect.origin.x+rect.size.width,  rect.origin.y+rect.size.height);
    CGPathAddLineToPoint(pathRef, NULL, rect.origin.x,  rect.origin.y+rect.size.height);
    CGPathAddLineToPoint(pathRef, NULL, rect.origin.x, rect.origin.y);
    CGPathCloseSubpath(pathRef);
    if (CGPathContainsPoint(pathRef, NULL, point, NO)){
        NSLog(@"point in path!");
        return YES;
    }
    NSLog(@"outPoint out path!");
    return NO;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    BOOL inArea=[self isInArea:bgview.frame withpoint:touchPoint];
    
    if (!inArea) {
        [self removeFromSuperview];
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
