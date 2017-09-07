//
//  LLFDIYInsuranceInfoListTableViewCell.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/12.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFDIYInsuranceInfoListTableViewCell.h"
#import "LLFDIYInsuranceView.h"
#import "LLFInsuranceDataModel.h"
@interface LLFDIYInsuranceInfoListTableViewCell ()
//@property (nonatomic,strong)LLFDIYInsuranceView *oneInsuranceView;
//@property (nonatomic,strong)LLFDIYInsuranceView *twoInsuranceView;
//@property (nonatomic,strong)LLFDIYInsuranceView *threeInsuranceView;
@property (nonatomic,strong)NSMutableArray *viewArr;
@end

@implementation LLFDIYInsuranceInfoListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}
- (void)setupView
{
//    self.contentView.backgroundColor = [UIColor redColor];
    self.viewArr = [NSMutableArray array];
    CGFloat cellViewW = 1336 / 3 * wScale;
    for (int i = 0; i < 3; i++) {
        LLFDIYInsuranceView *oneInsuranceView = [LLFDIYInsuranceView initWithFrame:CGRectMake(cellViewW * i, 0, cellViewW, self.contentView.frame.size.height)];
//        oneInsuranceView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:oneInsuranceView];
        [self.viewArr addObject:oneInsuranceView];
    }
}
- (void)setModelArr:(NSMutableArray *)modelArr
{
    _modelArr = modelArr;
    for (int i = 0; i < modelArr.count; i++) {
        LLFInsuranceDataModel *model = modelArr[i];
        LLFDIYInsuranceView *oneInsuranceView = self.viewArr[i];
        oneInsuranceView.yueLabel.text = model.oneStr;
        oneInsuranceView.yearLabel.text = [model.twoStr cut];
        oneInsuranceView.threeYearLabel.text = [model.threeStr cut];
        oneInsuranceView.isSum = model.isSum;
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
