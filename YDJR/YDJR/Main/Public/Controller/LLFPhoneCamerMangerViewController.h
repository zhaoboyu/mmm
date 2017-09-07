//
//  LLFPhoneCamerMangerViewController.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    camer_photo,        //!< 相册 /
    camer_camer,         //!< 相机 */
    
}CAMER_TYPE;
@protocol LLFPhoneCamerMangerDelegate <NSObject>
- (void)setImageWithPhotoSelector:(UIImage *)image;
@end
@interface LLFPhoneCamerMangerViewController : UIViewController
@property (nonatomic,weak)id<LLFPhoneCamerMangerDelegate>delegate;
+ (instancetype)openPhoneCamerControllerWithCamerType:(CAMER_TYPE)type delegate:(id<LLFPhoneCamerMangerDelegate>)delegate parent:(UIViewController *)parent;
@end
