//
//  LLFInsuranceInfoView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFInsuranceInfoView.h"
#import "InsuranceInfoModel.h"
#import "LLFInsuranceInfoCollectionViewCell.h"
#import "LLFInsuranceInfoCollectionReusableView.h"
#import "LLFInsuranceMoneyCollectionViewCell.h"
#import "LLFInsuranceTitleCollectionViewCell.h"
#define kCell @"LLFInsuranceInfoCollectionViewCell"
#define kCell_1 @"LLFInsuranceMoneyCollectionViewCell"
#define kCell_2 @"LLFInsuranceTitleCollectionViewCell"
#define CellIdentifier @"header"
@interface LLFInsuranceInfoView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate>

@property (nonatomic,strong)NSMutableArray *insruanceModelArr;
@end
@implementation LLFInsuranceInfoView
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
    layout.itemSize = CGSizeMake(504 * wScale, 224 * hScale);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width - 32 * wScale, frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //数据源和代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    //添加到视图
    [self addSubview:self.collectionView];
    //注册cell
    [self.collectionView registerClass:[LLFInsuranceInfoCollectionViewCell class] forCellWithReuseIdentifier:kCell];
    [self.collectionView registerClass:[LLFInsuranceMoneyCollectionViewCell class] forCellWithReuseIdentifier:kCell_1];
    [self.collectionView registerClass:[LLFInsuranceTitleCollectionViewCell class] forCellWithReuseIdentifier:kCell_2];
    [self.collectionView registerClass:[LLFInsuranceInfoCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier];
}
- (void)setInsuranceInfoModelDic:(NSMutableDictionary *)insuranceInfoModelDic
{
    _insuranceInfoModelDic = insuranceInfoModelDic;
    self.insruanceModelArr = [self getInsruanceModelArr];
    [self.collectionView reloadData];
}
#pragma mark collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *tempArr = [self.insuranceInfoModelDic allKeys];
    NSArray *keyArr = [self sortWithArr:tempArr];
    NSMutableArray *valueArr = [self.insuranceInfoModelDic objectForKey:keyArr[section]];
    if (section == keyArr.count - 1) {
        
        return valueArr.count + 1;
    }else{
        
        return valueArr.count;
    }
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSArray *tempArr = [self.insuranceInfoModelDic allKeys];
    NSArray *keyArr = [self sortWithArr:tempArr];
    return  keyArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    LLFInsuranceInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    
    NSArray *tempArr = [self.insuranceInfoModelDic allKeys];
    NSArray *keyArr = [self sortWithArr:tempArr];
    NSMutableArray *valueTempArr = [self.insuranceInfoModelDic objectForKey:keyArr[indexPath.section]];
    if ((indexPath.section == keyArr.count - 1) && (valueTempArr.count == indexPath.row)) {
        //花费对比
        LLFInsuranceMoneyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell_1 forIndexPath:indexPath];
        return cell;
        
        
    }else{
        if (indexPath.section == keyArr.count - 1) {
            //保险期限
            LLFInsuranceInfoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
            NSMutableArray *insuranceInfoModelArr =[self.insuranceInfoModelDic objectForKey:keyArr[indexPath.section]];
//            NSArray *imageNameArr = [[self getBgItemImageName] objectForKey:keyArr[indexPath.section]];
            InsuranceInfoModel *insuranceInfoModel =insuranceInfoModelArr[indexPath.item];
            cell.isSelect = insuranceInfoModel.isSelect;
            cell.insuranceTitleLabel.text = insuranceInfoModel.insuranceName;
            cell.insuranceContentLabel.text = [NSString stringWithFormat:@"RMB %@",[insuranceInfoModel.insurancePrice cut]];
            cell.bgItemImageView.image = [UIImage imageNamed:insuranceInfoModel.bgImageName];
             return cell;
        }else{
            //其他保险
            LLFInsuranceTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell_2 forIndexPath:indexPath];
            NSMutableArray *valueArr = [self.insuranceInfoModelDic objectForKey:keyArr[indexPath.section]];
            InsuranceInfoModel *insuranceInfoModel =valueArr[indexPath.row];
            cell.isSelect = insuranceInfoModel.isSelect;
            cell.insuranceTitleLabel.text = insuranceInfoModel.insuranceName;
            cell.bgItemImageView.image = [UIImage imageNamed:insuranceInfoModel.bgImageName];
            //            cell.insuranceContentLabel.text = [NSString stringWithFormat:@"RMB %@",insuranceInfoModel.insurancePrice];
//            if (indexPath.section == keyArr.count) {
//                InsuranceInfoModel *insuranceInfoModel =self.insruanceModelArr[indexPath.row];
//                cell.isSelect = insuranceInfoModel.isSelect;
//                cell.insuranceTitleLabel.text = insuranceInfoModel.insuranceName;
//                //            cell.insuranceContentLabel.text = [NSString stringWithFormat:@"RMB %@",insuranceInfoModel.insurancePrice];
//            }else{
//                NSMutableArray *valueArr = [self.insuranceInfoModelDic objectForKey:keyArr[indexPath.section]];
//                InsuranceInfoModel *insuranceInfoModel =valueArr[indexPath.row];
//                cell.isSelect = insuranceInfoModel.isSelect;
//                cell.insuranceTitleLabel.text = insuranceInfoModel.insuranceName;
//                //            cell.insuranceContentLabel.text = [NSString stringWithFormat:@"RMB %@",insuranceInfoModel.insurancePrice];
//            }
            
             return cell;
        }
    }
    
    
    
