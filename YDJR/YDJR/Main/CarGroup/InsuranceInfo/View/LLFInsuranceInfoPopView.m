//
//  LLFInsuranceInfoPopView.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/11.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFInsuranceInfoPopView.h"
#import "LLFSUMView.h"
#import "LLFDIYCardView.h"
#import "LLFDIYInsuranceInfoListView.h"
#import "LLFInsuranceDataModel.h"
@interface LLFInsuranceInfoPopView ()<LLFSUMViewDelegate,LLFDIYCardViewDelegate,LLFDIYInsuranceInfoListViewDelegate,UITextFieldDelegate>
{
    float _one;//碰撞次数
    float _two;//出险次数
    float _three;//平均修理费
}
@property (nonatomic,strong)UIView *bgourpView;
@property (nonatomic,strong)UIView *bgWithView;
@property (nonatomic,strong)UIScrollView *bgView;
@property (nonatomic,strong)NSMutableArray *sumViewArr;

@property (nonatomic,strong)LLFSUMView *oneSumView;
@property (nonatomic,strong)LLFSUMView *twoSumView;
@property (nonatomic,strong)UITextField *sumTextField;
@property (nonatomic,strong)LLFSUMView *threeSumView;
@property (nonatomic,strong)LLFSUMView *fourSumView;

@property (nonatomic,strong)LLFDIYCardView *cardOneView;
@property (nonatomic,strong)LLFDIYCardView *cardTwoView;

@property (nonatomic,strong)LLFDIYInsuranceInfoListView *insuranceInfoListView;
@end

@implementation LLFInsuranceInfoPopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hexString:@"#4D000000"];
        _one = 4;
        _two = 2;
        _three = 1500;
//        [self p_setupView];
    }
    return self;
}

- (void)p_setupViewWithSumMoney:(NSString *)sumMoney
{
    self.bgourpView = [[UIView alloc]initWithFrame:CGRectMake(46 * wScale, 82 * hScale, kWidth - 92 * wScale, kHeight - 164 * hScale)];
    self.bgourpView.backgroundColor = [UIColor hex:@"#4DFFFFFF"];
//    self.bgourpView.layer.cornerRadius = 5;
    [self addSubview:self.bgourpView];
    
    self.bgWithView = [[UIView alloc]initWithFrame:CGRectMake(10 * wScale, 10 * hScale, CGRectGetWidth(self.bgourpView.frame) - 20 * wScale, CGRectGetHeight(self.bgourpView.frame) - 20 * hScale)];
    self.bgWithView.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
    [self.bgourpView addSubview:self.bgWithView];
    
    
    UIButton *colseButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    colseButton.frame = CGRectMake(0, 0, 148 * wScale, 96 * hScale);
    [colseButton setTitle:@"关闭" forState:(UIControlStateNormal)];
    [colseButton setTitleColor:[UIColor hexString:@"#FF666666"] forState:(UIControlStateNormal)];
    colseButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [colseButton addTarget:self action:@selector(colseButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bgWithView addSubview:colseButton];
    
    UILabel *topTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.bgWithView.frame) / 2 - 100 * wScale, 0, 200 * wScale, 96 * hScale)];
    topTitleLabel.text = @"花费对比";
    topTitleLabel.textColor = [UIColor hexString:@"#FF333333"];
    topTitleLabel.font = [UIFont systemFontOfSize:17.0];
    topTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.bgWithView addSubview:topTitleLabel];
    
    UIView *oneLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 97 * hScale, CGRectGetWidth(self.bgWithView.frame), 1 * hScale)];
    oneLineView.backgroundColor = [UIColor hex:@"#FFD9D9D9"];
    [self.bgWithView addSubview:oneLineView];
    
    [self creatTopUIWithView:oneLineView];
    
    UIView *botmLineView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(oneLineView.frame) + 196 * hScale, self.bgWithView.frame.size.width, 24 * hScale)];
    botmLineView.backgroundColor = [UIColor hexString:@"#FFF3F3F3"];
    [self.bgWithView addSubview:botmLineView];
    
    //---------------------------
    
    
