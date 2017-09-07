//
//  LLFDIYInsuranceInfoListView.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/12.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LLFDIYInsuranceInfoListViewDelegate <NSObject>

- (void)InsuranceInfoListButtonstate:(NSString *)state;

@end
@interface LLFDIYInsuranceInfoListView : UIView
@property (nonatomic,weak)id<LLFDIYInsuranceInfoListViewDelegate>delegate;
@property (nonatomic,strong)NSMutableArray *infoListModelArr;
@end
