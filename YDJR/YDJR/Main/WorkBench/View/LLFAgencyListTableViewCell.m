//
//  LLFAgencyListTableViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 2017/5/25.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFAgencyListTableViewCell.h"
#import "LLFWorkBenchModel.h"

@interface LLFAgencyListTableViewCell ()
@property (nonatomic,strong)UILabel *customerNameLabel;
@property (nonatomic,strong)UILabel *productNameLabel;
@property (nonatomic,strong)UILabel *ppNameLabel;
@property (nonatomic,strong)UILabel *carModelLabel;
@property (nonatomic,strong)UILabel *rzqxLabel;
@property (nonatomic,strong)UILabel *creatDataLabel;
@property (nonatomic,strong)UILabel *stateLabel;
@property (nonatomic,strong)UIButton *stateButton;
@property (nonatomic,strong)UIView *bottomLineView;
@end

@implementation LLFAgencyListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    //客户姓名
    self.customerNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(29 * wScale, 25 * hScale, 136 * wScale, 31 * hScale)];
    self.customerNameLabel.textColor = [UIColor hex:@"#FF373D48"];
    self.customerNameLabel.font = [UIFont systemFontOfSize:12.0];
    self.customerNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.customerNameLabel];
    //产品名称
    self.productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.customerNameLabel.frame), CGRectGetMinX(self.customerNameLabel.frame), 266 * wScale, CGRectGetHeight(self.customerNameLabel.frame))];
    self.productNameLabel.textColor = [UIColor hex:@"#FF373D48"];
    self.productNameLabel.font = [UIFont systemFontOfSize:12.0];
    self.productNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.productNameLabel];
    //车辆品牌
    self.ppNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.productNameLabel.frame), CGRectGetMinX(self.customerNameLabel.frame), 146 * wScale, CGRectGetHeight(self.customerNameLabel.frame))];
    self.ppNameLabel.textColor = [UIColor hex:@"#FF373D48"];
    self.ppNameLabel.font = [UIFont systemFontOfSize:12.0];
    self.ppNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.ppNameLabel];
    //车辆型号
    self.carModelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.ppNameLabel.frame), CGRectGetMinX(self.customerNameLabel.frame), 228 * wScale, CGRectGetHeight(self.customerNameLabel.frame))];
    self.carModelLabel.textColor = [UIColor hex:@"#FF373D48"];
    self.carModelLabel.font = [UIFont systemFontOfSize:12.0];
    self.carModelLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.carModelLabel];
    //融资期限(月)
    self.rzqxLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.carModelLabel.frame), CGRectGetMinX(self.customerNameLabel.frame), 147 * wScale, CGRectGetHeight(self.customerNameLabel.frame))];
    self.rzqxLabel.textColor = [UIColor hex:@"#FF373D48"];
    self.rzqxLabel.font = [UIFont systemFontOfSize:12.0];
    self.rzqxLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.rzqxLabel];
    //日期
    self.creatDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.rzqxLabel.frame), CGRectGetMinX(self.customerNameLabel.frame), 189 * wScale, CGRectGetHeight(self.customerNameLabel.frame))];
    self.creatDataLabel.textColor = [UIColor hex:@"#FF373D48"];
    self.creatDataLabel.font = [UIFont systemFontOfSize:12.0];
    self.creatDataLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.creatDataLabel];
    //状态
    self.stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.creatDataLabel.frame), CGRectGetMinX(self.customerNameLabel.frame), 169 * wScale, CGRectGetHeight(self.customerNameLabel.frame))];
    self.stateLabel.textColor = [UIColor hex:@"#FF373D48"];
    self.stateLabel.font = [UIFont systemFontOfSize:12.0];
    self.stateLabel.textAlignment = NSTextAlignmentLeft;
    
    self.stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.stateButton.frame = CGRectMake(CGRectGetMaxX(self.creatDataLabel.frame), 16 * hScale, 169 * wScale, 48 * hScale);
    [self.stateButton addTarget:self action:@selector(stateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.stateButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.stateButton setTitleColor:[UIColor hex:@"#FFFFFFFF"]];
    [self.stateButton setBackgroundImage:[UIImage imageNamed:@"workBench_button"] forState:(UIControlStateNormal)];

    
    self.bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame), 1 * hScale)];
    self.bottomLineView.backgroundColor = [UIColor hex:@"#FFD9D9D9"];
    [self addSubview:self.bottomLineView];
}
- (void)layoutSubviews
{
    self.bottomLineView.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame) - 1 * hScale, CGRectGetWidth(self.contentView.frame), 1 * hScale);
}
- (void)setWorkBenchModel:(LLFWorkBenchModel *)workBenchModel
{
    _workBenchModel = workBenchModel;
    self.customerNameLabel.text = workBenchModel.customerName;
    self.productNameLabel.text = workBenchModel.productName;
    self.ppNameLabel.text = workBenchModel.carBrand;
    self.carModelLabel.text = workBenchModel.carModel;
    self.rzqxLabel.text = workBenchModel.businessTerm;
    self.creatDataLabel.text = workBenchModel.showCreatTime;
    if (workBenchModel.isClickButtonState) {
        [self.stateButton setTitle:workBenchModel.showState forState:(UIControlStateNormal)];
        if (![self.stateButton superview]) {
            [self.contentView addSubview:self.stateButton];
        }
        if ([self.stateLabel superview]) {
            [self.stateLabel removeFromSuperview];
        }
    }else{
        self.stateLabel.text = workBenchModel.showState;
        if ([self.stateButton superview]) {
            [self.stateButton removeFromSuperview];
        }
        if (![self.stateLabel superview]) {
            [self.contentView addSubview:self.stateLabel];
        }
    }
    self.stateLabel.text = workBenchModel.showState;
}
- (void)stateButtonAction:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickButtonWithWorkBenchModel:)]) {
        [_delegate clickButtonWithWorkBenchModel:_workBenchModel];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