//    UIView *botmLineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(insuranceyearLabel.frame), 29 * hScale + CGRectGetMaxY(insuranceyearLabel.frame), 104 * wScale, 1 * hScale)];
//    botmLineView.backgroundColor = [UIColor hexString:@"#666666"];
//    [self.bgWithView addSubview:botmLineView];
    
//    UIView *twoLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(botmLineView.frame), CGRectGetWidth(self.bgourpView.frame), 1 * hScale)];
//    twoLineView.backgroundColor = LLFColorline();
//    [self.bgWithView addSubview:twoLineView];
    
    self.bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(botmLineView.frame), CGRectGetWidth(self.bgWithView.frame), CGRectGetHeight(self.bgWithView.frame) - CGRectGetMaxY(botmLineView.frame))];
//    self.bgView.backgroundColor = [UIColor redColor];
//    self.bgView.layer.cornerRadius = 5;
    self.bgView.contentSize = CGSizeMake(self.bgView.frame.size.width, 1502 * hScale);
    self.bgView.showsVerticalScrollIndicator = NO;
    [self.bgWithView addSubview:self.bgView];
    
    UILabel *insuranceyearLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, 32 * hScale, 200 * wScale, 30 * hScale)];
    insuranceyearLabel.text = @"保险期限";
    insuranceyearLabel.textColor = [UIColor hexString:@"#FF666666"];
    insuranceyearLabel.font = [UIFont systemFontOfSize:15.0];
    [self.bgView addSubview:insuranceyearLabel];
    
    [self creatLeftCardView];
    [self creatRightListView];

}
- (void)creatTopUIWithView:(UIView *)view
{
    self.oneSumView = [LLFSUMView initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), 356 * wScale, 196 * hScale) sumTitle:@"平均年碰撞次数" souce:_one delegate:self isSum:YES lestValue:0];
    [self.bgWithView addSubview:self.oneSumView];
    
    self.twoSumView = [LLFSUMView initWithFrame:CGRectMake(CGRectGetMaxX(self.oneSumView.frame), CGRectGetMaxY(view.frame), CGRectGetWidth(self.oneSumView.frame), CGRectGetHeight(self.oneSumView.frame)) sumTitle:@"平均年出险次数" souce:_two delegate:self isSum:YES lestValue:1];
    [self.bgWithView addSubview:self.twoSumView];
    
    UILabel *sumTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.twoSumView.frame), 48 * hScale + CGRectGetMinY(self.twoSumView.frame), 388 * wScale, 24 * hScale)];
    sumTitleLabel.text = @"平均修理费(元)";
    sumTitleLabel.textColor = [UIColor hexString:@"#FF999999"];
    sumTitleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.bgWithView addSubview:sumTitleLabel];
    
    self.sumTextField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMinX(sumTitleLabel.frame), CGRectGetMaxY(sumTitleLabel.frame) + 24 * hScale, CGRectGetWidth(sumTitleLabel.frame), 44 * hScale)];
    self.sumTextField.text = [[NSString stringWithFormat:@"%.2f",_three] cut];
    self.sumTextField.textColor = [UIColor hexString:@"#FF333333"];
    self.sumTextField.delegate = self;
    self.sumTextField.font = [UIFont systemFontOfSize:22.0];
    self.sumTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.bgWithView addSubview:self.sumTextField];
    
    self.threeSumView = [LLFSUMView initWithFrame:CGRectMake(CGRectGetMaxX(self.sumTextField.frame), CGRectGetMaxY(view.frame), 388 * wScale, 196 * hScale) sumTitle:@"自付修理费(元)" souce:[self getZiFuMoney] delegate:self isSum:NO lestValue:0];
    [self.bgWithView addSubview:self.threeSumView];
    
    self.fourSumView = [LLFSUMView initWithFrame:CGRectMake(CGRectGetMaxX(self.threeSumView.frame), CGRectGetMaxY(view.frame), 388 * wScale, 196 * hScale) sumTitle:@"下年保险系数" souce:[self getInsuranceSum] delegate:self isSum:NO lestValue:0];
    [self.bgWithView addSubview:self.fourSumView];
    
}
//获取自负修理费
- (float)getZiFuMoney
{
    //(平均碰撞次数-平均出险次数)*平均修理费 = 自负修理费
    float money = (_one - _two) * _three;
    return money;
}
//获取保险系数
- (float)getInsuranceSum
{
    if (_two == 1) {
        return 1;
    }else if (_two == 2){
        return 1.25;
    }else if (_two == 3){
        return 1.5;
    }else if (_two == 4){
        return 1.75;
    }else if (_two == 0){
        return 0.095;
    }else{
        return 2;
    }
}
//获取保险费用列表model数据
- (NSMutableArray *)getInsuranceInfoDatamodelList
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i < 14; i ++) {
        NSMutableArray *modelArr = [NSMutableArray array];
        
        LLFInsuranceDataModel *model1 = [[LLFInsuranceDataModel alloc]init];
        
        if (i == 1) {
            model1.twoStr = self.sumInsurance;
            model1.oneStr = [NSString stringWithFormat:@"%d",i];
            model1.threeStr = [NSString stringWithFormat:@"%.0f",[self.sumInsurance floatValue] * 3 / 12];
            model1.isSum = NO;
        }else if (i == 13){
            model1.twoStr = [NSString stringWithFormat:@"%.0f",[self getZiFuMoney] + [self.sumInsurance floatValue]];
            model1.oneStr = @"总计";
            model1.threeStr = [NSString stringWithFormat:@"%.0f",[self.sumInsurance floatValue] * 3];
            model1.isSum = YES;
        }else{
            model1.twoStr = [NSString stringWithFormat:@"%.0f",[self getZiFuMoney] / 11];
            model1.oneStr = [NSString stringWithFormat:@"%d",i];
            model1.threeStr = [NSString stringWithFormat:@"%.0f",[self.sumInsurance floatValue] * 3 / 12];
            model1.isSum = NO;
        }
        
        [modelArr addObject:model1];
        
        LLFInsuranceDataModel *model2 = [[LLFInsuranceDataModel alloc]init];
        
        if (i == 1) {
            model2.oneStr = [NSString stringWithFormat:@"%d",i + 12];
            model2.twoStr = [NSString stringWithFormat:@"%.0f",[self.sumInsurance floatValue] * [self getInsuranceSum]];
            model2.threeStr = @"-";
            model2.isSum = NO;

        }else if (i == 13){
            model2.oneStr = @"总计";
            model2.twoStr = [NSString stringWithFormat:@"%.0f",[self getZiFuMoney] + ([self.sumInsurance floatValue] * [self getInsuranceSum])];
            model2.threeStr = @"-";
            model2.isSum = YES;
        }else{
            model2.oneStr = [NSString stringWithFormat:@"%d",i + 12];
            model2.twoStr = [NSString stringWithFormat:@"%.0f",[self getZiFuMoney] / 11];
            model2.threeStr = @"-";
            model2.isSum = NO;
            
        }
        [modelArr addObject:model2];
        
        LLFInsuranceDataModel *model3 = [[LLFInsuranceDataModel alloc]init];
        
        if (i == 1) {
            model3.oneStr = [NSString stringWithFormat:@"%d",i + 24];
            model3.twoStr = [NSString stringWithFormat:@"%.0f",[self.sumInsurance floatValue] * [self getInsuranceSum] * [self getInsuranceSum]];
            model3.threeStr = @"-";
            model3.isSum = NO;

        }else if (i == 13){
            model3.oneStr = @"总计";
            model3.twoStr = [NSString stringWithFormat:@"%.0f",([self.sumInsurance floatValue] * [self getInsuranceSum] * [self getInsuranceSum]) + [self getZiFuMoney]];
            model3.threeStr = @"-";
            model3.isSum = YES;
        }else{
            model3.oneStr = [NSString stringWithFormat:@"%d",i + 24];
            model3.twoStr = @"-";
            model3.threeStr = @"-";
            model3.isSum = NO;
            
        }
        [modelArr addObject:model3];
        
        [arr addObject:modelArr];
        
    }
    
    return arr;
}
- (void)setSumInsurance:(NSString *)sumInsurance
{
    _sumInsurance = sumInsurance;
    [self p_setupViewWithSumMoney:sumInsurance];
    [self upDataForUI];
    
}
#pragma mark 左侧卡片
- (void)creatLeftCardView
{
    CGRect cardFrameOne = CGRectMake(32 * wScale, 86 * hScale, 472 * wScale, 296 * hScale);
    self.cardOneView = [LLFDIYCardView initWithFrame:cardFrameOne sumTitle:@"一年年买(三年)" allMoney:44125 myMoney:9000 delegate:self];
    self.cardOneView.bgImageView.image = [UIImage imageNamed:@"LLF_InsuranceInfo_bg_yiniannianmai"];
    [self.bgView addSubview:self.cardOneView];
    
    CGRect cardFrameTwo = CGRectMake(CGRectGetMinX(self.cardOneView.frame), 32 * hScale + CGRectGetMaxY(self.cardOneView.frame), 472 * wScale, 296 * hScale);
    self.cardTwoView = [LLFDIYCardView initWithFrame:cardFrameTwo sumTitle:@"三年联保" allMoney:30000 myMoney:0 delegate:self];
    self.cardTwoView.bgImageView.image = [UIImage imageNamed:@"LLF_InsuranceInfo_bg_sannianlianbao"];
    [self.bgView addSubview:self.cardTwoView];
}
#pragma mark 右侧列表
- (void)creatRightListView
{
    self.insuranceInfoListView = [[LLFDIYInsuranceInfoListView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cardOneView.frame) + 48 * wScale, 86 * hScale, 1336 * wScale, CGRectGetHeight(self.bgView.frame) - 86 * hScale)];
    self.insuranceInfoListView.delegate = self;
    self.insuranceInfoListView.infoListModelArr = [self getInsuranceInfoDatamodelList];
    [self.bgView addSubview:self.insuranceInfoListView];
}

