//
//  MessageCenterListView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/3/9.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "MessageCenterListView.h"
#import "MessageCenterCell.h"
#import "MessageCenterViewModel.h"
#define kCell @"MessageCenterCell"
@interface MessageCenterListView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *messageListTableView;
@property (nonatomic,strong)UIView *nullBgView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)MESSAGETYPE messageType;
@end

@implementation MessageCenterListView
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
    self.backgroundColor = [UIColor whiteColor];
    
//    UIImageView *topLineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1 * hScale)];
//    topLineImageView.backgroundColor = [UIColor hex:@"#FFD9D9D9"];
//    [self addSubview:topLineImageView];
//    
    self.messageListTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) -296*hScale -1 * hScale) style:(UITableViewStylePlain)];
    self.messageListTableView.delegate=self;
    self.messageListTableView.dataSource=self;
    self.messageListTableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [self.messageListTableView registerClass:[MessageCenterCell class] forCellReuseIdentifier:kCell];
//    self.messageListTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self addSubview:self.messageListTableView];
    
    self.dataArray=[NSMutableArray array];
    
    [self loadNewData];
}
- (void)loadNewData
{
    NSArray *messageModelArr = [MessageCenterViewModel queryMessageModelArrWithMessageType:self.messageType];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:messageModelArr];
    [self.messageListTableView reloadData];
    if (!(messageModelArr && messageModelArr.count > 0)) {
        if (_delegate && [_delegate respondsToSelector:@selector(clickCellWithMessageModel:type:)]) {
            [_delegate clickCellWithMessageModel:NULL type:self.messageType];
        }
    }else
        
    {
        if (_delegate && [_delegate respondsToSelector:@selector(clickCellWithMessageModel:type:)]) {
            [_delegate clickCellWithMessageModel:messageModelArr[0] type:self.messageType];
        }
    }
    
}
#pragma tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 196 * hScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    MessageModel* messageModel=[self.dataArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.messageModel = messageModel;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

        MessageModel* messageModel=[self.dataArray objectAtIndex:indexPath.row];
        if (!messageModel.isRead) {
            messageModel.isRead = YES;
            self.dataArray[indexPath.row] = messageModel;
            [MessageCenterViewModel updataMessageModelWithMessageModel:messageModel];
            [self.messageListTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.messageListTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }

        if (_delegate && [_delegate respondsToSelector:@selector(clickCellWithMessageModel:type:)]) {
            [_delegate clickCellWithMessageModel:messageModel type:self.messageType];
        }
    
   
    
}
/**
 切换消息分类
 */
- (void)changeMessageTypeWithMessageType:(MESSAGETYPE)messageType
{
    self.messageType = messageType;
    [self loadNewData];
    if (self.dataArray.count > 0) {
//        //设置默认选中cell
//        NSInteger selectedIndex = 0;
//        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
////        
////        
//        [self tableView:self.messageListTableView didSelectRowAtIndexPath:selectedIndexPath];
//        [self.messageListTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    
}

@end
