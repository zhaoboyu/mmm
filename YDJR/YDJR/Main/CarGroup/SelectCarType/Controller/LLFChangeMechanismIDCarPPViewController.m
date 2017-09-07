//
//  LLFChangeMechanismIDCarPPViewController.m
//  YDJR
//
//  Created by 吕利峰 on 2017/6/22.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFChangeMechanismIDCarPPViewController.h"
#import "ZBYBrandSelectTableViewCell.h"
@interface LLFChangeMechanismIDCarPPViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation LLFChangeMechanismIDCarPPViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setDataArr:(NSMutableArray *)dataArr
{
    CGRect frame = self.view.bounds;
    frame.size.height = (dataArr.count > 5) ? (500 * hScale) : (100 * dataArr.count * hScale);
    _dataArr = dataArr;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 106*wScale, self.view.frame.size.width, self.view.frame.size.height-106*wScale)];
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ZBYBrandSelectTableViewCell class] forCellReuseIdentifier:@"ZBYBrandSelectTableViewCell"];
    
    //    self.selectTable.scrollEnabled = [UserDataModel sharedUserDataModel].ppName.count>5?YES:NO;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZBYBrandSelectTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ZBYBrandSelectTableViewCell"];
    [cell cell:self.dataArr[indexPath.row] selected:NO];
//    [cell cell:[self.dataArr[indexPath.row] objectForKey:@"ppName"] selected:indexPath.row==self.whichSelected?YES:NO ];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*wScale;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isFirst) {
        LLFChangeMechanismIDCarPPViewController *changVC = [[LLFChangeMechanismIDCarPPViewController alloc]init];
        
    }
//    NSMutableArray *ppnameMuatable = [NSMutableArray array];
//    for (int i =0;i <[UserDataModel sharedUserDataModel].ppName.count;i++) {
//        [ppnameMuatable addObject:[UserDataModel sharedUserDataModel].ppName[i]];
//    }
//    [ppnameMuatable exchangeObjectAtIndex:0 withObjectAtIndex:indexPath.row?indexPath.row:0];
//    [UserDataModel sharedUserDataModel].ppName =ppnameMuatable;
//    
//    self.whichSelected = indexPath.row;
//    [self.selectTable reloadData];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:0.3 animations:^{
//            self.alpha = 0;
//            
//        } completion:^(BOOL finished) {
//            @autoreleasepool {
//                [self removeFromSuperview];
//            }
//            
//        }];
//        
//        [self.brandDelegate brandSelected];
//    });
    
    
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
