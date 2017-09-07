//
//  LLFMediaPlugin.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/6.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFMediaPlugin.h"

@interface LLFMediaPlugin ()<LLFPhoneCamerMangerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,copy)NSString *callbackId;
@end

@implementation LLFMediaPlugin
/**
 *	@brief	调用媒体库
 *
 *	@param 	command 	参数数组 参数:id,
 action 调用服务方法名(camera 调用照相机 photo 调用相册),
 */
- (void)media:(CDVInvokedUrlCommand *)command
{
    self.callbackId = command.callbackId;
    __weak LLFMediaPlugin *weakself = self;
//    [self.commandDelegate runInBackground:^{
        if (command.arguments.count > 0) {
            NSString *type = command.arguments[0];
            UIImagePickerController *picker=[[UIImagePickerController alloc]init];
            picker.delegate=self;
            //    picker.editing=YES;
            picker.allowsEditing=YES;
            //设置拾取源属性,设置使用控制器要进行的操作
            if ([type isEqualToString:@"camera"]) {
                picker.sourceType=UIImagePickerControllerSourceTypeCamera;
                //        picker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
                //设置捕获模式
                //        picker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
            }else if ([type isEqualToString:@"photo"]){
                picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            }
            picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self.viewController presentViewController:picker animated:YES completion:nil];
            
        }else{
            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
            [weakself.commandDelegate sendPluginResult:result callbackId:_callbackId];
        }
//    }];
}
#pragma mark image

//拿出图片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //在图片库中获取照片
    UIImage *image;
    image=info[UIImagePickerControllerOriginalImage];
    [self setImageWithPhotoSelector:image];
    //隐藏选取照片控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)setImageWithPhotoSelector:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//    NSString *dataStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
        NSString *imagePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",[Tool getTimeStr]]];
        //创建一个文件
        NSFileManager *fileManage = [NSFileManager defaultManager];
        [fileManage createFileAtPath:imagePath contents:nil attributes:nil];
    
        BOOL soult =[imageData writeToFile:imagePath options:(NSDataWritingAtomic) error:nil];
//    UIImage *tempImage = [UIImage imageNamed:imagePath];
        if (soult) {
             CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:imagePath];
             [self.commandDelegate sendPluginResult:result callbackId:_callbackId];
    
        }else{
            CDVPluginResult * result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
            [self.commandDelegate sendPluginResult:result callbackId:_callbackId];
        }
    
}
@end
