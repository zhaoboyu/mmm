//
//  LLFCarGroupCollectionViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarGroupCollectionViewCell.h"
#import "LLFCarGroupCollectionCellViewModel.h"
@implementation LLFCarGroupCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
//        self.backgroundColor=[UIColor redColor];
    }
    return self;
}
- (void)p_setupView
{
    
    
    middleFrame = CGRectMake(248*wScale, 80*hScale, 380*wScale, 240*hScale);
    leftFrame   = CGRectMake(171*wScale, 80*hScale, (470-20)*wScale, 240*hScale);
    otherFrame  = CGRectMake(225*wScale, 80*hScale, (470-20)*wScale, 240*hScale);
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.seriesImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15 * wScale, 32 * hScale, 640 * wScale, 400 * hScale)];
    [self.contentView addSubview:self.seriesImageView];
    
    UIView* bgView=[[UIView alloc] initWithFrame:self.seriesImageView.bounds];
    bgView.backgroundColor=[UIColor hex:@"#000000"];
    bgView.alpha=0.35;
    [self.seriesImageView addSubview:bgView];
    
    _seriesNameLabel = [[UILabel alloc]initWithFrame:middleFrame];
    _seriesNameLabel.textAlignment=NSTextAlignmentLeft;
//    _seriesNameLabel.backgroundColor=[UIColor blueColor];
    [self.contentView addSubview:_seriesNameLabel];
    self.seriesNameLabel.textColor = [UIColor hexString:@"#FFFFFF"];
    
}

-(void)setLabelStr:(NSString *)labelStr{

    NSInteger StrIndex=1;
    NSString* firstStr  = [labelStr substringToIndex:StrIndex];
    //首字母重复的系列
    if ([self.repateArray containsObject:firstStr]) {
        if (labelStr.length > 2) {
            NSString* str=[labelStr substringWithRange:NSMakeRange(1, 1)];
            if(![LLFCarGroupCollectionCellViewModel isChinese:str]){
                //字母重复的系列
                StrIndex=2;
                firstStr  = [labelStr substringToIndex:StrIndex];
            }
        }
        
    }
    
    CGSize firstPartsize;
    firstPartsize=[self AttributeSizeWithText:firstStr];
    
    NSString* secondStr = [labelStr substringFromIndex:StrIndex];
    NSMutableAttributedString * firstPart = [[NSMutableAttributedString alloc] initWithString:firstStr];
    NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont boldSystemFontOfSize:120],};
    [firstPart setAttributes:firstAttributes range:NSMakeRange(0,StrIndex)];
    
    NSMutableAttributedString * secondPart = [[NSMutableAttributedString alloc] initWithString:secondStr];
    NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],};
    [secondPart setAttributes:secondAttributes range:NSMakeRange(0,secondPart.length)];
    [firstPart appendAttributedString:secondPart];
    _seriesNameLabel.attributedText=firstPart;
    _seriesNameLabel.frame=CGRectMake((self.seriesImageView.frame.size.width-firstPartsize.width)/2,80*hScale, (470-20)*wScale, 240*hScale);
    
}

-(CGSize)AttributeSizeWithText:(NSString *)text{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:120]}];
    size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:120]}];
    return size;
}




@end