//    return cell;
}
#pragma mark ---- UICollectionViewDelegateFlowLayout

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    LLFInsuranceInfoCollectionViewCell *cell = (LLFInsuranceInfoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSArray *tempArr = [self.insuranceInfoModelDic allKeys];
    NSArray *keyArr = [self sortWithArr:tempArr];
    if (indexPath.section == keyArr.count - 1){
        NSMutableArray *valueArr = [self.insuranceInfoModelDic objectForKey:keyArr[indexPath.section]];
        NSInteger count = valueArr.count;
        
        if (indexPath.item == valueArr.count) {
            //选中花费对比
            if (_delegate && [_delegate respondsToSelector:@selector(sendSumInsuranceMoney:)]) {
                //                [_delegate insuranceInfoButtonstate:@"花费对比" modelArr:[self getSelectInsuranceModel]];
                [_delegate sendSumInsuranceMoney:[self getSumInsuranceMoney]];
            }

            
        }else{
            //选中保险期限
            InsuranceInfoModel *insuranceModel =valueArr[indexPath.item];
            if (!insuranceModel.isSelect) {
                //添加输入框
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入保险总金额!" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                NSInteger dictValue = [insuranceModel.dictvalue integerValue];
                alert.tag = 500 + dictValue - 1;
                [alert show];
                UITextField *textField = [alert textFieldAtIndex:0];
                if ([insuranceModel.insurancePrice isEqualToString:@"0"] || [insuranceModel.insurancePrice isEqualToString:@"0.00"]) {
                    textField.text = @"";
                }else{
                    textField.text = insuranceModel.insurancePrice;
                }
                
                textField.keyboardType = UIKeyboardTypeNumberPad;
            }
            for (int i = 0; i < count; i ++) {
                LLFInsuranceInfoCollectionViewCell *cell_2;
                InsuranceInfoModel *insuranceInfoModel;
                if (!(i == indexPath.item)) {
                    cell_2 = (LLFInsuranceInfoCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section]];
                    insuranceInfoModel =valueArr[i];
                    //                if (!insuranceModel.isSelect) {
                    ////                    insuranceModel.isSelect = YES;
                    //                    insuranceInfoModel.isSelect = NO;
                    //
                    //                }else{
                    ////                    insuranceModel.isSelect = NO;
                    //
                    //                }
                    insuranceInfoModel.isSelect = NO;
                    cell_2.isSelect = insuranceInfoModel.isSelect;
                    valueArr[i] = insuranceInfoModel;
                }else{
                    if (!insuranceModel.isSelect) {
                        insuranceModel.isSelect = YES;
                        //                    insuranceInfoModel.isSelect = NO;
                        
                    }else{
                        insuranceModel.isSelect = NO;
                        
                    }
                }
            }
            valueArr[indexPath.item] = insuranceModel;
            [self.insuranceInfoModelDic setObject:valueArr forKey:keyArr[indexPath.section]];
            cell.isSelect = insuranceModel.isSelect;
            
        }
        
        
        
    }else{
        //选择保险
        NSMutableArray *valueArr = [self.insuranceInfoModelDic objectForKey:keyArr[indexPath.section]];
        InsuranceInfoModel *insuranceInfoModel =valueArr[indexPath.item];
        //选择非必交项
        if (![insuranceInfoModel.insuranceSortName isEqualToString:@"必交项"]) {
            if (!insuranceInfoModel.isSelect) {
                insuranceInfoModel.isSelect = YES;
                valueArr[indexPath.row] = insuranceInfoModel;
                [self.insuranceInfoModelDic setObject:valueArr forKey:keyArr[indexPath.section]];
                cell.isSelect = insuranceInfoModel.isSelect;
                //                if (!(indexPath.section == keyArr.count)){
                //                    for (int i = 0; i < 2; i++) {
                //                        InsuranceInfoModel *insuranceModel =self.insruanceModelArr[i];
                //                        double start =[insuranceInfoModel.insurancePrice doubleValue];
                //                        double end = [insuranceModel.insurancePrice doubleValue];
                //                        insuranceModel.insurancePrice = [NSString stringWithFormat:@"%lf",start + end];
                //                        self.insruanceModelArr[i] = insuranceModel;
                //                    }
                //                }
            }else{
                insuranceInfoModel.isSelect = NO;
                valueArr[indexPath.row] = insuranceInfoModel;
                [self.insuranceInfoModelDic setObject:valueArr forKey:keyArr[indexPath.section]];
                cell.isSelect = insuranceInfoModel.isSelect;
                //                if (!(indexPath.section == keyArr.count)){
                //                    for (int i = 0; i < 2; i++) {
                //                        InsuranceInfoModel *insuranceModel =self.insruanceModelArr[i];
                //                        double start =[insuranceInfoModel.insurancePrice doubleValue];
                //                        double end = [insuranceModel.insurancePrice doubleValue];
                //                        insuranceModel.insurancePrice = [NSString stringWithFormat:@"%lf",end - start];
                //                        self.insruanceModelArr[i] = insuranceModel;
                //                    }
                //                }
            }
        }
        
        
    }
