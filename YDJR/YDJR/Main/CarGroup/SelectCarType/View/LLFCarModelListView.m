//
//  LLFCarModelListView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/7.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFCarModelListView.h"
#import "LLFCarSeriesCarModel.h"
#import "LLFCarModelTableViewCell.h"
#define kCell @"LLFCarModelTableViewCell"
@interface LLFCarModelListView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIImageView *nullImageView;
@end

@implementation LLFCarModelListView

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
    titleLabel.text = @"查看全部";
    titleLabel.textColor = [UIColor hexString:@"#FF274A72"];
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
    [self.tableView registerClass:[LLFCarModelTableViewCell class] forCellReuseIdentifier:kCell];
}
- (void)setSeriesCarModelArr:(NSMutableArray *)seriesCarModelArr
{
    _seriesCarModelArr = seriesCarModelArr;
    [_tableView reloadData];
}
#pragma mark 返回
- (void)backButtonAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(carModelListButtonState:)]) {
        [self.delegate carModelListButtonState:@"返回"];
    }
}
#pragma tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.seriesCarModelArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 316 * hScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LLFCarModelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    LLFCarSeriesCarModel *seriesCarModel = self.seriesCarModelArr[indexPath.row];

    if (seriesCarModel.catModelImgAdree && seriesCarModel.catModelImgAdree.length > 0) {
        [cell.carImageView sd_setImageWithURL:[NSURL URLWithString:seriesCarModel.catModelImgAdree] placeholderImage:[UIImage imageNamed:@"image_default_qiche"]];
    }else{
        cell.carImageView.image = [UIImage imageNamed:@"image_default_qiche"];
    }
    
    cell.carNameLabel.text = seriesCarModel.carModelName;
    cell.carPriceLabel.text = [NSString stringWithFormat:@"基础价格：%@元",seriesCarModel.catModelPrice];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(carModelListButtonState:)]) {
        LLFCarSeriesCarModel *seriesCarModel = self.seriesCarModelArr[indexPath.row];
        [self.delegate carModelListButtonState:seriesCarModel];
    }
}

@end
