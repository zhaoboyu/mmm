//
//  WPQPersonView.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/24.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "WPQPersonView.h"
#import "LLFMainPageViewModel.h"
#import "WPQCarGroupViewController.h"
#import "ChangePasswordView.h"
@implementation WPQPersonView

-(id)init{
    self=[super init];
    if (self) {
        
        self.frame=CGRectMake(0, 0, kWidth, kHeight);
        {
            UIView* view=[[UIView alloc] initWithFrame:self.bounds];
            view.backgroundColor=[UIColor hex:@"#4D000000"];
            [self addSubview:view];
        }
        CGRect frame=CGRectMake(414*wScale,82*hScale,kWidth-2*414*wScale, kHeight-2*82*hScale);
        UIView* shadowBgView=[[UIView alloc] initWithFrame:frame];
        shadowBgView.backgroundColor=[UIColor hex:@"#4DFFFFFF"];
        [self addSubview:shadowBgView];
        
        UIView* bgView=[[UIView alloc] initWithFrame:CGRectMake(10*wScale, 10*hScale, frame.size.width-20*wScale,  frame.size.height-20*hScale)];
        bgView.backgroundColor=[UIColor hex:@"#F3F3F3"];
        [shadowBgView addSubview:bgView];
        myBgview=bgView;
        
        
        
        {
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1200*wScale, 96*hScale)];
            view.backgroundColor=[UIColor hex:@"#FFFFFF"];
            [bgView addSubview:view];
            
            UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
            bt.tag=0;
            [bt setTitle:@"关闭" forState:UIControlStateNormal];
            [bt setTitleColor:[UIColor hex:@"#666666"]];
            bt.titleLabel.font=[UIFont systemFontOfSize:15];
            bt.frame=CGRectMake(20*wScale, 33*hScale, 70*wScale, 30*hScale);
            bt.center=CGPointMake( bt.centerX, view.centerY);
            [bt addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:bt];
            
            UILabel* title=[[UILabel alloc] initWithFrame:CGRectMake(566*wScale, 31*hScale, 100*wScale, 30*hScale)];
            title.text=@"我的";
            title.font=[UIFont systemFontOfSize:17];
            title.textColor=[UIColor hex:@"#333333"];
            title.center=CGPointMake(view.frame.size.width/2, view.centerY);
            [view addSubview:title];
            
            
            UIView* lineView=[[UIView alloc] initWithFrame:CGRectMake(0, view.size.height-1, 1200*wScale, 1)];
            lineView.backgroundColor=[UIColor hex:@"#D9D9D9"];
            [view addSubview:lineView];
            
            frame=CGRectMake(0, 0, 0,CGRectGetMaxY(view.frame));
        }
        
        {
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height+24*hScale, 1200*wScale, 112*hScale)];
            view.backgroundColor=[UIColor hex:@"#FFFFFF"];
            [bgView addSubview:view];
            
            UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
            bt.tag=1;
            bt.frame=view.bounds;
            [bt addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:bt];
            
            UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(32*wScale, 39*hScale, 150*wScale, 34*hScale)];
            label.text=@"消息中心";
            label.font=[UIFont systemFontOfSize:17];
            label.textColor=[UIColor hex:@"#333333"];
            [view addSubview:label];
            
            UIImageView* arrow=[[UIImageView alloc] initWithFrame:CGRectMake(view.frame.size.width-(33+50)*wScale, 44*hScale, 15*wScale, 25*hScale)];
            [arrow setImage:[UIImage imageNamed:@"WPQicon_normal_xuanze"]];
            [view addSubview:arrow];
            
            self.point=[[UIImageView alloc] initWithFrame:CGRectMake(arrow.frame.origin.x-(27+24)*hScale, 40*hScale, 32*wScale, 32*hScale)];
            self.point.hidden=YES;
            [self.point setImage:[UIImage imageNamed:@"WPQtag_message"]];
            [view addSubview:self.point];
            
            self.messageCountLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 32*wScale, 32*hScale)];
            self.messageCountLabel.text=@"";
            self.messageCountLabel.textColor=[UIColor whiteColor];
            self.messageCountLabel.font=[UIFont systemFontOfSize:12];
            self.messageCountLabel.textAlignment=NSTextAlignmentCenter;
            [self.point addSubview:self.messageCountLabel];
            
            frame=CGRectMake(0, 0, 0,CGRectGetMaxY(view.frame));
        }
        
        {
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, 1200*wScale, 1)];
            view.backgroundColor=[UIColor hex:@"#D9D9D9"];
            [bgView addSubview:view];
            
            frame=CGRectMake(0, 0, 0,CGRectGetMaxY(view.frame));
            
        }
        
        
        {
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, 1200*wScale, 112*hScale)];
            view.backgroundColor=[UIColor hex:@"#FFFFFF"];
            [bgView addSubview:view];
            
            UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
            bt.tag=2;
            bt.frame=view.bounds;
            [bt addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:bt];
            
            UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(32*wScale, 39*hScale, 150*wScale, 34*hScale)];
            label.text=@"修改密码";
            label.font=[UIFont systemFontOfSize:17];
            label.textColor=[UIColor hex:@"#333333"];
            [view addSubview:label];
            
            UIImageView* arrow=[[UIImageView alloc] initWithFrame:CGRectMake(view.frame.size.width-(33+50)*wScale, 44*hScale, 15*wScale, 25*hScale)];
            [arrow setImage:[UIImage imageNamed:@"WPQicon_normal_xuanze"]];
            [view addSubview:arrow];
            
            UIView* lineView=[[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height-1, 1200*wScale, 1)];
            lineView.backgroundColor=[UIColor hex:@"#D9D9D9"];
            [view addSubview:lineView];

            frame=CGRectMake(0, 0, 0,CGRectGetMaxY(view.frame));
        }
        
        {
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height+24*hScale, 1200*wScale, 112*hScale)];
            view.backgroundColor=[UIColor hex:@"#FFFFFF"];
            [bgView addSubview:view];
            
            UIButton *bt=[UIButton buttonWithType:UIButtonTypeCustom];
            bt.tag=3;
            bt.frame=view.bounds;
            [bt setTitleColor:[UIColor hex:@"#FF5252"] forState:UIControlStateNormal];
            [bt setTitle:@"退出登录" forState:UIControlStateNormal];
            [bt addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:bt];
            
        }
        [self loadNewData];
    }
    return self;
}


