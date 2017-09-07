//
//  ZBYPersonViewController.m
//  YDJR
//
//  Created by 赵博宇 on 2017/5/4.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "ZBYPersonViewController.h"
#import "ZBYPersonalDetailsView.h"
#import "MessageCenter.h"
#import "ChangePasswordView.h"
#import "LLFFeedbackView.h"
#import "LLFAboutView.h"
#import "MessageCenterViewModel.h"
#import "ZBYPersonNewTableViewCell.h"
#define LeftW 648/2
@interface ZBYPersonViewController ()<UITableViewDelegate,UITableViewDataSource,messageCountReload,messageMessageCountReload,passwordMessageCountReload,feedMessageCountReload,aboutMessageCountReload>
@property(nonatomic,strong)UITableView *leftView;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSArray *iconNameArr;
@property(nonatomic,strong)ZBYPersonalDetailsView *personalView;
@property(nonatomic,strong)MessageCenter* center;
@property(nonatomic,strong)ChangePasswordView* change;
@property(nonatomic,strong)LLFFeedbackView *feedbackView;
@property(nonatomic,strong)LLFAboutView *aboutView;
@property(nonatomic,strong)UILabel *messageLabel;
@property(nonatomic,assign)NSInteger whichTouch;

@end

@implementation ZBYPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

  
    //设置背景色
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor hex:@"#FF333333"];

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_Nav"] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.title = @"我的";
    NSMutableDictionary *titleAttributesDic = [NSMutableDictionary dictionary];
    [titleAttributesDic setObject:[UIColor hexString:@"#FFFFFFFF"] forKey:NSForegroundColorAttributeName];
    [titleAttributesDic setObject:[UIFont systemFontOfSize:18.0] forKey:NSFontAttributeName];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributesDic];
    
    NSArray *arr = [NSArray arrayWithObjects:@"消息中心",@"修改密码",@"意见反馈",@"关于我们",nil];
    self.titleArr = arr;
         self.iconNameArr = [NSArray arrayWithObjects:@"MessageCenter",@"Password",@"Feedback",@"About", nil];
    [self initView];
    self.whichTouch = 0;
   self.center=[[MessageCenter alloc] initWithFrame:CGRectMake(LeftW,20, [[UIScreen mainScreen]bounds].size.width -LeftW, [[UIScreen mainScreen]bounds].size.height)];
    self.center.messageDelegate = self;
    [self.view addSubview:_center];
   self.change=[[ChangePasswordView alloc] initWithFrame:CGRectMake(LeftW,20, [[UIScreen mainScreen]bounds].size.width -LeftW, [[UIScreen mainScreen]bounds].size.height)];
    self.change.messageDelegate = self;
    self.change.VC = self;
    [self.view addSubview:_change];
   self.feedbackView = [[LLFFeedbackView alloc]initWithFrame:CGRectMake(LeftW,20, [[UIScreen mainScreen]bounds].size.width -LeftW, [[UIScreen mainScreen]bounds].size.height)];
    self.feedbackView.messageDelegate = self;
    [self.view addSubview:_feedbackView];
    self.aboutView = [[LLFAboutView alloc]initWithFrame:CGRectMake(LeftW,20, [[UIScreen mainScreen]bounds].size.width -LeftW, [[UIScreen mainScreen]bounds].size.height)];
    self.aboutView.messageDelegate = self;
    [self.view addSubview:_aboutView];
    self.personalView = [[ZBYPersonalDetailsView alloc]initWithFrame:CGRectMake(LeftW, 0, [[UIScreen mainScreen]bounds].size.width -LeftW, [[UIScreen mainScreen]bounds].size.height)];
    self.personalView.messageDelegate = self;
    self.personalView.VC = self;
    [self.view addSubview:_personalView];
    //注册通知,接受新消息通知更新界面


   
}
- (void)loadNewMessage{
    [super loadNewMessage];
    NSArray *messageTypeNumArr = [MessageCenterViewModel queryMessageTypesNum];
    
    if (messageTypeNumArr.count > 2) {
        
        NSInteger cc =[messageTypeNumArr[0] integerValue] +[messageTypeNumArr[1] integerValue] + [messageTypeNumArr[2] integerValue];
        self.messageCount = [NSString stringWithFormat:@"%ld",cc];
    }
    }
