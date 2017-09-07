//
//  LLFInsuranceInfoViewController.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLFInsuranceInfoViewControllerDelegate <NSObject>

- (void)insuranceInfoModelstate:(NSString *)state modelArr:(NSMutableArray *)modelArr insuranceNum:(NSString *)insuranceNum;
- (void)sendIsByDaFenQi:(BOOL)isBy;
@end
@interface LLFInsuranceInfoViewController : UIViewController
@property (nonatomic,weak)id<LLFInsuranceInfoViewControllerDelegate>delegate;
@end
