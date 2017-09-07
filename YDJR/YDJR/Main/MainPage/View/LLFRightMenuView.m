//
//  LLFRightMenuView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/3.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFRightMenuView.h"
#import "LLFRightMenuTableViewCell.h"

#define kCell @"LLFRightMenuTableViewCell"
@interface LLFRightMenuView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView *MenuView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)  NSArray* dataArray;
@property (nonatomic,copy)  NSArray* imageArray;

@end

@implementation LLFRightMenuView
- (instancetype)initWithFrame:(CGRect)frame messageNum:(NSInteger)messageNum
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hexString:@"#4D000000"];
        self.messageNum = messageNum;
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.dataArray=[NSArray arrayWithObjects:@"工作日志",@"消息中心",nil];
    self.imageArray=[NSArray arrayWithObjects:@"icon_gonzuorizhi",@"icon_xiaoxizhongxin",@"icon_sehzhi", nil];
    
    self.MenuView = [[UIView alloc]initWithFrame:CGRectMake(kWidth, 0, 640 * wScale, kHeight)];
    self.MenuView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
    [self addSubview:self.MenuView];
    
    
    //隐藏侧边栏
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backButton.frame = CGRectMake(kWidth-CGRectGetWidth(self.MenuView.frame)-48* wScale-20*wScale,20* wScale, 48 * wScale, 48 * wScale);
    [backButton setBackgroundImage:[UIImage imageNamed:@"icon_normal_back-1"] forState:(UIControlStateNormal)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icon_pressed_back-1"] forState:(UIControlStateHighlighted)];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:backButton];
 
    
    CGRect tableRect = CGRectMake(0, 0 * hScale, CGRectGetWidth(self.MenuView.frame), 1216 * hScale);
    self.tableView = [[UITableView alloc]initWithFrame:tableRect style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LLFRightMenuTableViewCell class] forCellReuseIdentifier:kCell];
    [self.MenuView addSubview:self.tableView];
    
    UIButton *revisePWButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    revisePWButton.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), CGRectGetWidth(self.MenuView.frame), 120 * hScale);
    [revisePWButton addTarget:self action:@selector(revisePWButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    revisePWButton.backgroundColor = [UIColor clearColor];
    [self.MenuView addSubview:revisePWButton];
    
    UIImageView *revisePWIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(36 * wScale, 40 * hScale, 40 * wScale, 40 * wScale)];;
    revisePWIconImageView.image = [UIImage imageNamed:@"icon_sehzhi"];
    [revisePWButton addSubview:revisePWIconImageView];
    
    UILabel *revisePWLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(revisePWIconImageView.frame) + 32 * wScale, 44 * hScale, CGRectGetWidth(self.MenuView.frame) - 108 * wScale, 32 * hScale)];
    revisePWLabel.text = @"修改密码";
    revisePWLabel.textColor = [UIColor hexString:@"#FF666666"];
    revisePWLabel.font = [UIFont systemFontOfSize:16.0];
    [revisePWButton addSubview:revisePWLabel];
    
    UIImageView *lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(36 * wScale, CGRectGetMaxY(revisePWButton.frame), 568 * wScale, 1 * hScale)];
    lineImageView.backgroundColor = LLFColorline();
    [self.MenuView addSubview:lineImageView];
    
    UIButton *logOutButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    logOutButton.frame = CGRectMake(0, CGRectGetMaxY(lineImageView.frame), CGRectGetWidth(self.MenuView.frame), 120 * hScale);
    [logOutButton addTarget:self action:@selector(logOutButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    logOutButton.backgroundColor = [UIColor clearColor];
    [self.MenuView addSubview:logOutButton];
    
    UIImageView *logOutIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(36 * wScale, 40 * hScale, 40 * wScale, 40 * wScale)];;
    logOutIconImageView.image = [UIImage imageNamed:@"icon_tuichudenglu"];
    [logOutButton addSubview:logOutIconImageView];
    
    UILabel *logOutLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(logOutIconImageView.frame) + 32 * wScale, 44 * hScale, CGRectGetWidth(self.MenuView.frame) - 108 * wScale, 32 * hScale)];
    logOutLabel.text = @"退出登录";
    logOutLabel.textColor = [UIColor hexString:@"#FF666666"];
    logOutLabel.font = [UIFont systemFontOfSize:16.0];
    [logOutButton addSubview:logOutLabel];
    
}
- (void)setMessageNum:(NSInteger)messageNum
{
    _messageNum = messageNum;
    [self.tableView reloadData];
}
//隐藏侧边栏
- (void)backButtonAction:(UIButton *)sender
{
    NSLog(@"隐藏侧边栏");
    [UIView animateWithDuration:0.2 animations:^{
        self.MenuView.frame = CGRectMake(kWidth, 0, 640 * wScale, kHeight);
    } completion:^(BOOL finished) {
        [self removePopViewFromWinder];
    }];
}
#pragma mark 显示侧边栏
- (void)showRightmenuView
{
    [self addPopViewToWinder];
    [UIView animateWithDuration:0.2 animations:^{
        self.MenuView.frame = CGRectMake(kWidth - 640 * wScale, 0, 640 * wScale, kHeight);
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark 退出
- (void)logOutButtonAction:(UIButton *)sender
{
    NSLog(@"退出登录");
    [self backButtonAction:nil];
    if (_delegate && [_delegate respondsToSelector:@selector(sendButtonState:)]) {
        [self.delegate sendButtonState:@"logOut"];
    }
}
- (void)revisePWButtonAction:(UIButton *)sender
{
    NSLog(@"忘记密码");
    [self backButtonAction:nil];
    if (_delegate && [_delegate respondsToSelector:@selector(sendButtonState:)]) {
        [self.delegate sendButtonState:@"revisePW"];
    }
}
#pragma tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112 * hScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLFRightMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    
    NSString* imageName=[self.imageArray objectAtIndex:indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:imageName];
    cell.titleLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    if (indexPath.row == 1) {
        cell.tipMessageNumLabel.text = [NSString stringWithFormat:@"%ld",self.messageNum];
    }
    else{
        cell.tipMessageImageView.hidden=YES;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(sendButtonState:)]) {
        [self backButtonAction:nil];
        [self.delegate sendButtonState:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self backButtonAction:nil];
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
