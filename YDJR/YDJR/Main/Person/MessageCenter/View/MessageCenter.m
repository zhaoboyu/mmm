//
//  MessageCenter.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "MessageCenter.h"
#import "MessageCenterCell.h"
#import "LLFMainPageViewModel.h"
#import "MessageCenterDetail.h"
#import "MessageCenterListView.h"
#import "UIImage+CreateImageWithColor.h"
#import "MessageCenterViewModel.h"
#import "DIYSegmentView.h"
#import "LLFPersonCenterPopView.h"
#import "ZBYPersonViewController.h"
@interface MessageCenter ()<MessageCenterListViewDelegate,DIYSegmentViewDelegate,GoBackAction>
@property (nonatomic,strong)DIYSegmentView *messageTypeDIYSegmentView;
@property (nonatomic,strong)MessageCenterListView *messageCenterListView;
@property (nonatomic,strong)MessageCenterDetail *messageCenterDetail;
@property (nonatomic,assign)MESSAGETYPE messageType;
@property (nonatomic,strong)UIView *bottomBGview;
@property (nonatomic,strong)NSArray *itemsArr;
@property (nonatomic,strong)UIView *nullMessageView;
@property (nonatomic,strong)UIView *topBGView;
@property(nonatomic,strong)NSMutableArray *firstArr;
@end
@implementation MessageCenter
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _messageType = MESSAGETYPE_SYSTEM;
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.backgroundColor = [UIColor hex:@"#FFF2F2F2"];
    self.clipsToBounds = YES;
    UIView *topBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 96 * hScale)];
    topBGView.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
    [self addSubview:topBGView];
    topBGView.clipsToBounds = YES;
    self.topBGView = topBGView;
    self.firstArr = [NSMutableArray arrayWithObjects:@(YES),@(YES),@(YES) ,nil];
    self.messageTypeDIYSegmentView = [[DIYSegmentView alloc]initWithFrame:CGRectMake((CGRectGetWidth(topBGView.frame) - 600 * wScale) / 2, (CGRectGetHeight(topBGView.frame) - 58 * hScale) / 2, 600 * wScale, 58 * hScale) items:self.itemsArr];
    self.messageTypeDIYSegmentView.delegate = self;
    [topBGView addSubview:self.messageTypeDIYSegmentView];
    
    self.bottomBGview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topBGView.frame) + 2 * hScale, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(topBGView.frame) - 1 * hScale)];
    self.bottomBGview.clipsToBounds = YES;
    [self addSubview:self.bottomBGview];
    self.nullMessageView = [[UIView alloc]initWithFrame:self.bottomBGview.frame];
    self.nullMessageView.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
    
    UIImageView *nullMessageImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.bottomBGview.frame.size.width - 476 * wScale) / 2, 216 * hScale, 476 * wScale, 408 * hScale)];
    nullMessageImageView.image = [UIImage imageNamed:@"LLF_Message_Null"];
    [self.nullMessageView addSubview:nullMessageImageView];
        [self.messageCenterListView changeMessageTypeWithMessageType:self.messageType];
    
    
   
    
    //注册通知,接受新消息通知更新界面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadNewMessage) name:@"loadMessage" object:@"loadMessage"];
}

//更新标题
- (void)updataMessageTypeNum
{
    [self.messageTypeDIYSegmentView updataWithItems:self.itemsArr];
    
}
//收到新消息时更新消息
- (void)loadNewMessage
{
    [self.messageCenterListView changeMessageTypeWithMessageType:self.messageType];
    [self updataMessageTypeNum];
}
- (NSArray *)itemsArr
{
    NSArray *messageTypesNumArr = [MessageCenterViewModel queryMessageTypesNum];
    NSMutableArray *messageTypeArr = [NSMutableArray array];
    if (messageTypesNumArr.count > 2) {
        [messageTypeArr addObject:[NSString stringWithFormat:@"系统通知(%@)",messageTypesNumArr[0]]];
        [messageTypeArr addObject:[NSString stringWithFormat:@"应用通知(%@)",messageTypesNumArr[1]]];
        [messageTypeArr addObject:[NSString stringWithFormat:@"业务通知(%@)",messageTypesNumArr[2]]];
    }
    
    return messageTypeArr;
}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    [self.messageDelegate message];
}
#pragma mark 代理事件
//MessageCenterListViewDelegate
- (void)clickCellWithMessageModel:(MessageModel *)messageModel type:(NSInteger)messagetype
{
    self.messageType =(MESSAGETYPE)messagetype;
    [self updataMessageTypeNum];
    if (messageModel) {
        if (![self.bottomBGview superview]) {
            [self addSubview:self.bottomBGview];
        }
    if ([self.nullMessageView superview]) {
            [self.nullMessageView removeFromSuperview];
        }
        if (![[self.firstArr objectAtIndex:self.messageType]  isEqual:@(NO)]) {
         
            [self.firstArr replaceObjectAtIndex:self.messageType withObject:@(NO)];
        }else{
           // [UIView animateWithDuration:0.2 animations:^{
                
                self.topBGView.frame = CGRectMake(0, 0, 0, self.topBGView.frame.size.height);
                self.bottomBGview.frame = CGRectMake(0, 0, 0, self.topBGView.frame.size.height);
//            } completion:^(BOOL finished) {
                self.messageCenterDetail.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
               self.messageCenterDetail.messageType = self.messageType ==MESSAGETYPE_SYSTEM?@"系统消息":self.messageType==MESSAGETYPE_APPLICATION?@"应用消息":@"业务消息"
            ;                self.messageCenterDetail.messageModel = messageModel;
            
//            }];
        }
      
      
    }else{
        if ([self.bottomBGview superview]) {
            [self.bottomBGview removeFromSuperview];
        }
        [self.bottomBGview removeFromSuperview];
        
        if (![self.nullMessageView superview]) {
            [self addSubview:self.nullMessageView];
        }
    }
      [self.messageDelegate message];
}
-(MessageCenterDetail *)messageCenterDetail{
    if (!_messageCenterDetail) {
        _messageCenterDetail =  [[MessageCenterDetail alloc]init];
        [self addSubview:_messageCenterDetail];
        _messageCenterDetail.backDelegate = self;
    }
    return _messageCenterDetail;
}
- (MessageCenterListView *)messageCenterListView{
    if (!_messageCenterListView) {
        _messageCenterListView =[[MessageCenterListView alloc]initWithFrame:CGRectMake(0, 0, 1400*wScale, self.frame.size.height - _messageTypeDIYSegmentView.frame.origin.y -_messageTypeDIYSegmentView.frame.size.height)];
            _messageCenterListView.delegate = self;
         [self.bottomBGview addSubview:_messageCenterListView];
    }
    return _messageCenterListView;
}
//DIYSegmentViewDelegate
- (void)passDIYSegmentViewWithIndex:(NSInteger)index
{

    self.firstArr = [NSMutableArray arrayWithObjects:@(YES),@(YES),@(YES), nil];
    self.messageType  =(MESSAGETYPE)index;
    [self.messageCenterListView changeMessageTypeWithMessageType:self.messageType];
   
}
-(void)goBack{
    //[UIView animateWithDuration:0.2 animations:^{
        self.topBGView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 96 * hScale);
        self.bottomBGview.frame =   CGRectMake(0, CGRectGetMaxY(_topBGView.frame) + 1 * hScale, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(_topBGView.frame) - 1 * hScale);
    
 //   } completion:^(BOOL finished) {
        
          self.messageCenterDetail.frame = CGRectMake(0, 0, 0, self.topBGView.frame.size.height);
  //  }];
}

@end
