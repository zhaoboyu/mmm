//
//  SDCCustomerOrderIntstCell.m
//  YDJR
//
//  Created by sundacheng on 16/10/12.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDCCustomerOrderIntstCell.h"
#import "SDCCustomerIntrestModel.h"
#import "LLFDafenqiBusinessModel.h"
#define CellWeight (kWidth - 578/2)

@implementation SDCCustomerOrderIntstCell
{
    UILabel *_titleLabel; //标题
    UILabel *_carShapLabel; //车型
    UILabel *_rentPriceLable; //租赁价格
    UILabel *_rentTimeLable; //租赁时间
    UILabel *_applyStateLable; //申请状态
    UILabel *_applyDateLable; //申请日期
}

#pragma mark - init
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}

#pragma mark - ui
- (void)initCellView {
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 396/2, 68/2)];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.backgroundColor = [UIColor hex:@"#21456E"];
    _titleLabel.layer.masksToBounds = YES;
    _titleLabel.layer.cornerRadius = 5;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat sectionW = (CellWeight - 32)/3;
    //车型
    _carShapLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 67, sectionW, 16)];
    _carShapLabel.numberOfLines = 0;
    [self setStyle:_carShapLabel];
    [self.contentView addSubview:_carShapLabel];
    //租赁价格
    _rentPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(16 + sectionW, 67, sectionW, 16)];
    [self setStyle:_rentPriceLable];
    [self.contentView addSubview:_rentPriceLable];
    //租赁时间
    _rentTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(16 + sectionW*2, 67, sectionW, 16)];
    [self setStyle:_rentTimeLable];
    [self.contentView addSubview:_rentTimeLable];
    //申请状态
    _applyStateLable = [[UILabel alloc] initWithFrame:CGRectMake(16 , 95, sectionW, 16)];
    [self setStyle:_applyStateLable];
    [self.contentView addSubview:_applyStateLable];
    //申请日期
    _applyDateLable = [[UILabel alloc] initWithFrame:CGRectMake(16 + sectionW, 95, sectionW, 16)];
    [self setStyle:_applyDateLable];
    [self.contentView addSubview:_applyDateLable];
}

- (void)setStyle:(UILabel *)label {
    label.font  = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor hex:@"#333333"];
}

#pragma mark - 刷新数据
- (void)reloadDataWithModel:(id)model {
    if ([model isKindOfClass:[LLFDafenqiBusinessModel class]]) {
        [self reloadDataWithLLFDafenqiBusinessModel:model];
    }else if ([model isKindOfClass:[SDCCustomerIntrestModel class]]){
        [self reloadDataWithSDCCustomerIntrestModel:model];
    }
}
- (void)reloadDataWithSDCCustomerIntrestModel:(SDCCustomerIntrestModel *)model
{
    _titleLabel.text = model.productName;
    //车型
    _carShapLabel.text = [NSString stringWithFormat:@"车辆型号：%@",model.catModelDetailName];
    //租赁价格
    _rentPriceLable.text = [NSString stringWithFormat:@"     融资金额：%@",model.carrzgm];
    //租赁时间
    _rentTimeLable.text = [NSString stringWithFormat:@"     融资期限：%@",model.instCounts];
    
    if ([model.processState isEqualToString:@"未申请"]) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"申请状态：未申请"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor hex:@"#FC5A5A"] range:NSMakeRange(5,3)];
        _applyStateLable.attributedText = str;
        
    } else {
        _applyStateLable.textColor = [UIColor hex:@"#333333"];
        _applyStateLable.text = [NSString stringWithFormat:@"申请状态：%@",model.processState];
    }
    
    //申请日期
    _applyDateLable.text = [NSString stringWithFormat:@"     申请日期：%@",model.createDate];
}
- (void)reloadDataWithLLFDafenqiBusinessModel:(LLFDafenqiBusinessModel *)model
{
    _titleLabel.text = @"达分期产品";
    //车型
    _carShapLabel.text = [NSString stringWithFormat:@"车辆型号：%@",model.carInfo.carModel];
    //租赁价格
    _rentPriceLable.text = [NSString stringWithFormat:@"     融资金额：%@",model.creditInfo.businessSum];
    //租赁时间
    _rentTimeLable.text = [NSString stringWithFormat:@"     融资期限：%@",model.creditInfo.businessTerm];
	
	
    if ([model.state isEqualToString:@"未申请"]) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"申请状态：未申请"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor hex:@"#FC5A5A"] range:NSMakeRange(5,3)];
        _applyStateLable.attributedText = str;
        
    } else {
        _applyStateLable.textColor = [UIColor hex:@"#333333"];
        _applyStateLable.text = [NSString stringWithFormat:@"申请状态：%@",model.state];
    }
    
    //申请日期
    _applyDateLable.text = [NSString stringWithFormat:@"     申请日期：%@",model.createDate];
}
@end