//    else if (indexPath.section == keyArr.count){
//        //是否选择保险分期
//        if (indexPath.item == 0) {
//            LLFInsuranceInfoCollectionViewCell *cell_1 = (LLFInsuranceInfoCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:indexPath.section]];
//            InsuranceInfoModel *insuranceModel =self.insruanceModelArr[0];
//            InsuranceInfoModel *tempModel =self.insruanceModelArr[1];
//            if (_delegate && [_delegate respondsToSelector:@selector(sendIsByDaFenQi:)]) {
//                [_delegate sendIsByDaFenQi:NO];
//            }
//            if (!insuranceModel.isSelect) {
//                insuranceModel.isSelect = YES;
//                tempModel.isSelect = NO;
//            }else{
//                insuranceModel.isSelect = NO;
//            }
//            cell.isSelect = insuranceModel.isSelect;
//            cell_1.isSelect = tempModel.isSelect;
//            self.insruanceModelArr[0] = insuranceModel;
//            self.insruanceModelArr[1] = tempModel;
//        }else if (indexPath.item == 1){
//            LLFInsuranceInfoCollectionViewCell *cell_1 = (LLFInsuranceInfoCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.section]];
//            InsuranceInfoModel *insuranceModel =self.insruanceModelArr[1];
//            InsuranceInfoModel *tempModel =self.insruanceModelArr[0];
//            if (!insuranceModel.isSelect) {
//                insuranceModel.isSelect = YES;
//                tempModel.isSelect = NO;
//            }else{
//                insuranceModel.isSelect = NO;
//            }
//            if (_delegate && [_delegate respondsToSelector:@selector(sendIsByDaFenQi:)]) {
//                [_delegate sendIsByDaFenQi:insuranceModel.isSelect];
//            }
//            cell.isSelect = tempModel.isSelect;
//            cell_1.isSelect = insuranceModel.isSelect;
//            self.insruanceModelArr[0] = tempModel;
//            self.insruanceModelArr[1] = insuranceModel;
//        }else if (indexPath.item == 2){
//            //花费对比
//            if (_delegate && [_delegate respondsToSelector:@selector(sendSumInsuranceMoney:)]) {
//                //                [_delegate insuranceInfoButtonstate:@"花费对比" modelArr:[self getSelectInsuranceModel]];
//                [_delegate sendSumInsuranceMoney:[self getSumInsuranceMoney]];
//            }
//        }
//    }
    
    
    
    [self.collectionView reloadData];
