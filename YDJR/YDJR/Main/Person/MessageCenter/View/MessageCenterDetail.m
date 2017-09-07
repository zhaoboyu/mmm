//
//  MessageCenterDetail.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "MessageCenterDetail.h"
#import "DIYAttributedLabel.h"
#import "MessageModel.h"

#import "CTTXRequestServer+statusCodeCheck.h"
#import "MainViewController.h"
#import "AppDelegate.h"

@interface MessageCenterDetail ()<DIYAttributedLabelDelegate>
@property (nonatomic,strong)UILabel *messageTitleLabel;
@property (nonatomic,strong)UILabel *messageTimeLabel;
@property (nonatomic,strong)UILabel *messageContentLabel;
@property (nonatomic,strong)DIYAttributedLabel *jumLabel;
@property (nonatomic,strong)UILabel *headerLabel;
@property (nonatomic,strong)UIView *lineview;
@end

@implementation MessageCenterDetail

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
	self.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
    self.clipsToBounds = YES;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"< 返回" forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 60, 40);
    [backBtn setTitleColor:[UIColor hex:@"#666666"]];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 45, self.frame.size.width, 10)];
    lineview.backgroundColor = [UIColor blackColor];
    [self addSubview:lineview];
	
	self.messageTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40*wScale, 55+10*wScale, 1200*wScale, 34 * hScale)];
	self.messageTitleLabel.textColor = [UIColor hex:@"#333333"];
	self.messageTitleLabel.font = [UIFont systemFontOfSize:17.0];
	self.messageTitleLabel.textAlignment = NSTextAlignmentLeft;
	[self addSubview:self.messageTitleLabel];
    UIImageView *waitImage = [[UIImageView alloc]initWithFrame:CGRectMake(40*wScale, self.messageTitleLabel.frame.origin.y +self.messageTitleLabel.frame.size.height +22*wScale, 34*wScale, 34*hScale)];
    waitImage.image = [UIImage imageNamed:@"wait"];
    [self addSubview:waitImage];
    
    self.messageTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(76*wScale, waitImage.frame.origin.y, 350*wScale, 30 * hScale)];
    self.messageTimeLabel.textColor = [UIColor hex:@"#999999"];
    self.messageTimeLabel.font = [UIFont systemFontOfSize:12.0];
    self.messageTimeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.messageTimeLabel];

	
    UIView *secLine = [[UIView alloc]initWithFrame:CGRectMake(40*wScale, self.messageTimeLabel.frame.origin.y+self.messageTimeLabel.frame.size.height +20*wScale, 3500*wScale, 1)];
    secLine.backgroundColor = [UIColor hex:@"#e6e6e6"];
    secLine.clipsToBounds = YES;
    [self addSubview:secLine];

	self.messageContentLabel = [[UILabel alloc]initWithFrame:CGRectMake( 40 * wScale, self.messageTimeLabel.frame.origin.y+self.messageTimeLabel.frame.size.height +20*wScale + 44 * hScale+1, 820 * wScale, 30*hScale)];
	self.messageContentLabel.textColor = [UIColor hex:@"#666666"];
	self.messageContentLabel.font = [UIFont systemFontOfSize:15.0];
	self.messageContentLabel.textAlignment = NSTextAlignmentLeft;
	[self addSubview:self.messageContentLabel];
    

    
	//跳转链接
	self.jumLabel = [[DIYAttributedLabel alloc]initWithFrame:CGRectMake(40*wScale, self.messageContentLabel.frame.origin.y +self.messageContentLabel.frame.size.height + 20 * hScale, CGRectGetWidth(self.messageContentLabel.frame), 30 * hScale)];
    self.jumLabel.textAlignment = NSTextAlignmentLeft;
	self.jumLabel.backgroundColor = [UIColor clearColor];
	self.jumLabel.delegate = self;
	[self addSubview:self.jumLabel];
	
}
- (void)setMessageModel:(MessageModel *)messageModel
{
	if (messageModel) {
		_messageModel = messageModel;
		self.messageTitleLabel.text = _messageModel.title;
		self.messageTimeLabel.text = _messageModel.receiveTime;
		self.messageContentLabel.text = _messageModel.message;
		[self.messageContentLabel sizeToFit];
		self.jumLabel.frame =CGRectMake(40*wScale, self.messageContentLabel.frame.origin.y +self.messageContentLabel.frame.size.height + 20 * hScale, CGRectGetWidth(self.messageContentLabel.frame), 30 * hScale);
		if (_messageModel.messageType == MESSAGETYPE_BUSINESS && !_messageModel.isHandle && ![_messageModel.jumpType isEqualToString:@"00"]) {
			self.jumLabel.hidden = NO;
			[self.jumLabel setText:[NSString stringWithFormat:@"前往:%@",_messageModel.jumpName] index:3 firstColor:@"#666666" secondColor:@"#FF70D65F"];
		}else{
			self.jumLabel.hidden = YES;
		}
		
	}
}
-(void)setMessageType:(NSString *)messageType{
    if (self.headerLabel) {
        @autoreleasepool {
            [self.headerLabel removeFromSuperview];
        }
    }
    if (self.lineview) {
        @autoreleasepool {
            [self.lineview removeFromSuperview];
        }
    }
    self.headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width , 40)];
    self.headerLabel.textAlignment = NSTextAlignmentCenter;
    self.headerLabel.textColor = [UIColor hex:@"#333333"];
    [self addSubview:self.headerLabel];
   self.headerLabel.text = messageType;
    self.lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, 1)];
    self.lineview.backgroundColor = [UIColor hex:@"#e6e6e6"];
    [self addSubview:_lineview];
    
}
#pragma mark富文本
- (void)clickAttributedLabel
{
	NSLog(@"用户协议");
    //根据产品类型做不同的操作
//    if ([self.messageModel.productType isEqualToString:@"dfq"]) {
        //达分期
        //根据不同的跳转类型,做不同的操作
        if ([self.messageModel.jumpType isEqualToString:@"05"]){
            //重新生成合同
            //H5界面
            [[CTTXRequestServer shareInstance]checkCustomerWithCustomerID:self.messageModel.customerID SuccessBlock:^(NSDictionary *responseDict) {
                NSMutableDictionary *transferDict = [responseDict[@"res"] mutableCopy];
                //是否是扫描
                [transferDict setValue:@"1" forKey:@"isScan"];
                //证件类别
                //[transferDict setValue:transferDict[@"idsType"] forKey:@"credentialsType"];
                [transferDict setValue:self.messageModel.messageId forKey:@"messageId"];
                [[NSUserDefaults standardUserDefaults]setObject:transferDict forKey:@"dafenqiDic"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                MainViewController *applyMainVC = [[MainViewController alloc]init];
                
                applyMainVC.startPage = [Tool getWWWPackAddressWithIndexName:@"toStaging.html"];
                applyMainVC.isDaFenQiApply = YES;
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                appDelegate.mainVC = applyMainVC;
                [[UIViewController currentViewController] presentViewController:applyMainVC animated:YES completion:nil];
            } failedBlock:^(NSError *error) {
                
            }];
            
            //MainViewController *applyMainVC = [[MainViewController alloc]init];
            //applyMainVC.startPage = @"toStaging.html";
            //applyMainVC.isDaFenQiApply = YES;
            //
            //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            //appDelegate.mainVC = applyMainVC;
            //[[UIViewController currentViewController] presentViewController:applyMainVC animated:YES completion:nil];
            
        }else{
            //一次影像资料采集 补件 二次进件 补保单
            
            NSDictionary *StatusCodeRM = [self.messageModel yy_modelToJSONObject];
            
            [[NSUserDefaults standardUserDefaults]setObject:StatusCodeRM forKey:@"StatusCodeRM"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            MainViewController *mainVC = [MainViewController new];
            mainVC.isHaveTop = NO;
            
            mainVC.startPage = [Tool getWWWPackAddressWithIndexName:@"imageData.html"];
            mainVC.isDaFenQiApply = YES;
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDelegate.mainVC = mainVC;
            [[UIViewController currentViewController] presentViewController:mainVC animated:YES completion:nil];
            
        }
//    }else if ([self.messageModel.productType isEqualToString:@"rzzl"]){
//        //融资租赁
//        if ([self.messageModel.jumpType isEqualToString:@"02"]){
//            //补件
//            NSDictionary *StatusCodeRM = [self.messageModel yy_modelToJSONObject];
//            
//            [[NSUserDefaults standardUserDefaults]setObject:StatusCodeRM forKey:@"StatusCodeRM"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            MainViewController *mainVC = [MainViewController new];
//            mainVC.isHaveTop = NO;
//            mainVC.startPage = @"imageData.html";
//            mainVC.isDaFenQiApply = YES;
//            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            appDelegate.mainVC = mainVC;
//            [[UIViewController currentViewController] presentViewController:mainVC animated:YES completion:nil];
//        }
//    }
	
}
- (void)backAction{
    [self.backDelegate goBack];
}

@end
