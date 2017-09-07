//
//  MessageViewController.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/10/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "MessageModel.h"
#import "MessageView.h"
@interface MessageViewController ()
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray* dataArray;
@end

@implementation MessageViewController
#define MCell @"MessageCell"
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"消息中心";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    self.tableView.backgroundColor = [UIColor clearColor];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor=[UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:MCell];
    
    
    
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    [self.view addSubview:self.tableView];
    
    
    

    
    self.dataArray=[NSMutableArray array];
    for (int i=0; i<10; i++) {
        MessageModel* model=[MessageModel new];
        model.title=@"重要通知";
        model.content=@"中新网北京10月28日电（吕春荣）今日起，黑龙江2017年高招报名工作正式开始。近期，全国多个省份相继公布了2017年高考报名时间，其中，北京、辽宁等省份集中在11月份。值得一提的是，针对随迁子女的高考报名门槛，各地也明确了相关标准。近年来，随着“异地高考”政策的全面推开，“高考移民”也开始有了一些新动向，诸如出现了伪造学籍、空挂学籍等问题。那么，如何为符合条件的随迁子女异地高考亮绿灯，如何进一步防范、打击“高考移民”，一直是舆论关注的焦点。此前，2014年发布的《国务院关于深化考试招生制度改革的实施意见》就明确，进一步落实和完善进城务工人员随迁子女就学和升学考试的政策措施。今年3月，教育部、公安部联合下发了《关于做好综合治理“高考移民”工作的通知》，出台多项措施和要求，对新形势下打击投机性的“高考移民”做了明确部署。地要求父母合法职业、稳定住所虽然各地随迁子女高考报名的门槛各有不同，不过，中新网（微信公众号：cns2012）记者梳理发现，北京、辽宁等多个省份均针对学生学籍以及父母合法职业、稳定住所（租赁）做出规定。诸如，黑龙江规定，非本省户籍的进城务工人员随迁子女参加高考报名，须具有本省高中学籍且高级中学阶段在本省连续实际就读3年以上，父母在本省有合法职业和合法稳定住所（含租赁）。辽宁也规定：在我省高中阶段有三年学籍，并有完整学习经历（须具有我省高中阶段学校初始注册学籍）。父母在我省具有合法稳定职业和合法稳定住所（含租赁）。";
        [self.dataArray addObject:model];
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
    return 200 * hScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:MCell forIndexPath:indexPath];
    MessageModel* model=[self.dataArray objectAtIndex:indexPath.row];
    cell.titleLabel.text=model.title;
    cell.contentLabel.text=model.content;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel* model=[self.dataArray objectAtIndex:indexPath.row];
    MessageView* view=[[MessageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, self.view.frame.size.height)];
    view.Important=YES;
    view.contentStr=model.content;
    [self.view addSubview:view];
}


#pragma mark - tableViewDelegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
