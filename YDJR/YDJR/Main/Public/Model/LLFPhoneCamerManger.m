//
//  LLFPhoneCamerManger.m
//  YDJR
//
//  Created by 吕利峰 on 2017/1/11.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFPhoneCamerManger.h"
static LLFPhoneCamerManger *phoneCamerManger = nil;
@interface LLFPhoneCamerManger ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>


@end
@implementation LLFPhoneCamerManger
+ (instancetype)sharedPhoneCamerManger
{
    //这段代码只被执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        phoneCamerManger = [[LLFPhoneCamerManger alloc] init];
    });
    return phoneCamerManger;
}
- (instancetype)init
{
    if (self = [super init]) {
        self.parent = [UIViewController currentViewController];

    }
    return self;
}

- (void)show
{
    if (self.type == camer_all) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"相机",@"相册", nil];
        [alert show];
    }else{
        [self openPhoneCamer];
    }
}
- (void)openPhoneCamer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeRotate" object:@"1"];
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
//        [UserDataModel sharedUserDataModel].flag = 0;
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        //        picker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
        //设置捕获模式
        //        picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
    }
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.parent presentViewController:picker animated:YES completion:nil];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }else if (buttonIndex == 1){
        self.type = camer_camer;
        [self openPhoneCamer];
    }else if (buttonIndex == 2){
        self.type = camer_photo;
        [self openPhoneCamer];
    }
}

#pragma mark image

//拿出图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeRotate" object:@"0"];
    //在图片库中获取照片
    UIImage *image;
    image=info[UIImagePickerControllerOriginalImage];
    [self getImage:image];
    //隐藏选取照片控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeRotate" object:@"0"];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)getImage:(UIImage *)image
{
    if (_delegate && [_delegate respondsToSelector:@selector(setImageWithPhotoSelector:)]) {
        [_delegate setImageWithPhotoSelector:image];
    }
}
@end