- (void)loadNewData
{
//    [LLFMainPageViewModel checkMessageWithSuccessBlock:^(NSMutableArray *messageModelArr) {
//        NSInteger count=[self sumWithMessageArr:messageModelArr];
//        if (count == 0) {
//            self.point.hidden=YES;
//        }
//        else{
//            self.point.hidden=NO;
//            self.messageCountLabel.text=[NSString stringWithFormat:@"%ld",(long)count];
//        }
//    } failedBlock:^(NSError *error) {
//        self.phud.promptStr = @"网络状况不好...请稍后重试!";
//        [self.phud showHUDResultAddedTo:self];
//    }];
}


- (NSInteger)sumWithMessageArr:(NSArray *)messageArr
{
    NSInteger num = 0;
    for (MessageModel *model in messageArr) {
        if (!model.isRead) {
            num+=1;
        }
    }
    return num;
}


-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}



-(void)buttonAction:(UIButton*)bt{
    
    if (bt.tag==0) {
        [self removeFromSuperview];
    }
    else if (bt.tag == 1){
        CGRect frame=myBgview.bounds;
        MessageCenter* center=[[MessageCenter alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
        [myBgview addSubview:center];
        [UIView animateWithDuration:0.2 animations:^{
            center.frame=myBgview.bounds;
        }];
    }
    else if (bt.tag == 2){
         CGRect frame=myBgview.bounds;
        ChangePasswordView* change=[[ChangePasswordView alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
        [myBgview addSubview:change];
        [UIView animateWithDuration:0.2 animations:^{
            change.frame=myBgview.bounds;
        }];
    }
    else if (bt.tag == 3){
        UIResponder *nextResponder =  self;
        do{
            nextResponder = [nextResponder nextResponder];
            if ([nextResponder isKindOfClass:[WPQCarGroupViewController class]]){
                [(WPQCarGroupViewController*)nextResponder backAction];
            }
        } while (nextResponder != nil);
        
    }
}


-(void)WPQPersonViewWillAppear{
    [self loadNewData];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
