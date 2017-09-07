//
//  LLFPhoneCamerManger.h
//  YDJR
//
//  Created by 吕利峰 on 2017/1/11.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum
{
    camer_photo,        //!< 相册 /
    camer_camer,         //!< 相机 */
    camer_all,         //!< 相机与相册 */
    
}CAMER_TYPE;
@protocol LLFPhoneCamerMangerDelegate <NSObject>

- (void)setImageWithPhotoSelector:(UIImage *)image;
@end
@interface LLFPhoneCamerManger : NSObject
@property (nonatomic,assign)CAMER_TYPE type;
@property (nonatomic,strong)UIViewController *parent;
@property (nonatomic,weak)id<LLFPhoneCamerMangerDelegate>delegate;
+ (instancetype)sharedPhoneCamerManger;
- (void)show;
@end
