//
//  RevisePassworderPopView.m
//  YDJR
//
//  Created by 吕利峰 on 16/11/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "RevisePassworderPopView.h"
#import "CTTXRequestServer+Login.h"
#define reviseWidth 860 * wScale
#define reviseHight 780 * hScale
@interface RevisePassworderPopView ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (nonatomic,strong)UIView *reviseView;
@property (nonatomic,strong)UIButton *colseButton;

@property (nonatomic,strong)UITextField *oldPWTextField;
@property (nonatomic,strong)UITextField *onePWTextField;
@property (nonatomic,strong)UITextField *twoPWTextField;

@property (nonatomic,strong)UIButton *revisePWButton;

@property (nonatomic,strong)HGBPromgressHud *phud;
@end

@implementation RevisePassworderPopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hexString:@"#4D000000"];
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    
    self.reviseView = [[UIView alloc]initWithFrame:CGRectMake(kWidth / 2 - reviseWidth / 2, kHeight, reviseWidth, reviseHight)];
    self.reviseView.backgroundColor = [UIColor hex:@"#FFF0F1F5"];
    self.reviseView.layer.cornerRadius = 5;
    [self addSubview:self.reviseView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.reviseView.frame), 98 * hScale)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.reviseView addSubview:topView];
    
    self.colseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.colseButton.frame = CGRectMake(0, 0, 128 * wScale, CGRectGetHeight(topView.frame));
    [self.colseButton setTitle:@"关闭" forState:(UIControlStateNormal)];
    [self.colseButton setTitleColor:[UIColor hex:@"#FF666666"] forState:(UIControlStateNormal)];
    self.colseButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.colseButton addTarget:self action:@selector(backButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.reviseView addSubview:self.colseButton];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.colseButton.frame), 0, CGRectGetWidth(self.reviseView.frame) - CGRectGetWidth(self.colseButton.frame) * 2, CGRectGetHeight(topView.frame))];
    titleLabel.text = @"修改密码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18.0];
//    titleLabel.backgroundColor = [UIColor redColor];
    [self.reviseView addSubview:titleLabel];
    
    UIView *oneBGView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame) + 24 * hScale, CGRectGetWidth(topView.frame), CGRectGetHeight(topView.frame))];
    oneBGView.backgroundColor = [UIColor whiteColor];
    [self.reviseView addSubview:oneBGView];
    
    self.oldPWTextField = [[UITextField alloc]initWithFrame:CGRectMake(32 * wScale, 0, CGRectGetWidth(oneBGView.frame) - 32 * wScale, CGRectGetHeight(oneBGView.frame))];
    self.oldPWTextField.delegate = self;
    self.oldPWTextField.placeholder = @"请输入原登录密码";
    self.oldPWTextField.secureTextEntry = YES;
    self.oldPWTextField.font = [UIFont systemFontOfSize:15.0];
    [oneBGView addSubview:self.oldPWTextField];
    
    UIView *twoBGView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oneBGView.frame) + 24 * hScale, CGRectGetWidth(topView.frame), CGRectGetHeight(topView.frame) * 2 + 1 * hScale)];
    twoBGView.backgroundColor = [UIColor whiteColor];
    [self.reviseView addSubview:twoBGView];
    
    self.onePWTextField = [[UITextField alloc]initWithFrame:CGRectMake(32 * wScale, 0, CGRectGetWidth(twoBGView.frame) - 32 * wScale, 98 * hScale)];
    self.onePWTextField.delegate = self;
    self.onePWTextField.placeholder = @"请输入新登录密码";
    self.onePWTextField.secureTextEntry = YES;
    self.onePWTextField.font = [UIFont systemFontOfSize:15.0];
    [twoBGView addSubview:self.onePWTextField];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(self.onePWTextField.frame), CGRectGetWidth(self.onePWTextField.frame), 1 * hScale)];
    lineView.backgroundColor = LLFColorline();
    [twoBGView addSubview:lineView];
    
    self.twoPWTextField = [[UITextField alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(lineView.frame), CGRectGetWidth(self.onePWTextField.frame), CGRectGetHeight(self.onePWTextField.frame))];
    self.twoPWTextField.delegate = self;
    self.twoPWTextField.placeholder = @"再输入一遍";
    self.twoPWTextField.secureTextEntry = YES;
    self.twoPWTextField.font = [UIFont systemFontOfSize:15.0];
    [twoBGView addSubview:self.twoPWTextField];
    
    self.revisePWButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.revisePWButton.frame = CGRectMake(32 * wScale, CGRectGetMaxY(twoBGView.frame) + 48 * hScale, CGRectGetWidth(self.reviseView.frame) - 64 * wScale, 90 * hScale);
    [self.revisePWButton setTitle:@"确认修改" forState:(UIControlStateNormal)];
    [self.revisePWButton setTitleColor:[UIColor hex:@"#FFFFFFFF"] forState:(UIControlStateNormal)];
    [self.revisePWButton setBackgroundImage:[UIImage imageNamed:@"btn_nomral_login"] forState:(UIControlStateNormal)];
    [self.revisePWButton addTarget:self action:@selector(revisePWButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.revisePWButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.reviseView addSubview:self.revisePWButton];
}

