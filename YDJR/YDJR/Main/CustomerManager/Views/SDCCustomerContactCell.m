//
//  SDCCustomerContactCell.m
//  YDJR
//
//  Created by sundacheng on 16/10/10.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDCCustomerContactCell.h"
#import "SDCCustomerContactModel.h"

@implementation SDCCustomerContactCell
{
    UILabel *_customPhoneNum; //用户联系电话
    UIImageView *_accessImg; //箭头
}

#pragma mark - init
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView *)tableView {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCellView];
    }
    return self;
}

#pragma mark - 清理列表
- (void)prepareForReuse
{
    [super prepareForReuse];
    _customName.text = nil;
    _accessImg = nil;
    _customPhoneNum.text = nil;
}

#pragma mark - UI
- (void)initCellView {
    _customName = [[UILabel alloc] init];
    [self.contentView addSubview:_customName];
    [_customName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-10);
    }];

    _customName.font = [UIFont systemFontOfSize:17];
    _customName.textColor = [UIColor hex:@"#333333"];
    
    _customPhoneNum = [[UILabel alloc] init];
    [self.contentView addSubview:_customPhoneNum];
    [_customPhoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(11);
    }];
    _customPhoneNum.text = @"11212";
    _customPhoneNum.textColor = [UIColor hex:@"#A7A7A7"];
    _customPhoneNum.font = [UIFont systemFontOfSize:12];
    
    _accessImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_accessImg];
    [_accessImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-11);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(7, 13));
    }];
    _accessImg.image = [UIImage imageNamed:@"Path_2"];
}

#pragma mark - 刷新数据
- (void)reloadDataWithModel:(SDCCustomerContactModel *)model {
    _customPhoneNum.text = model.customerPhone;
    
    _customName.text = model.customerName;
}

@end
