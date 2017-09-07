//
//  LSAddAgentProductDetailsView.h
//  YDJR
//
//  Created by 李爽 on 2016/11/15.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSAddAgentProductDetailsView : UIView
/**
 计算结果Array
 */
@property (nonatomic ,strong) NSMutableArray *countResultArray;
/**
 产品ID
 */
@property (nonatomic ,copy) NSString *productID;
@property (nonatomic ,copy) NSString *productName;
@property (nonatomic ,strong) NSMutableArray *returnResultArray;
@property (nonatomic ,strong) UICollectionView *collectionView;

- (instancetype)initWithFrame:(CGRect)frame productID:(NSString *)productID actualPrice:(NSString *)actualPrice carModelName:(NSString *)carModelName productName:(NSString *)productName;

@end
