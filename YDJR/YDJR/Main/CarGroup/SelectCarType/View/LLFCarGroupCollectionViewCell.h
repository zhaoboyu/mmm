//
//  LLFCarGroupCollectionViewCell.h
//  YDJR
//
//  Created by 吕利峰 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLFCarGroupCollectionViewCell : UICollectionViewCell{
    UILabel *seriesLabel;
    CGRect middleFrame;
    CGRect leftFrame;
    CGRect otherFrame;
    
}
@property (nonatomic,strong)UIImageView *seriesImageView;
@property (nonatomic,strong)UILabel *seriesNameLabel;
@property (nonatomic,copy) NSString* labelStr;
@property (nonatomic,copy) NSArray* repateArray;
@end
