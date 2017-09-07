//
//  LLFPhoneCamerMangerViewController.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFPhoneCamerMangerViewController.h"

@interface LLFPhoneCamerMangerViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,assign)CAMER_TYPE type;
@property (nonatomic,strong)UIViewController *parent;

@end

@implementation LLFPhoneCamerMangerViewController
+ (instancetype)openPhoneCamerControllerWithCamerType:(CAMER_TYPE)type delegate:(id<LLFPhoneCamerMangerDelegate>)delegate parent:(UIViewController *)parent
{
    return [[LLFPhoneCamerMangerViewController alloc] initWithCamerType:type delegate:delegate parent:parent];
}
- (instancetype)initWithCamerType:(CAMER_TYPE)type delegate:(id<LLFPhoneCamerMangerDelegate>)delegate parent:(UIViewController *)parent
{
    if (self = [super init]) {
        self.delegate = delegate;
        self.type = type;
        self.parent = parent;
        
    }
    return self;
}
- (void)openPhoneCamer
{
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    picker.delegate=self;
    //    picker.editing=YES;
    picker.allowsEditing=YES;
    //设置拾取源属性,设置使用控制器要进行的操作
    if (self.type == camer_photo) {
        //调用相册
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    }else if (self.type == camer_camer){
        //调用相机
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
//        picker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
        //设置捕获模式
//        picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
    }
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.parent presentViewController:picker animated:YES completion:nil];
    
}
#pragma mark image

//拿出图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //在图片库中获取照片
    UIImage *image;
    image=info[UIImagePickerControllerOriginalImage];
    [self getImage:image];
    //隐藏选取照片控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)getImage:(UIImage *)image
{
    if (_delegate && [_delegate respondsToSelector:@selector(setImageWithPhotoSelector:)]) {
        [_delegate setImageWithPhotoSelector:image];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self openPhoneCamer];
    // Do any additional setup after loading the view.
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
