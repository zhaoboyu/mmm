//
//  SDCOverApplicationController.m
//  YDJR
//
//  Created by sundacheng on 16/11/1.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDCOverApplicationController.h"
#import "CTTXRequestServer+CustomerManager.h"

@interface SDCOverApplicationController ()

//申请书
@property (nonatomic, strong) UIImageView *imgView;

//撤回按钮
@property (nonatomic, strong) UIButton *clickBtn;

//加载框
@property (nonatomic, strong) MBProgressHUD *progress;

@end

@implementation SDCOverApplicationController

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.clickBtn];
}

#pragma mark - action
- (void)cancelApplyAction {
    
    NSLog(@"%@ %@",self.intentID,self.productID);
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您正在撤回申请，是否继续当前操作？" preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf cancelApi];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVc addAction:confirmAction];
    [alertVc addAction:cancelAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)cancelApi {
    self.progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    self.progress.userInteractionEnabled = NO;
    [[CTTXRequestServer shareInstance] stateChangeWithApproveStatus:@"05" intentID:self.intentID productID:self.productID SuccessBlock:^(NSString *code, NSString *msg) {
        if (code.intValue == 0) {
            [self.progress hide:YES];
            
        } else {
            [self.progress hide:YES];;
            self.progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
            self.progress.detailsLabelText = msg;
            self.progress.labelText = @"提示";
            self.progress.userInteractionEnabled = NO;
            self.progress.mode = MBProgressHUDModeText;
            [self.progress hide:YES afterDelay:2];
        }
        
    } failedBlock:^(NSError *error) {
        [self.progress hide:YES];;
        self.progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        self.progress.detailsLabelText = @"服务器异常";
        self.progress.labelText = @"提示";
        self.progress.userInteractionEnabled = NO;
        self.progress.mode = MBProgressHUDModeText;
        [self.progress hide:YES afterDelay:2];
    }];
}

#pragma mark - getter and setter
- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 30, kWidth - 100, kHeight - 50 - 50 - 100)];
        _imgView.backgroundColor = [UIColor orangeColor];
    }
    return _imgView;
}

- (UIButton *)clickBtn {
    if (_clickBtn == nil) {
        _clickBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 45)];
        _clickBtn.top = self.imgView.bottom + 20;
        _clickBtn.centerX = kWidth/2;
        [_clickBtn setTitle:@"撤回申请" forState:UIControlStateNormal];
        [_clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _clickBtn.layer.borderWidth = 0.5;
        _clickBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _clickBtn.layer.cornerRadius = 5;
        _clickBtn.layer.masksToBounds = YES;
        
        _clickBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        
        _clickBtn.backgroundColor = [UIColor whiteColor];
        
        [_clickBtn addTarget:self action:@selector(cancelApplyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickBtn;
}


@end
