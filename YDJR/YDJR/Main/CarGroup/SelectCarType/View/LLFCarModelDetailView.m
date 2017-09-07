//
//  LLFCarModelDetailView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/9.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarModelDetailView.h"
#import "LLFCarModelDetailTableViewCell.h"
#import "LLFCarModelTableViewCell.h"
#import "LLFCarSeriesCarModel.h"
#import "LLFCarModel.h"
#define kCell_1 @"LLFCarModelTableViewCell.h"
#define kCell_2 @"LLFCarModelDetailTableViewCell"
@interface LLFCarModelDetailView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIImageView *nullImageView;
@end
@implementation LLFCarModelDetailView
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
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backButton.frame = CGRectMake(47 * wScale, 32 * hScale, 48 * wScale, 48 * wScale);
    [backButton setBackgroundImage:[UIImage imageNamed:@"icon_normal_back"] forState:(UIControlStateNormal)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"icon_pressed_back"] forState:(UIControlStateHighlighted)];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16 * wScale + CGRectGetMaxX(backButton.frame), 40 * hScale, 135 * wScale, 32 * hScale)];
    titleLabel.text = @"返回";
    titleLabel.textColor = [UIColor hexString:@"#FF274A72"];
//    titleLabel.textColor=[UIColor redColor];
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self addSubview:titleLabel];
    
    UIButton *backBGButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    backBGButton.frame = CGRectMake(47 * wScale, 32 * hScale, 199 * wScale, 48 * wScale);
    [backBGButton addTarget:self action:@selector(backButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:backBGButton];
    [self bringSubviewToFront:backBGButton];
    
    CGRect tableViewCgrect = CGRectMake(47 * wScale, 80 * hScale, frame.size.width - 47 * wScale, frame.size.height - 80 * hScale);
    self.tableView = [[UITableView alloc]initWithFrame:tableViewCgrect style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    [self.tableView registerClass:[LLFCarModelTableViewCell class] forCellReuseIdentifier:kCell_1];
    [self.tableView registerClass:[LLFCarModelDetailTableViewCell class] forCellReuseIdentifier:kCell_2];
}
- (void)setCarModelDic:(NSMutableDictionary *)carModelDic
{
    _carModelDic = carModelDic;
    [_tableView reloadData];
}
#pragma mark 返回
- (void)backButtonAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(carModelDetailButtonState:)]) {
        [self.delegate carModelDetailButtonState:@"返回"];
    }
}
#pragma tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray *keyArr = [self.carModelDic allKeys];
    return keyArr.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        NSArray *keyArr = [self sortWithArr:[self.carModelDic allKeys]];
        NSArray *carModelArr = [self.carModelDic objectForKey:keyArr[section - 1]];
        return carModelArr.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 268 * hScale;
    }else{
        return 218 * hScale;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LLFCarModelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell_1 forIndexPath:indexPath];
        if (self.carSeriesCarModel.catModelImgAdree && self.carSeriesCarModel.catModelImgAdree.length > 0) {
            [cell.carImageView sd_setImageWithURL:[NSURL URLWithString:self.carSeriesCarModel.catModelImgAdree] placeholderImage:[UIImage imageNamed:@"image_default_qiche"]];
        }else{
            cell.carImageView.image = [UIImage imageNamed:@"image_default_qiche"];
        }
        
        cell.carNameLabel.text = self.carSeriesCarModel.carModelName;
        cell.carPriceLabel.text = [NSString stringWithFormat:@"基础价格：%@元",[self.carSeriesCarModel.catModelPrice cut]];
        cell.selectImageView.hidden = YES;
        return cell;
    }else{
        LLFCarModelDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell_2 forIndexPath:indexPath];
        NSArray *keyArr = [self sortWithArr:[self.carModelDic allKeys]];
        NSArray *carModelArr = [self.carModelDic objectForKey:keyArr[indexPath.section - 1]];
        LLFCarModel *CarModel = carModelArr[indexPath.row];
        cell.topYearLabel.text = CarModel.catModelDetailYear;
        if (indexPath.row == 0) {
            cell.topYearLabel.hidden = NO;
        }else{
            cell.topYearLabel.hidden = YES;
        }
        cell.carModelDetailLabel.text = CarModel.catModelDetailName;
        cell.carModelPriceLabel.text = [NSString stringWithFormat:@"基础价格：%@元",[CarModel.catModelDetailPrice cut]];
        cell.carModelGchzjkLabel.text = CarModel.gchzjk;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0) {
        if (_delegate && [_delegate respondsToSelector:@selector(carModelDetailButtonState:)]) {
            NSArray *keyArr = [self sortWithArr:[self.carModelDic allKeys]];
            NSArray *carModelArr = [self.carModelDic objectForKey:keyArr[indexPath.section - 1]];
            LLFCarModel *CarModel = carModelArr[indexPath.row];
            CarModel.carSeriesID = self.carSeriesCarModel.carSeriesID;
            CarModel.carModelID = self.carSeriesCarModel.carModelID;
            CarModel.carModelName = self.carSeriesCarModel.carModelName;
            [self.delegate carModelDetailButtonState:CarModel];
        }
    }
    
}
//排序
- (NSArray *)sortWithArr:(NSArray *)arr
{
    NSArray *keyArr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        NSInteger int1 = [obj1 integerValue];
        NSInteger int2 = [obj2 integerValue];
        if (int1 > int2) {
            return -1;
        }else{
            return 1;
        }
    }];
    return keyArr;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
