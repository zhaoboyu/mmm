//
//  LLFCarGroupView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarGroupView.h"
#import "LLFCarGroupCollectionViewCell.h"
#import "LLFMechanismCarModel.h"
#import "LLFCarGroupViewModel.h"
#import "UIImageView+DownloadImage.h"
#define kCell @"LLFCarGroupCollectionViewCell"
#import "LLFCarGroupCollectionCellViewModel.h"
@interface LLFCarGroupView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
     NSArray* cellRepateArray;
}
@property (nonatomic,strong)UIImageView *nullImageView;
@end

@implementation LLFCarGroupView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupViewWithFrame:frame];
    }
    return self;
}

- (void)p_setupViewWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //item大小
//    layout.itemSize = CGSizeMake((frame.size.width - 32 * wScale) / 3, 396 * hScale);
    layout.itemSize = CGSizeMake((kWidth - 32 * wScale) / 3, 432 * hScale);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
//    layout.sectionInset= UIEdgeInsetsMake(10, 10, 10, 10);
//    UIEdgeInsetsMake(10, 10, 10, 10);
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15 * wScale, 0, kWidth - 32 * wScale, self.frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //数据源和代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;

    //添加到视图
    [self addSubview:self.collectionView];
    //注册cell
    //    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[LLFCarGroupCollectionViewCell class] forCellWithReuseIdentifier:kCell];
    
}
- (void)setMechanisCarModelArr:(NSMutableArray *)mechanisCarModelArr
{
    _mechanisCarModelArr = mechanisCarModelArr;
     cellRepateArray=[LLFCarGroupCollectionCellViewModel findRepeatFirstLetter:_mechanisCarModelArr];
    if (_mechanisCarModelArr.count > 0) {
        
    }else{
        
    }
    [_collectionView reloadData];
}

#pragma mark collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mechanisCarModelArr.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LLFCarGroupCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    LLFMechanismCarModel *mechanismCarModel = self.mechanisCarModelArr[indexPath.row];
    [cell.seriesImageView sd_setImageWithURL:[NSURL URLWithString:[mechanismCarModel.carSeriesImg firstObject]]];
    cell.repateArray=cellRepateArray;
    cell.labelStr=mechanismCarModel.carSeriesName;
    return cell;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(carGroupButtonMechanismModel:)]) {
        LLFMechanismCarModel *mechanismCarModel = self.mechanisCarModelArr[indexPath.row];
        [_delegate carGroupButtonMechanismModel:mechanismCarModel];
    }
}
// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