//    cell.contentView.backgroundColor = [UIColor blueColor];
    
}
//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.frame.size.width, 64 * hScale);
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //从缓存中获取 Headercell
    LLFInsuranceInfoCollectionReusableView *cell = (LLFInsuranceInfoCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSArray *tempArr = [self.insuranceInfoModelDic allKeys];
    NSArray *keyArr = [self sortWithArr:tempArr];
//    if (indexPath.section == keyArr.count) {
//        InsuranceInfoModel *insuranceInfoModel =self.insruanceModelArr[indexPath.row];
//        cell.topLabel.text = insuranceInfoModel.insuranceSortName;
//        CGRect rect = cell.lineView.frame;
//        CGFloat lineWidth = [Tool widthForString:cell.topLabel.text fontSize:12.0 andHight:24 * hScale];
//        rect.size.width = lineWidth;
//        cell.lineView.frame = rect;
//
//    }else{
//        NSMutableArray *valueArr = [self.insuranceInfoModelDic objectForKey:keyArr[indexPath.section]];
//        InsuranceInfoModel *insuranceInfoModel =valueArr[indexPath.row];
//        cell.topLabel.text = insuranceInfoModel.insuranceSortName;
//        CGRect rect = cell.lineView.frame;
//        CGFloat lineWidth = [Tool widthForString:cell.topLabel.text fontSize:12.0 andHight:24 * hScale];
//        rect.size.width = lineWidth;
//        cell.lineView.frame = rect;
//
//    }
    NSMutableArray *valueArr = [self.insuranceInfoModelDic objectForKey:keyArr[indexPath.section]];
    InsuranceInfoModel *insuranceInfoModel =valueArr[indexPath.row];
    cell.topLabel.text = insuranceInfoModel.insuranceSortName;
    CGRect rect = cell.lineView.frame;
    CGFloat lineWidth = [Tool widthForString:cell.topLabel.text fontSize:15.0 andHight:30 * hScale];
    rect.size.width = lineWidth;
    cell.lineView.frame = rect;
    
    return cell;
}
//排序
- (NSArray *)sortWithArr:(NSArray *)arr
{
    NSArray *keyArr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSInteger int1 = [obj1 integerValue];
        NSInteger int2 = [obj2 integerValue];
        if (int1 > int2) {
            return 1;
        }else{
            return -1;
        }
    }];
    return keyArr;
}
#pragma mark 添加model数据
- (NSMutableArray *)getInsruanceModelArr
{
    double souce = 0;
//    NSMutableArray *modelArr = [self.insuranceInfoModelDic objectForKey:@"必交项"];
//    for (InsuranceInfoModel *tempModel in modelArr) {
//        double insurancePrinace = [tempModel.insurancePrice doubleValue];
//        souce += insurancePrinace;
//    }
    souce = 0;
    NSString *insurancePrince = [NSString stringWithFormat:@"%.0f",souce];
    _insruanceModelArr = [NSMutableArray array];
    NSDictionary *dic1 = @{@"insuranceName":@"全款",@"insurancePrice":insurancePrince,@"insuranceSort":@"5",@"insuranceSortName":@"保险分期"};
    InsuranceInfoModel *model = [InsuranceInfoModel yy_modelWithDictionary:dic1];
    [_insruanceModelArr addObject:model];
    NSString *insuranceThreePrince = [NSString stringWithFormat:@"%.0f",souce * 3];
    NSDictionary *dic2 = @{@"insuranceName":@"保险分期",@"insurancePrice":insuranceThreePrince,@"insuranceSort":@"5",@"insuranceSortName":@"保险分期"};
    InsuranceInfoModel *model1 = [InsuranceInfoModel yy_modelWithDictionary:dic2];
    [_insruanceModelArr addObject:model1];
    
    return _insruanceModelArr;
}
- (NSMutableArray *)getSelectInsuranceModel
{
    NSMutableArray *selectModelArr = [NSMutableArray array];
    NSArray *keyArr = [self.insuranceInfoModelDic allKeys];
    for (NSString *key in keyArr) {
        if (![key isEqualToString:@"4"]) {
            NSArray *valueArr = [self.insuranceInfoModelDic objectForKey:key];
            for (InsuranceInfoModel *model in valueArr) {
                if (model.isSelect) {
                    [selectModelArr addObject:model];
                }
            }
        }
        
    }
    return selectModelArr;
}
- (NSString *)getSumInsuranceMoney
{
    NSMutableArray *valueArr = [self.insuranceInfoModelDic objectForKey:@"4"];
    InsuranceInfoModel *model = valueArr[0];
    return model.insurancePrice;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *textField = [alertView textFieldAtIndex:0];
    NSMutableArray *valueArr = [self.insuranceInfoModelDic objectForKey:@"4"];
    float sum = [textField.text floatValue] / (alertView.tag - 500 + 1);
    NSString *insuranceNum = [NSString stringWithFormat:@"%d",alertView.tag - 500 + 1];
    for (int i = 0; i < valueArr.count; i++) {
        InsuranceInfoModel *model = valueArr[i];
        float insum = [model.dictvalue doubleValue];
//        insuranceNum = [NSString stringWithFormat:@"%d",i + 1];
        model.insurancePrice = [NSString stringWithFormat:@"%.2f",sum * insum];
        valueArr[i] = model;
    }
    [self.insuranceInfoModelDic setObject:valueArr forKey:@"4"];
    [self.collectionView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(insuranceInfoButtonstate:modelArr:insuranceNum:)]) {
        [_delegate insuranceInfoButtonstate:textField.text modelArr:[self getSelectInsuranceModel] insuranceNum:insuranceNum];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
