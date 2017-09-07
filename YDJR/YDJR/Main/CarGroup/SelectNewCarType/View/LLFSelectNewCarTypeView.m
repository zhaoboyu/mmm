//
//  LLFSelectNewCarTypeView.m
//  YDJR
//
//  Created by 吕利峰 on 2016/12/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFSelectNewCarTypeView.h"
#import "LLFRunloopView.h"
#import "LLFRunloopModel.h"
#import "LLFCarBuyTypeListView.h"
#import "LLFCarDetailInfoView.h"
#import "LLFMechanismCarModel.h"
#import "LLFCarModel.h"
@interface LLFSelectNewCarTypeView ()<LLFCarBuyTypeListViewDelegate>
@property (nonatomic,strong)LLFCarBuyTypeListView *carBuyTypeListView;
@property (nonatomic,strong)LLFRunloopView *runloopView;
@property(nonatomic,strong)LLFCarDetailInfoView *carDetailInfoView;

@end

@implementation LLFSelectNewCarTypeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.backgroundColor = [UIColor whiteColor];
    self.runloopView = [[LLFRunloopView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 956 * hScale)];
    [self addSubview:self.runloopView];
    
    self.carBuyTypeListView = [[LLFCarBuyTypeListView alloc]initWithFrame:CGRectMake(kWidth - 610 * wScale, 168 * hScale, 540 * wScale, 620 * hScale)];
    self.carBuyTypeListView.delegate = self;
    [self addSubview:self.carBuyTypeListView];
    
    self.carDetailInfoView = [[LLFCarDetailInfoView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.runloopView.frame), kWidth, kHeight - CGRectGetHeight(self.runloopView.frame))];
    [self addSubview:self.carDetailInfoView];
    
    self.customizedFinancialPlanButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.customizedFinancialPlanButton.frame = CGRectMake(kWidth - 320 * wScale, kHeight - 128 * hScale, 240 * wScale, 72 * hScale);
    [self.customizedFinancialPlanButton setBackgroundImage:[UIImage imageNamed:@"LLF_SelectNewCarType_btn_normal_dingzhijinrongfangan"] forState:(UIControlStateNormal)];
//    [customizedFinancialPlanButton addTarget:self action:@selector(customizedFinancialPlanButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.customizedFinancialPlanButton setTitle:@"定制金融方案" forState:UIControlStateNormal];
    self.customizedFinancialPlanButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.customizedFinancialPlanButton setTitleColor:[UIColor hex:@"#FFFFFFFF"]];
    [self addSubview:self.customizedFinancialPlanButton];
    [self bringSubviewToFront:self.customizedFinancialPlanButton];
    
}

- (void)setMechanismCarModel:(LLFMechanismCarModel *)mechanismCarModel
{
    _mechanismCarModel = mechanismCarModel;
    LLFRunloopModel *runloopModel = [LLFRunloopModel new];
    runloopModel.imageUrlArr = [NSMutableArray arrayWithArray:mechanismCarModel.carSeriesImg];
    self.runloopView.dataModel = runloopModel;
}
- (void)setCarBuyTypeDic:(NSMutableDictionary *)carBuyTypeDic
{
    _carBuyTypeDic = carBuyTypeDic;
    self.carBuyTypeListView.carBuyTypeDic = carBuyTypeDic;
    NSArray *keyArr = [Tool sortWithArr:[carBuyTypeDic allKeys] sort:@"0"];
    if (keyArr.count > 0) {
        NSArray *valueArr = [carBuyTypeDic objectForKey:keyArr[0]];
        LLFCarModel *carModel = valueArr[0];
        self.carDetailInfoView.leftDetailDic = [self getCarDetailLeftDic:carModel];
        self.carDetailInfoView.rightDetailDic = [self getCarDetailRightDic:carModel];
    }
    
}
#pragma mark LLFCarBuyTypeListViewDelegate
- (void)clickCarBuyListWith:(LLFCarModel *)carModel
{
    self.carDetailInfoView.leftDetailDic = [self getCarDetailLeftDic:carModel];
    self.carDetailInfoView.rightDetailDic = [self getCarDetailRightDic:carModel];
    if (_delegate && [_delegate respondsToSelector:@selector(clickCarBuyListWith:)]) {
        [self.delegate clickCarBuyListWith:carModel];
    }
}

- (NSMutableDictionary *)getCarDetailLeftDic:(LLFCarModel *)carModel
{
    NSMutableDictionary *leftDic = [NSMutableDictionary dictionary];
    if (carModel.bak1 && carModel.bak1.length > 0) {
        [leftDic setObject:carModel.bak1 forKey:@"车型"];
    }else{
        [leftDic setObject:@"" forKey:@"车型"];
    }
    if (carModel.catModelDetailPrice && carModel.catModelDetailPrice.length > 0) {
        NSString *catModelPrice = [NSString stringWithFormat:@"%.2f",[carModel.catModelDetailPrice doubleValue] / 10000];
        [leftDic setObject:catModelPrice forKey:@"厂商指导价(万元)"];
    }else{
        [leftDic setObject:@"" forKey:@"厂商指导价(万元)"];
    }
    
    if (carModel.gchzjk && carModel.gchzjk.length > 0) {
        [leftDic setObject:carModel.gchzjk forKey:@"国产合资进口"];
    }else{
        [leftDic setObject:@"" forKey:@"国产合资进口"];
    }
    
    if (carModel.jqxs && carModel.jqxs.length > 0) {
        [leftDic setObject:carModel.jqxs forKey:@"进气形式"];
    }else{
        [leftDic setObject:@"" forKey:@"进气形式"];
    }
    
    if (carModel.cc && carModel.cc.length > 0) {
        [leftDic setObject:carModel.cc forKey:@"长(mm)"];
    }else{
        [leftDic setObject:@"" forKey:@"长(mm)"];
    }
    return leftDic;
}

- (NSMutableDictionary *)getCarDetailRightDic:(LLFCarModel *)carModel
{
    NSMutableDictionary *rightDic = [NSMutableDictionary dictionary];
    if (carModel.kk && carModel.kk.length > 0) {
        [rightDic setObject:carModel.kk forKey:@"宽(mm)"];
    }else{
        [rightDic setObject:@"" forKey:@"宽(mm)"];
    }
    if (carModel.gg && carModel.gg.length > 0) {
        [rightDic setObject:carModel.gg forKey:@"高(mm)"];
    }else{
        [rightDic setObject:@"" forKey:@"高(mm)"];
    }
    
    if (carModel.zj && carModel.zj.length > 0) {
        [rightDic setObject:carModel.zj forKey:@"轴距(mm)"];
    }else{
        [rightDic setObject:@"" forKey:@"轴距(mm)"];
    }
    
    if (carModel.zgcs && carModel.zgcs.length > 0) {
        [rightDic setObject:carModel.zgcs forKey:@"最高车速(km/h)"];
    }else{
        [rightDic setObject:@"" forKey:@"最高车速(km/h)"];
    }
    
    if (carModel.jssj && carModel.jssj.length > 0) {
        [rightDic setObject:carModel.jssj forKey:@"加速时间(0-100km/h)"];
    }else{
        [rightDic setObject:@"" forKey:@"加速时间(0-100km/h)"];
    }
    
    
    
    return rightDic;
}
@end