- (void)setMessageCount:(NSString *)messageCount
{
    _messageCount = messageCount;
    
    [self.leftView reloadData];
    
}
- (void)initView{
    [self.view addSubview:self.leftView];
}
-(UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LeftW, [[UIScreen mainScreen]bounds].size.height)style:UITableViewStylePlain];
        _leftView.delegate = self;
        _leftView.dataSource = self;
          [_leftView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_leftView registerNib:[UINib nibWithNibName:@"ZBYPersonNewTableViewCell" bundle:nil] forCellReuseIdentifier:@"ZBYPersonNewTableViewCell"];
         _leftView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftView.backgroundColor = [UIColor hex:@"#f2f2f2"];
        _leftView.scrollEnabled = NO;
    }
    return _leftView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    ZBYPersonNewTableViewCell *cell;
 
    cell.backgroundColor =  [UIColor hex:@"#EFEFF4"];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    if (indexPath.row != 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ZBYPersonNewTableViewCell"];

        cell.textnewLabel.textColor =[UIColor hexString:indexPath.row==self.whichTouch?@"#333333":@"#999999"];
        
        cell.seletedImage.image = [UIImage imageNamed:indexPath.row==self.whichTouch?[NSString stringWithFormat:@"%@_",self.iconNameArr[indexPath.row-1]]:self.iconNameArr[indexPath.row-1]];
        cell.textnewLabel.text =self.titleArr[indexPath.row -1] ;
        cell.messageLabel.hidden = YES;
        if (indexPath.row ==1) {
            cell.messageLabel.textAlignment = NSTextAlignmentCenter;
            cell.messageLabel.text =[self.messageCount integerValue]>99?@"99+":self.messageCount;
            if ([self.messageCount integerValue]<1) {
                 cell.messageLabel.hidden = YES;
            }else{
                 cell.messageLabel.hidden = NO;
                if ([self.messageCount integerValue]<10) {
                    cell.redWidth.constant = 16;
                }
            }
        }
    }else{
          cell =(UITableViewCell *)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
        
        UILabel *maintext= [[UILabel alloc]initWithFrame:CGRectMake(230*wScale, 40*hScale,LeftW-230*wScale, 56*hScale)];
        maintext.text = [UserDataModel sharedUserDataModel].userDesc;
        maintext.font = [UIFont systemFontOfSize:20];
        maintext.textColor = [UIColor hexString:@"#333333"];
        [cell.contentView addSubview:maintext];
     
        LLFUserRoleModel *role =[UserDataModel sharedUserDataModel].roles[0];
        UILabel *detailtext= [[UILabel alloc]initWithFrame:CGRectMake(230*wScale, 110*wScale,LeftW-30*wScale, 40*wScale)];
        detailtext.text =role.roleName;
        detailtext.font = [UIFont systemFontOfSize:14];
        detailtext.textColor = [UIColor hexString:@"#999999"];
        [cell.contentView addSubview:detailtext];
        UIView *lineView= [[UIView alloc]initWithFrame:CGRectMake(40, indexPath.row==0?89:59, LeftW-40, 1)];
        lineView.backgroundColor = [UIColor hex:@"#d9d9d9"];
        [cell.contentView addSubview:lineView];
        
        UIImageView *iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(80*wScale, 30*hScale, 120*wScale, 120*wScale)];
        iconImage.layer.cornerRadius = 4;
        iconImage.clipsToBounds =YES;
        [iconImage sd_setImageWithURL:[Tool pinjieUrlWithImagePath:[UserDataModel sharedUserDataModel].headpic] placeholderImage:[UIImage imageNamed:@"PlaceIcon"]];
        iconImage.layer.borderWidth=1.0 *wScale;
        iconImage.layer.borderColor=[[UIColor grayColor] CGColor];
        [cell.contentView addSubview:iconImage];
    }
    if (indexPath.row==self.whichTouch) {
        cell.contentView.backgroundColor = [UIColor hex:@"#d9d9d9"];
    }else{
        cell.contentView.backgroundColor = [UIColor hex:@"#f2f2f2"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row !=0) {
        return 60;
    }
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
//
//    UITableViewCell *cell= [self.leftView cellForRowAtIndexPath:indexPath];
//    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_",self.iconNameArr[indexPath.row-1]]];
//
    self.whichTouch = indexPath.row;
        switch (indexPath.row) {
                case 0:
            {
                [self.view bringSubviewToFront:_personalView];
            }
                break;
            case 1:
                //消息中心
            {
                [self.view bringSubviewToFront:_center];
                
            }
                
                break;
            case 2:
                //修改密码
            {
                [self.view bringSubviewToFront:_change];
            }
                break;
            case 3:
                //意见反馈
            {
                [self.view bringSubviewToFront:_feedbackView];
            }
                break;
            case 4:
                //关于
            {
                [self.view bringSubviewToFront:_aboutView];
               
            }
                break;
                
            default:
                break;
        }
    [self.leftView reloadData];
    
}
-(void)messageCountReload{
    NSArray *messageTypeNumArr = [MessageCenterViewModel queryMessageTypesNum];
    if (messageTypeNumArr.count > 3) {
        self.messageCount = messageTypeNumArr[3];
    }
    [self loadNewMessage];
    [self.leftView reloadData];
    
}
-(void)message{
    [self messageCountReload];
}
- (void)password{
    [self messageCountReload];
}
- (void)feedBack{
    [self messageCountReload];
    self.feedbackView = [[LLFFeedbackView alloc]initWithFrame:CGRectMake(LeftW,20, [[UIScreen mainScreen]bounds].size.width -LeftW, [[UIScreen mainScreen]bounds].size.height)];
    self.feedbackView.messageDelegate = self;
    [self.view addSubview:_feedbackView];
   
}
- (void)about{
    [self messageCountReload];
}

@end
