//
//  YDJRBaseViewController.m
//  YDJR
//
//  Created by 赵博宇 on 2017/7/11.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "YDJRBaseViewController.h"
#import "MessageCenterViewModel.h"
@interface YDJRBaseViewController ()

@end

@implementation YDJRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewMessage];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadNewMessage) name:@"loadMessage" object:@"loadMessage"];
   
}

- (void)loadNewMessage{
    NSArray *messageTypeNumArr = [MessageCenterViewModel queryMessageTypesNum];
    NSString *messageCount;
    if (messageTypeNumArr.count > 2) {
        
        NSInteger cc =[messageTypeNumArr[0] integerValue] +[messageTypeNumArr[1] integerValue] + [messageTypeNumArr[2] integerValue];
        messageCount = [NSString stringWithFormat:@"%ld",cc];
    }
    if ([messageCount integerValue] >0) {
        [[[[[self tabBarController] tabBar] items] objectAtIndex:4] setBadgeValue:messageCount];

    }else{
        [[[[self tabBarController] tabBar] items] objectAtIndex:4].badgeValue = nil;
    }
  }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
