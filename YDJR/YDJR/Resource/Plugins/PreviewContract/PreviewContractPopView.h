//
//  PreviewContractPopView.h
//  YDJR
//
//  Created by 吕利峰 on 2017/4/28.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "PopView.h"
@protocol PreviewContractPopViewDelegate <NSObject>

@optional
- (void)clickWithType:(NSString *)type;

@end
@interface PreviewContractPopView : PopView
@property (nonatomic,assign)id<PreviewContractPopViewDelegate>deleate;
- (instancetype)initWithFrame:(CGRect)frame businessID:(NSString *)businessID typeNo:(NSString *)typeNo operationType:(NSString *)operationType imageName:(NSString *)imageName;

@end
