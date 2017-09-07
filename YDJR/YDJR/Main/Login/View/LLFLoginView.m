//
//  LLFLoginView.m
//  YDJR
//
//  Created by 吕利峰 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFLoginView.h"

@implementation LLFLoginView
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
    UIImageView *itemBGImageView = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    itemBGImageView.image = [UIImage imageNamed:@"loginBg"];
    itemBGImageView.backgroundColor = [UIColor redColor];
    itemBGImageView.userInteractionEnabled = YES;
    [self addSubview:itemBGImageView];
    
    UIView* bgView=[[UIView alloc] initWithFrame:CGRectMake(670*wScale, 134*hScale, 708*wScale, 570*hScale)];
    bgView.backgroundColor=[UIColor hexString:@"#4DFFFFFF"];
    [itemBGImageView addSubview:bgView];
    
    UIView* inputBGView=[[UIView alloc] initWithFrame:CGRectMake(10*wScale, 10*hScale, CGRectGetWidth(bgView.frame) - 20 * wScale, CGRectGetHeight(bgView.frame) - 20 * hScale)];
    inputBGView.backgroundColor=[UIColor hexString:@"#FFFFFFFF"];
//    inputBGView.layer.borderWidth=10*wScale;
//    inputBGView.layer.borderColor=[UIColor hexString:@"665D5F"].CGColor;
    [bgView addSubview:inputBGView];
    
    
    UILabel* inputTitleLabel=[[UILabel alloc] initWithFrame:CGRectMake(286*wScale, 32*hScale, 136*wScale, 34*hScale)];
    inputTitleLabel.text=@"员工登录";
    inputTitleLabel.backgroundColor=[UIColor clearColor];
    inputTitleLabel.textColor=[UIColor hexString:@"#FF666666"];
    inputTitleLabel.font=[UIFont systemFontOfSize:16];
    [inputBGView addSubview:inputTitleLabel];
    
    {
        UIView* usernameBgview=[[UIView alloc] initWithFrame:CGRectMake(64*wScale, 88*hScale, 580*wScale, 112*hScale)];
        usernameBgview.backgroundColor=[UIColor hexString:@"#FFFFFFFF"];
        [inputBGView addSubview:usernameBgview];
        
        UIView*lineview1=[[UIView alloc] initWithFrame:CGRectMake(0, 111*hScale, 580*wScale, 1)];
        lineview1.backgroundColor=[UIColor blackColor];
        [usernameBgview addSubview:lineview1];
        
        
        UIImageView *bGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 * wScale, 38 * hScale, 36 * wScale, 36 * hScale)];
        bGImageView.image = [UIImage imageNamed:@"icon_usename"];
        [usernameBgview addSubview:bGImageView];
        
        
        self.userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(60 * wScale, 0, 520 * wScale, 112 * hScale)];
        self.userNameTextField.backgroundColor = [UIColor clearColor];
        self.userNameTextField.placeholder = @"请输入用户名";
        self.userNameTextField.font = [UIFont systemFontOfSize:16.0];
        self.userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [usernameBgview addSubview:self.userNameTextField];

    }
    
    {
        UIView* passwordBgview=[[UIView alloc] initWithFrame:CGRectMake(64*wScale, 200*hScale, 580*wScale, 112*hScale)];
        passwordBgview.backgroundColor=[UIColor hexString:@"#FFFFFFFF"];
        [inputBGView addSubview:passwordBgview];
        
        UIView*lineview2=[[UIView alloc] initWithFrame:CGRectMake(0, 111*hScale, 580*wScale, 1)];
        lineview2.backgroundColor=[UIColor darkGrayColor];
        [passwordBgview addSubview:lineview2];
        
        UIImageView *itemLogoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0 * wScale, 38 * hScale, 36 * wScale, 36 * hScale)];
        itemLogoImageView.image = [UIImage imageNamed:@"icon_password"];
        [passwordBgview addSubview:itemLogoImageView];
        
        
        self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(60 * wScale, 0, 520 * wScale, 112 * hScale)];
        self.passwordTextField.backgroundColor = [UIColor clearColor];
        self.passwordTextField.placeholder = @"请输入密码";
        self.passwordTextField.secureTextEntry = YES;
        self.passwordTextField.font = [UIFont systemFontOfSize:16.0];
        [passwordBgview addSubview:self.passwordTextField];

        
    }
    
    
    
    
    //
    //    UIView *loginBGView = [[UIView alloc]initWithFrame:CGRectMake(60 * wScale, 210 * hScale, 708 * wScale, 197 * hScale)];
    //    loginBGView.backgroundColor = [UIColor whiteColor];
    //    [bGImageView addSubview:loginBGView];
    //
//        self.userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(32 * wScale, 0, 676 * wScale, 98 * hScale)];
//        self.userNameTextField.backgroundColor = [UIColor clearColor];
//        self.userNameTextField.placeholder = @"用户名";
//        self.userNameTextField.font = [UIFont systemFontOfSize:15.0];
//        self.userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//        [loginBGView addSubview:self.userNameTextField];
    //
    //    UIImageView *midLineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(self.userNameTextField.frame), CGRectGetWidth(loginBGView.frame) - 32 * wScale, 1 * hScale)];
    //    midLineImageView.image = [UIImage imageNamed:@"line_cell_short"];
    //    [loginBGView addSubview:midLineImageView];
    //
//        self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userNameTextField.frame), CGRectGetMaxY(midLineImageView.frame), CGRectGetWidth(self.userNameTextField.frame), CGRectGetHeight(self.userNameTextField.frame))];
//        self.passwordTextField.backgroundColor = [UIColor clearColor];
//        self.passwordTextField.placeholder = @"密码";
//        self.passwordTextField.secureTextEntry = YES;
//        self.passwordTextField.font = [UIFont systemFontOfSize:15.0];
//        [loginBGView addSubview:self.passwordTextField];
    //
    
    
    
    
    
        self.loginButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.loginButton.frame = CGRectMake(64 * wScale,  376 * hScale, 580 * wScale, 88 * hScale);
        [self.loginButton setBackgroundImage:[UIImage imageNamed:@"btn_normal_denglu"] forState:(UIControlStateNormal)];
        [self.loginButton setBackgroundImage:[UIImage imageNamed:@"btn_pressed_denglu"] forState:(UIControlStateSelected)];
        [self.loginButton setTitle:@"登录" forState:(UIControlStateNormal)];
        [self.loginButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.loginButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [inputBGView addSubview:self.loginButton];
    
        //登录时自动弹出键盘
        [self.userNameTextField becomeFirstResponder];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
