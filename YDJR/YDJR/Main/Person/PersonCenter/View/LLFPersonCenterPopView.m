//
//  LLFPersonCenterPopView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/1/4.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFPersonCenterPopView.h"
#import "LLFPersonCenterTableViewCell.h"
#import "LLFMainPageViewModel.h"
#import "ChangePasswordView.h"
#import "MessageCenter.h"
#import "LLFAboutView.h"
#import "LLFFeedbackView.h"
#import "MessageCenterViewModel.h"
#define kCell @"LLFPersonCenterTableViewCell"
@interface LLFPersonCenterPopView ()<UITableViewDelegate,UITableViewDataSource>

/**
 功能列表
 */
@property (nonatomic,strong)UITableView *tableView;

/**
 背景图层
 */
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *wihtBgView;
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *iconNameArr;
@end

@implementation LLFPersonCenterPopView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor hexString:@"#4D000000"];
        [self p_setupView];
        
    }
    return self;
}

- (void)p_setupView
{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(414 * wScale, 82 * hScale, 1220 * wScale, 1372 * hScale)];
    self.bgView.backgroundColor = [UIColor hex:@"#4DFFFFFF"];
    [self addSubview:self.bgView];
    
    self.wihtBgView = [[UIView alloc]initWithFrame:CGRectMake(10 * hScale, 10 * hScale, CGRectGetWidth(self.bgView.frame) - 20 * wScale, CGRectGetHeight(self.bgView.frame) - 20 * hScale)];
    self.wihtBgView.backgroundColor = [UIColor hex:@"#FFF3F3F3"];
    [self.bgView addSubview:self.wihtBgView];
    
    UIView *topBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.wihtBgView.frame), 95 * hScale)];
    topBgView.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
    [self.wihtBgView addSubview:topBgView];
    
    UIButton *closeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    closeButton.frame = CGRectMake(0, 0, 100 * wScale, CGRectGetHeight(topBgView.frame));
    [closeButton setTitle:@"关闭" forState:(UIControlStateNormal)];
    [closeButton setTitleColor:[UIColor hex:@"#FF666666"]];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [closeButton addTarget:self action:@selector(hideView) forControlEvents:(UIControlEventTouchUpInside)];
    [topBgView addSubview:closeButton];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(closeButton.frame), 0, CGRectGetWidth(topBgView.frame) - CGRectGetWidth(closeButton.frame) * 2, CGRectGetHeight(topBgView.frame))];
    topLabel.text = @"我的";
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor hex:@"#FF333333"];
    topLabel.font = [UIFont systemFontOfSize:17.0];
    [topBgView addSubview:topLabel];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topBgView.frame) + 24 * hScale, CGRectGetWidth(self.wihtBgView.frame), 112 * hScale * 4) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.wihtBgView addSubview:self.tableView];
    [self.tableView registerClass:[LLFPersonCenterTableViewCell class] forCellReuseIdentifier:kCell];
    
    UIButton *logoutButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    logoutButton.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame) + 24 * hScale, CGRectGetWidth(self.wihtBgView.frame), 112 * hScale);
    logoutButton.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
    [logoutButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [logoutButton setTitleColor:[UIColor hex:@"#FFFF5252"]];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [logoutButton addTarget:self action:@selector(logoutButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.wihtBgView addSubview:logoutButton];
    //注册通知,接受新消息通知更新界面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadNewMessage) name:@"loadMessage" object:@"loadMessage"];
    
}


#pragma mark tableView delegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112 * hScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLFPersonCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.titleNameLabel.text = self.titleArr[indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:self.iconNameArr[indexPath.row]];
    if (indexPath.row == 0 && self.messageCount && self.messageCount.length > 0 && [self.messageCount integerValue] > 0) {
        cell.messageImageView.hidden = NO;
        cell.messageLabel.hidden = NO;
        if ([self.messageCount integerValue] > 99) {
            cell.messageLabel.text = @"99";
        }
        cell.messageLabel.text = self.messageCount;
    }else{
        cell.messageImageView.hidden = YES;
        cell.messageLabel.hidden = YES;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            //消息中心
        {
            CGRect frame=self.wihtBgView.bounds;
            MessageCenter* center=[[MessageCenter alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
            [self.wihtBgView addSubview:center];
            [UIView animateWithDuration:0.2 animations:^{
                center.frame=self.wihtBgView.bounds;
            }];
        }
            
            break;
        case 1:
            //修改密码
        {
            CGRect frame=self.wihtBgView.bounds;
            ChangePasswordView* change=[[ChangePasswordView alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
            [self.wihtBgView addSubview:change];
            [UIView animateWithDuration:0.2 animations:^{
                change.frame=self.wihtBgView.bounds;
            }];
        }
            break;
        case 2:
            //意见反馈
        {
            CGRect frame=self.wihtBgView.bounds;
            LLFFeedbackView *feedbackView = [[LLFFeedbackView alloc]initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
            [self.wihtBgView addSubview:feedbackView];
            [UIView animateWithDuration:0.2 animations:^{
                feedbackView.frame=self.wihtBgView.bounds;
            }];
            
        }
            break;
        case 3:
            //关于
        {
            CGRect frame=self.wihtBgView.bounds;
            LLFAboutView *aboutView = [[LLFAboutView alloc]initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
            [self.wihtBgView addSubview:aboutView];
            [UIView animateWithDuration:0.2 animations:^{
                aboutView.frame=self.wihtBgView.bounds;
            }];
        }
            break;
            
        default:
            break;
    }
}
- (void)loadNewMessage
{
    NSArray *messageTypeNumArr = [MessageCenterViewModel queryMessageTypesNum];
    if (messageTypeNumArr.count > 3) {
        self.messageCount = messageTypeNumArr[3];
    }
}
#pragma mark 显示/隐藏
- (void)showViewWithView:(UIView *)view
{
    self.bgView.frame = CGRectMake(414 * wScale, kHeight, 1220 * wScale, 1372 * hScale);
    //    [super addPopViewToWinder];
    [view addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(414 * wScale, 82 * hScale, 1220 * wScale, 1372 * hScale);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)hideView
{
    if (_delegate && [_delegate respondsToSelector:@selector(uploadMessage)]) {
        [self.delegate uploadMessage];
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(414 * wScale, kHeight, 1220 * wScale, 1372 * hScale);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
#pragma mark 退出登录
- (void)logoutButtonAction:(UIButton *)sender
{
    [self hideView];
    if (_delegate && [_delegate respondsToSelector:@selector(logout)]) {
        [self.delegate logout];
    }
}
#pragma mark 私有方法
- (void)setMessageCount:(NSString *)messageCount
{
    _messageCount = messageCount;
    [self.tableView reloadData];
    
}
- (NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [NSArray arrayWithObjects:@"消息中心",@"修改密码",@"意见反馈",@"关于我们", nil];
    }
    return _titleArr;
}
- (NSArray *)iconNameArr
{
    if (!_iconNameArr) {
        _iconNameArr = [NSArray arrayWithObjects:@"LLF_Person_messageCenter",@"LLF_Person_changePassowrde",@"LLF_Person_messageBack",@"LLF_Person_guanYu", nil];
    }
    return _iconNameArr;
}
@end
