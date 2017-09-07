//
//  ZBYPersonalDetailsView.m
//  YDJR
//
//  Created by 赵博宇 on 2017/5/8.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "ZBYPersonalDetailsView.h"
#import "UserDataModel.h"
#import "CTTXRequestServer+fileManger.h"
#import "LLFLoginViewController.h"
#define wid self.frame.size.width
#define heig self.frame.size.height
@interface ZBYPersonalDetailsView ()<LLFPhoneCamerMangerDelegate>

@property(nonatomic,strong) UIImageView *headerImage;
@property (nonatomic,strong)HGBPromgressHud *phud;
@end

@implementation ZBYPersonalDetailsView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}
- (void)initSubviews{
    self.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 127/2 -1, wid, 1)];
    lineView.backgroundColor = [UIColor hex:@"#d9d9d9"];
    [self addSubview:lineView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 127/2-41, wid, 40)];
    titleLabel.text = @"个人信息";
    titleLabel.textColor = [UIColor hex:@"#333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
   void (^labelBlock)(CGRect ,NSString *) = ^(CGRect frame,NSString *text){
     
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        label.text = text;
        label.textColor = [UIColor hex:@"#999999"];
        label.textAlignment = NSTextAlignmentLeft;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(16,frame.origin.y +frame.size.height-1, wid-16, 1)];
        lineView.backgroundColor = [UIColor hex:@"#d9d9d9"];
        
       [self addSubview:label];
       [self addSubview:lineView];
    };
    NSArray *arr = [NSArray arrayWithObjects:@"头像",@"姓名",@"用户名",@"职务",@"机构简称",@"机构全称", nil];
    for (int i=0; i <6; i++) {
        labelBlock(CGRectMake(20, 127/2 +60*i, wid-20, 60),arr[i]);
    }
    UIImageView *headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(wid -32-40, 144/2, 40, 40)];
    [headerImage sd_setImageWithURL:[Tool pinjieUrlWithImagePath:[UserDataModel sharedUserDataModel].headpic] placeholderImage:[UIImage imageNamed:@"PlaceIcon"]];
    headerImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *headerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerTap:)];
    [headerImage addGestureRecognizer:headerTap];
    headerImage.layer.cornerRadius = 3;
    headerImage.layer.borderWidth=1.0 *wScale;
    headerImage.layer.borderColor=[[UIColor grayColor] CGColor];
    headerImage.clipsToBounds = YES;
    [self addSubview:headerImage];
    self.headerImage = headerImage;
    
    UIImageView *changeImage = [[UIImageView alloc]initWithFrame:CGRectMake(1352/2, 171.3/2, 15.8/2, 25.5/2)];
    changeImage.image = [UIImage imageNamed:@"Path_2"];
    [self addSubview:changeImage];
    
    void (^labelRightBlock)(CGRect ,NSString *) = ^(CGRect frame,NSString *text){
        
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        label.text = text;
        label.textColor = [UIColor hex:@"#333333"];
        label.textAlignment = NSTextAlignmentRight;
        [self addSubview:label];
       
    };
    LLFUserRoleModel *role =[UserDataModel sharedUserDataModel].roles[0];
 
    NSArray *right = [NSArray arrayWithObjects:[UserDataModel sharedUserDataModel].userDesc,[UserDataModel sharedUserDataModel].userName,role.roleName,[Tool getMechanismName],[Tool getMechanismQName], nil];
    for (int i=0; i < 5; i ++) {
          labelRightBlock(CGRectMake(60, 127/2 +60*(i+1), wid-70, 60),right[i]);
    }
    
    UIButton *outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    outBtn.frame = CGRectMake(500*wScale, 888*hScale+10, 400*wScale, 80*hScale);
    outBtn.backgroundColor = [UIColor hexString:@"#333333"];
    [outBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [outBtn addTarget:self action:@selector(outA) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:outBtn];
}
- (void)headerTap:(id)sender{
    LLFPhoneCamerManger *phoneCamerManger = [LLFPhoneCamerManger sharedPhoneCamerManger];
    phoneCamerManger.type = camer_all;
    phoneCamerManger.delegate = self;
        phoneCamerManger.parent = self.VC;
    [phoneCamerManger show];
    
   
}
- (void)setImageWithPhotoSelector:(UIImage *)image{
 
    NSString *imageName = [NSString stringWithFormat:@"%@%@.jpg",[Tool getTimeStr],[Tool getUdidCode]];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    NSString *imagePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]];
    //创建一个文件
    NSFileManager *fileManage = [NSFileManager defaultManager];
    [fileManage createFileAtPath:imagePath contents:nil attributes:nil];
    
    BOOL soult =[imageData writeToFile:imagePath options:(NSDataWritingAtomic) error:nil];
    if (soult) {
        [self.phud showHUDSaveAddedTo:self];
    [[CTTXRequestServer shareInstance] uploadFileHeadImageWithFilePath:imagePath SuccessBlock:^(BOOL result) {
        NSLog(@"%d",result);
        [self.phud hideSave];
        if (result) {
            [_headerImage sd_setImageWithURL:[Tool pinjieUrlWithImagePath:[UserDataModel sharedUserDataModel].headpic] placeholderImage:[UIImage imageNamed:@"PlaceIcon"]];
            [self.messageDelegate messageCountReload];
        }else{
            self.phud.promptStr = @"上传头像失败,请稍后重试!";
            [self.phud showHUDResultAddedTo:self];
        }
    [self.messageDelegate messageCountReload];
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
        [self.phud hideSave];
        self.phud.promptStr = @"上传头像失败,请稍后重试!";
        [self.phud showHUDResultAddedTo:self];
    }];
    }
}
- (void)outA{
    //退出登录
    UserDataModel *userModel = [UserDataModel sharedUserDataModel];
    [userModel logOut];
    LLFLoginViewController *loginVC = [[LLFLoginViewController alloc]init];
    [self.VC presentViewController:loginVC animated:YES completion:^{}];

}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    [self.messageDelegate messageCountReload];
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}
@end
