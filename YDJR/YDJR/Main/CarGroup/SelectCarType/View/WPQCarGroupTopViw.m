//
//  WPQCarGroupTopViw.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "WPQCarGroupTopViw.h"
#import "WPQCarGroupViewController.h"



@interface WPQCarGroupTopViw ()<brandSelected>

//@property(nonatomic,strong)UIImageView *imagebrand;



@end



@implementation WPQCarGroupTopViw

-(id)initWithFrame:(CGRect)frame{
    
    self= [super initWithFrame:frame];
    if (self) {
        
//           CGSize ppname = [[UserDataModel sharedUserDataModel].ppName.count>0?[[UserDataModel sharedUserDataModel].ppName[0] objectForKey:@"ppName"]:@""  labelAutoCalculateRectWith:[UserDataModel sharedUserDataModel].ppName.count>0?[[UserDataModel sharedUserDataModel].ppName[0] objectForKey:@"ppName"]:@"" FontSize:15];
        UIImageView *menuBGImageView = [[UIImageView alloc]initWithFrame:CGRectMake(34 * wScale, 31 * hScale, 44 * wScale, 26 * hScale)];
        menuBGImageView.image = [UIImage imageNamed:@"LLF_SelectNewCarType_Menu"];
        [self addSubview:menuBGImageView];
        self.selectBrandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectBrandBtn.frame = CGRectMake(0, 0, 100 * wScale, 64);
//        [self.selectBrandBtn setTitle:[UserDataModel sharedUserDataModel].ppName.count>0?[[UserDataModel sharedUserDataModel].ppName[0] objectForKey:@"ppName"]:@""forState:UIControlStateNormal];
//        [self.selectBrandBtn setTitleColor:[UIColor hexString:@"#333333"]];
//        self.selectBrandBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.selectBrandBtn addTarget:self action:@selector(brandBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectBrandBtn];
        
   
        
        
//        UIImageView *imagebrand = [[UIImageView alloc]initWithFrame:CGRectMake(_selectBrandBtn.frame.size.width + 40*wScale +5 , (20-14*hScale)/2+20*hScale, 24*wScale,14*hScale )];
//        imagebrand.image = [UIImage imageNamed:@"brandDownPull"];
//        [self addSubview:imagebrand];
//        self.imagebrand = imagebrand;
        
        _allButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _allButton.tag=allButtonTag;
        _allButton.frame=CGRectMake(866*wScale, 27*hScale, 68*wScale, 34*hScale);
        [_allButton setTitle:@"全部" forState:UIControlStateNormal];
        _allButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_allButton setTitleColor:[UIColor hexString:@"#999999"] forState:UIControlStateNormal];
        [_allButton setTitleColor:[UIColor hexString:@"#333333"] forState:UIControlStateSelected];
        [_allButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _allButton.selected=YES;
        [self addSubview:_allButton];
        
        _homebredButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _homebredButton.tag=homebredButtonTag;
        _homebredButton.frame=CGRectMake(990*wScale, 27*hScale, 68*wScale, 34*hScale);
        [_homebredButton setTitle:@"国产" forState:UIControlStateNormal];
        _homebredButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_homebredButton setTitleColor:[UIColor hexString:@"#999999"] forState:UIControlStateNormal];
        [_homebredButton setTitleColor:[UIColor hexString:@"#333333"] forState:UIControlStateSelected];
        [_homebredButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_homebredButton];
        
        _importButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _importButton.tag=importButtonTag;
        _importButton.frame=CGRectMake(1114*wScale, 27*hScale, 68*wScale, 34*hScale);
        [_importButton setTitle:@"进口" forState:UIControlStateNormal];
        _importButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_importButton setTitleColor:[UIColor hexString:@"#999999"] forState:UIControlStateNormal];
        [_importButton setTitleColor:[UIColor hexString:@"#333333"] forState:UIControlStateSelected];
        [_importButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_importButton];
        
        self.dafenqiApplyScanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.dafenqiApplyScanButton.frame = CGRectMake(kWidth - 77 * wScale, 22 * hScale, 44 * wScale, 44 * hScale);
        [self.dafenqiApplyScanButton addTarget:self action:@selector(dafenqiApplyScanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.dafenqiApplyScanButton setBackgroundImage:[UIImage imageNamed:@"dafenqiApplyScanButtonBgImage"] forState:(UIControlStateNormal)];
        [self addSubview:self.dafenqiApplyScanButton];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(_allButton.frame.origin.x, self.frame.size.height-2, CGRectGetWidth(_allButton.frame), 1)];
        _lineView.backgroundColor = [UIColor hexString:@"#333333"];
        [self addSubview:_lineView];
        
        
        UIView* longLineView=[[UIView alloc] initWithFrame:CGRectMake(32*wScale, self.frame.size.height-1, self.frame.size.width-64*wScale, 1)];
        longLineView.backgroundColor=[UIColor hex:@"#E6E6E6"];
        [self addSubview:longLineView];
        
    }
    return self;
    
}

