//
//  UploadFileModel.h
//  CTTX
//
//  Created by 吕利峰 on 16/5/18.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadFileModel : NSObject
/// 文件路径
@property (nonatomic, retain) NSString *filePath;
// 审批中的合同编号
@property (nonatomic,copy) NSString *ObjectNo;
// 影像类型
@property (nonatomic,copy) NSString *TypeNo;
// 影像名称
@property (nonatomic,copy) NSString *filename;
@property (nonatomic,copy) NSString *opinionId;

//达分期
/**
 订单号
 */
@property (nonatomic,copy) NSString *businessID;

/**
 影像类型
 */
//@property (nonatomic,copy) NSString *typeNo;

/**
 影像图片地址
 */
//@property (nonatomic,copy) NSString *imagePath;
//
//@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *operationType;
@property (nonatomic,copy) NSString *productType;
@end
