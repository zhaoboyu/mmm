//
//  ChangePasswordView.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "ChangePasswordView.h"
#import "WPQCarGroupViewController.h"
#import "LLFPersonCenterPopView.h"

#define wid self.frame.size.width
#define heig self.frame.size.height
@interface ChangePasswordView()<UITextFieldDelegate>{
    UIView *titleView;
    CGFloat off_Y;
    UITextField* originalPasswordField;
    UITextField* newPasswordField;
    UITextField* turePasswordField;
    
}
@property(nonatomic,strong)UIButton *changeButton;
@property (nonatomic,strong)HGBPromgressHud *phud;
@end

@implementation ChangePasswordView
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        {
            
            UIView* view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, wid, 96*hScale)];
            view.backgroundColor=[UIColor hex:@"#FFFFFF"];
            //            view.backgroundColor=[UIColor redColor];
            [self addSubview:view];
            titleView=view;
            
            
            UILabel* title=[[UILabel alloc] initWithFrame:CGRectMake(566*wScale, 31*hScale, 200*wScale, 30*hScale)];
            title.text=@"修改密码";
            title.font=[UIFont systemFontOfSize:17];
            title.textAlignment=NSTextAlignmentCenter;
            title.textColor=[UIColor hex:@"#333333"];
            title.center=CGPointMake(self.frame.size.width/2, view.centerY);
            [view addSubview:title];
            

            
            UIView* lineView=[[UIView alloc] initWithFrame:CGRectMake(0, view.size.height-1, wid, 1)];
            lineView.backgroundColor=[UIColor hex:@"#D9D9D9"];
            [view addSubview:lineView];
            
            
            off_Y=CGRectGetMaxY(view.frame);
        }
        
        {
            UILabel *oldPassword = [[UILabel alloc]initWithFrame:CGRectMake(15, off_Y+ 39*hScale, 32*wScale +85, 112*hScale)];
            oldPassword.text = @"原始密码";
            oldPassword.backgroundColor = [UIColor whiteColor];
            oldPassword.textColor = [UIColor blackColor];
            oldPassword.textAlignment = NSTextAlignmentLeft;
            oldPassword.font = [UIFont systemFontOfSize:15];
            [self addSubview:oldPassword];
            
            originalPasswordField=[[UITextField alloc] initWithFrame:CGRectMake(32*wScale +100, off_Y+ 39*hScale, wid - 32*wScale-100, 112*hScale)];
            originalPasswordField.placeholder=@"请输入原登录密码";
             [originalPasswordField addTarget:self action:@selector(textchange) forControlEvents:UIControlEventAllEditingEvents];
            originalPasswordField.delegate =self;
            originalPasswordField.backgroundColor = [UIColor whiteColor];
            originalPasswordField.font=[UIFont systemFontOfSize:17];
            originalPasswordField.secureTextEntry = YES;
            [self addSubview:originalPasswordField];
            
            UIView* lineView=[[UIView alloc] initWithFrame:CGRectMake(15, originalPasswordField.size.height + originalPasswordField.frame.origin.y, wid, 1)];
            lineView.backgroundColor=[UIColor hex:@"#D9D9D9"];
            [self addSubview:lineView];
            off_Y=CGRectGetMaxY(lineView.frame);
        }
        
        {
            UILabel *newPassword = [[UILabel alloc]initWithFrame:CGRectMake(15,39*hScale+off_Y, 32*wScale +85, 112*hScale)];
            newPassword.text = @"新密码";
            newPassword.backgroundColor = [UIColor whiteColor];
            newPassword.textColor = [UIColor blackColor];
            newPassword.textAlignment = NSTextAlignmentLeft;
            newPassword.font = [UIFont systemFontOfSize:15];
            [self addSubview:newPassword];
            
            newPasswordField=[[UITextField alloc] initWithFrame:CGRectMake(32*wScale +100, 39*hScale+off_Y, wid - 32*wScale-100, 112*hScale)];
            newPasswordField.placeholder=@"请输入新密码";
            [newPasswordField addTarget:self action:@selector(textchange) forControlEvents:UIControlEventAllEditingEvents];
            newPasswordField.font=[UIFont systemFontOfSize:17];
            newPasswordField.secureTextEntry = YES;
            [self addSubview:newPasswordField];
            
            
            UIView* lineView=[[UIView alloc] initWithFrame:CGRectMake(15, newPasswordField.size.height + newPasswordField.frame.origin.y, wid, 1)];
            lineView.backgroundColor=[UIColor hex:@"#D9D9D9"];
            [self addSubview:lineView];
            off_Y=CGRectGetMaxY(lineView.frame);
        }
        
        {
            UILabel *SurePassword = [[UILabel alloc]initWithFrame:CGRectMake(15,39*hScale+off_Y, 32*wScale +85, 112*hScale)];
            SurePassword.text = @"确认密码";
            SurePassword.backgroundColor = [UIColor whiteColor];
            SurePassword.textColor = [UIColor blackColor];
            SurePassword.textAlignment = NSTextAlignmentLeft;
            SurePassword.font = [UIFont systemFontOfSize:15];
            [self addSubview:SurePassword];
            
            turePasswordField=[[UITextField alloc] initWithFrame:CGRectMake(32*wScale +100, 39*hScale+off_Y, wid - 32*wScale-100, 112*hScale)];
            turePasswordField.placeholder=@"确认密码";
           turePasswordField.delegate =self;
   [turePasswordField addTarget:self action:@selector(textchange) forControlEvents:UIControlEventAllEditingEvents];
            turePasswordField.font=[UIFont systemFontOfSize:17];
            turePasswordField.secureTextEntry = YES;
            [self addSubview:turePasswordField];
            
            UIView* lineView=[[UIView alloc] initWithFrame:CGRectMake(15, turePasswordField.size.height + turePasswordField.frame.origin.y, wid, 1)];
            lineView.backgroundColor=[UIColor hex:@"#D9D9D9"];
            [self addSubview:lineView];
            off_Y=CGRectGetMaxY(lineView.frame);
        }
                    UIButton *changeButton=[UIButton buttonWithType:UIButtonTypeCustom];
                    [changeButton setTitle:@"保存" forState:UIControlStateNormal];
                    [changeButton setTitleColor:[UIColor hex:@"#ffffff"]];
        changeButton.backgroundColor = [UIColor hex:@"#d9d9d9"];
                    changeButton.titleLabel.font=[UIFont systemFontOfSize:16];
                    changeButton.frame=CGRectMake((wid -400*wScale)/2 ,off_Y + 120*hScale , 400*wScale, 80*hScale);
        changeButton.userInteractionEnabled = NO;
                    [changeButton addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        self.changeButton = changeButton;
                    [self addSubview:changeButton];
        
    }
    return self;
}
- (void)textchange{
    if (turePasswordField.text.length>0&&originalPasswordField.text.length>0&&newPasswordField.text.length>0) {
        self.changeButton.backgroundColor = [UIColor hexString:@"#333333"];
        self.changeButton.userInteractionEnabled = YES;
    }else{
        self.changeButton.backgroundColor = [UIColor hexString:@"d9d9d9"];
        self.changeButton.userInteractionEnabled = NO;
    }
}

-(void)btAction:(id)sender{
        NSLog(@"确认修改");
        [originalPasswordField resignFirstResponder];
        [newPasswordField resignFirstResponder];
        [turePasswordField resignFirstResponder];
        
        NSString *userName = [Tool getKeychainStringWithKey:UserName];
        NSString *password = [Tool getKeychainStringWithKey:Password];
        __weak typeof(self) weakSelf = self;
        if ([originalPasswordField.text isEqualToString:password]) {
            if ([newPasswordField.text isEqualToString:turePasswordField.text]) {
                [self.phud showHUDSaveAddedTo:self];
                [[CTTXRequestServer shareInstance] revisePassworderWithUserName:userName NewPassworder:newPasswordField.text SuccessBlock:^(BOOL state) {
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
    
    UserDataModel *userModel = [UserDataModel sharedUserDataModel];
    [userModel logOut];
    LLFLoginViewController *loginVC = [[LLFLoginViewController alloc]init];
    [self.VC presentViewController:loginVC animated:YES completion:^{}];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [originalPasswordField resignFirstResponder];
    [newPasswordField resignFirstResponder];
    [turePasswordField resignFirstResponder];
}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    [self.messageDelegate password];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