//更新界面数据
- (void)upDataForUI
{
    self.threeSumView.souceLabel.text = [[NSString stringWithFormat:@"%.2f",[self getZiFuMoney]] cut];
    self.fourSumView.souceLabel.text = [[NSString stringWithFormat:@"%.2f",[self getInsuranceSum]] cut];
    self.insuranceInfoListView.infoListModelArr = [self getInsuranceInfoDatamodelList];
    self.cardOneView.allMoney = [self.sumInsurance floatValue] + ([self getZiFuMoney] * 2 )+ ([self.sumInsurance floatValue] * [self getInsuranceSum]) + ([self.sumInsurance floatValue] * [self getInsuranceSum] * [self getInsuranceSum]);
    self.cardOneView.myMoney = [self getZiFuMoney] * 2;
    
    self.cardTwoView.allMoney = [self.sumInsurance floatValue] * 3;
    self.cardTwoView.myMoney = 0;
}
- (void)colseButtonAction:(UIButton *)sender
{
    [self hideView];
}
- (void)showView
{
    self.bgourpView.frame = CGRectMake(46 * wScale, kHeight, kWidth - 92 * wScale, kHeight - 164 * hScale);
    [self addPopViewToWinder];
    [UIView animateWithDuration:0.2 animations:^{
        self.bgourpView.frame = CGRectMake(46 * wScale, 82 * hScale, kWidth - 92 * wScale, kHeight - 164 * hScale);
    } completion:^(BOOL finished) {
        
    }];
    
}
- (void)hideView
{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bgourpView.frame = CGRectMake(46 * wScale, kHeight, kWidth - 92 * wScale, kHeight - 164 * hScale);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark LLFSUMViewDelegate
- (void)sendSouceButtonstate:(float)state view:(UIView *)view
{
    if ([view isEqual:self.oneSumView]) {
        _one = state;
    }else{
        _two = state;
    }
    [self upDataForUI];
}
#pragma mark LLFDIYInsuranceInfoListViewDelegate
- (void)InsuranceInfoListButtonstate:(NSString *)state
{
    
}

#pragma mark LLFDIYCardViewDelegate
- (void)cardViewButtonstate:(NSString *)state
{
    
}
#pragma mark UITextViewDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