-(void)buttonAction:(UIButton*)button{
    [self changeButtonState:button];
    WPQCarGroupViewController *vc = (WPQCarGroupViewController*)[self viewController];
    [vc lineViewMove:0  moveY:0 buttonActionTag:button.tag];
    
}
#pragma mark 达分期申请扫一扫按钮(dafenqiApplyScanButton)
- (void)dafenqiApplyScanButtonAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(dafenqiApplyScanButtonAction:)]) {
        [_delegate dafenqiApplyScanButtonAction:NULL];
    }
}
-(void)changeButtonState:(UIButton*)button{
    if (button == _allButton) {
        //全部
        if ( _allButton.selected==NO) {
            _allButton.selected=YES;
            _homebredButton.selected=NO;
            _importButton.selected=NO;
        }
    }
    else if (button== _homebredButton){
        //国产
        if ( _homebredButton.selected==NO) {
            _allButton.selected=NO;
            _homebredButton.selected=YES;
            _importButton.selected=NO;
        }
    }
    else if (button == _importButton){
        //进口
        if ( _importButton.selected==NO) {
            _allButton.selected=NO;
            _homebredButton.selected=NO;
            _importButton.selected=YES;
        }
    }
    CGRect buttonFrame;
    if (button.tag == allButtonTag) {
        buttonFrame=_allButton.frame;
    }
    else if (button.tag == homebredButtonTag){
        buttonFrame=_homebredButton.frame;
    }
    else if (button.tag == importButtonTag){
        buttonFrame=_importButton.frame;
    }
   
    [UIView animateWithDuration:0.2 animations:^{
        _lineView.frame =CGRectMake(buttonFrame.origin.x, self.frame.size.height-2, CGRectGetWidth(buttonFrame), 1);
        if (self.brand) {
            [UIView animateWithDuration:0.3 animations:^{
                self.brand.alpha = 0;
                
            } completion:^(BOOL finished) {
                
                  [self.brand removeFromSuperview];
            }];
            
         
          
        }
         //  [self.delegate brandSeletedReload];
    } completion:^(BOOL finished){
    }];
    
}

#pragma mark  moveToScrollview事件
-(void)moveToScrollviewBorderScale:(CGFloat)Scale{
    CGFloat distance=_importButton.frame.origin.x-_allButton.frame.origin.x;
    CGFloat lineOffX=distance* Scale;
    _lineView.frame=CGRectMake(866*wScale+lineOffX,self.frame.size.height-2, CGRectGetWidth(_allButton.frame), 1);
    if (Scale == 0) {
        [self changeButtonState:_allButton];
    }
    else if (Scale == 0.5){
        [self changeButtonState:_homebredButton];
    }
    else if (Scale == 1.0){
        [self changeButtonState:_importButton];
    }

}


- (UIViewController*)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
- (void)brandBtn:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    ZBYSelectBrandView *brand = [[ZBYSelectBrandView alloc]initWithFrame:CGRectMake(21 * wScale, 102 * hScale, 480 * wScale, 303 * hScale)];
    brand.alpha = 0;
    brand.brandDelegate = self;
    brand.clipsToBounds = YES;
     [self.presentVC.view addSubview:brand];
    [UIView animateWithDuration:0.3 animations:^{
        brand.alpha = 1;
        
    }];
  
    self.brand = brand;
}
- (void)brandSelected{
    
//    [self.selectBrandBtn setTitle:[UserDataModel sharedUserDataModel].ppName.count>0?[[UserDataModel sharedUserDataModel].ppName[0] objectForKey:@"ppName"]:@""forState:UIControlStateNormal];
//    CGSize ppname = [[UserDataModel sharedUserDataModel].ppName.count>0?[[UserDataModel sharedUserDataModel].ppName[0] objectForKey:@"ppName"]:@""  labelAutoCalculateRectWith:[UserDataModel sharedUserDataModel].ppName.count>0?[[UserDataModel sharedUserDataModel].ppName[0] objectForKey:@"ppName"]:@"" FontSize:15];
//    self.selectBrandBtn.frame = CGRectMake(40*wScale, 20*hScale, ppname.width, 20);
//    self.imagebrand.frame = CGRectMake(_selectBrandBtn.frame.size.width + 40*wScale +5 , (20-14*hScale)/2+20*hScale, 24*wScale,14*hScale );
    [self.delegate brandSeletedReload];
}
-(void)removeBtnUser{
    self.selectBrandBtn.userInteractionEnabled = YES;
}
@end
