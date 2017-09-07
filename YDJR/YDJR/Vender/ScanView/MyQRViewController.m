//
//  MyQRViewController.m
//  二维码扫描与生成模拟
//
//  Created by 吕利峰 on 16/4/14.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "MyQRViewController.h"
#import "ScanWrapper.h"
@interface MyQRViewController ()
//二维码
@property (nonatomic, strong) UIView *qrView;
@property (nonatomic, strong) UIImageView* qrImgView;
@end

@implementation MyQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(50, self.view.frame.size.height - 60, self.view.frame.size.width-100, 40)];
    [btn1 setTitle:@"切换码的样式及类型" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(newCodeChooose) forControlEvents:UIControlEventTouchUpInside];
    
    btn1.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:btn1];
    
    
    //二维码
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake( (CGRectGetWidth(self.view.frame)-CGRectGetWidth(self.view.frame)*5/6)/2, 100, CGRectGetWidth(self.view.frame)*5/6, CGRectGetWidth(self.view.frame)*5/6)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.shadowOffset = CGSizeMake(0, 2);
    view.layer.shadowRadius = 2;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.5;
    
    
    self.qrImgView = [[UIImageView alloc]init];
    _qrImgView.bounds = CGRectMake(0, 0, CGRectGetWidth(view.frame)-12, CGRectGetWidth(view.frame)-12);
    _qrImgView.center = CGPointMake(CGRectGetWidth(view.frame)/2, CGRectGetHeight(view.frame)/2);
    [view addSubview:_qrImgView];
    self.qrView = view;
    
    
    
    
    [self createQR1];
    
}
- (void)createQR1
{
    _qrView.hidden = NO;
    
    
    //如果想要圆角效果，建议还是将图像做成圆角的，或者通过logo图像做成UIImageView加在二维码上面即可
    UIImage *qrImg = [ScanWrapper createQRWithString:@"lbxia20091227@foxmail.com" size:_qrImgView.bounds.size];
    
    UIImage *logoImg = [UIImage imageNamed:@"logo.JPG"];
    _qrImgView.image = [ScanWrapper addImageLogo:qrImg centerLogoImage:logoImg logoSize:CGSizeMake(30, 30)];
    
}
- (void)createQR2
{
    _qrView.hidden = NO;
    
    UIImage *image = [ScanWrapper createQRWithString:@"lbxia20091227@foxmail.com" size:_qrImgView.bounds.size];
    //二维码上色
    _qrImgView.image = [ScanWrapper imageBlackToTransparent:image withRed:255.0f andGreen:74.0f andBlue:89.0f];
    
}
- (void)newCodeChooose
{
    [self createQR2];
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