//隐藏侧边栏
- (void)backButtonAction:(UIButton *)sender
{
    NSLog(@"隐藏侧边栏");
    [UIView animateWithDuration:0.2 animations:^{
        self.reviseView.frame = CGRectMake(kWidth / 2 - reviseWidth / 2, kHeight, reviseWidth, reviseHight);
    } completion:^(BOOL finished) {
        [self removePopViewFromWinder];
    }];
}
#pragma mark 显示修改密码界面
- (void)showView
{
    [self addPopViewToWinder];
    [UIView animateWithDuration:0.2 animations:^{
        self.reviseView.frame = CGRectMake(kWidth / 2 - reviseWidth / 2, 96 * hScale, reviseWidth, reviseHight);
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark 退出
- (void)revisePWButtonAction:(UIButton *)sender
{
    NSLog(@"确认修改");
    [self.oldPWTextField resignFirstResponder];
    [self.onePWTextField resignFirstResponder];
    [self.twoPWTextField resignFirstResponder];
    
    NSString *userName = [Tool getKeychainStringWithKey:UserName];
    NSString *password = [Tool getKeychainStringWithKey:Password];
    __weak typeof(self) weakSelf = self;
    if ([self.oldPWTextField.text isEqualToString:password]) {
        if ([self.onePWTextField.text isEqualToString:self.twoPWTextField.text]) {
            [self.phud showHUDSaveAddedTo:self];
            [[CTTXRequestServer shareInstance] revisePassworderWithUserName:userName NewPassworder:self.onePWTextField.text SuccessBlock:^(BOOL state) {
                [weakSelf.phud hideSave];

                if (state) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"密码修改成功,请重新登录!" delegate:weakSelf cancelButtonTitle:@"确认" otherButtonTitles:@"取消",nil];
                    [alert show];
                }
                
            } failedBlock:^(NSError *error) {
                [weakSelf.phud hideSave];
                weakSelf.phud.promptStr = @"网络状况不好,请稍后重试!";
                [weakSelf.phud showHUDResultAddedTo:self];
            }];
        }else{
            self.phud.promptStr = @"您两次输入的密码不一致,请重新输入!";
            [self.phud showHUDResultAddedTo:self];
        }
    }else{
//        [self.phud hideSave];
        self.phud.promptStr = @"您输入的密码不正确,请重新输入!";
        [self.phud showHUDResultAddedTo:self];
    }
    
    
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self backButtonAction:nil];
    if (_delegate && [_delegate respondsToSelector:@selector(sendReviseState:)]) {
        [self.delegate sendReviseState:@"revisePW"];
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
