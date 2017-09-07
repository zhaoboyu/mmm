//
//  LSFinancialProgramCollectionViewCell.m
//  YDJR
//
//  Created by 李爽 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFinancialProgramCollectionViewCell.h"
#import "Masonry.h"

@implementation LSFinancialProgramCollectionViewCell

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
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    bgView.backgroundColor = [UIColor hexString:@"#FFFFFF"];
	
    UIImageView *pictuerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 604 * hScale)];
	//pictuerImageView.image = [UIImage imageNamed:@"bg_jinrongfnagan"];
	pictuerImageView.userInteractionEnabled = YES;
	
    self.financialProgramTitleLabel = [[UILabel alloc]init];
	 [pictuerImageView addSubview:self.financialProgramTitleLabel];
	[self.financialProgramTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.mas_equalTo(32 * wScale);
		make.top.mas_equalTo(33 * hScale);
		make.height.mas_equalTo(30 * hScale);
	}];
    self.financialProgramTitleLabel.font = [UIFont systemFontOfSize:15];
    self.financialProgramTitleLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];

	self.bestProgramImageView = [[UIImageView alloc]initWithFrame:CGRectMake(282 * wScale, 30 * hScale, 104 * wScale, 36 * hScale)];
	self.bestProgramImageView.image = [UIImage imageNamed:@"tag_zuiyoufnagan"];
	[pictuerImageView addSubview:self.bestProgramImageView];
	[self.bestProgramImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.leading.mas_equalTo(self.financialProgramTitleLabel.mas_trailing).offset(18 * wScale);
		make.width.mas_equalTo(104 * wScale);
		make.top.mas_equalTo(30 * hScale);
		make.height.mas_equalTo(36 * hScale);
	}];
	self.bestProgramImageView.hidden = YES;
	
    self.editBtn = [[UIButton alloc]initWithFrame:CGRectMake(pictuerImageView.width - 86 * wScale, 36 * hScale, 54 * wScale, 24 *hScale)];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:[UIColor whiteColor]];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
	self.editBtn.titleLabel.alpha = 0.65;
    [pictuerImageView addSubview:self.editBtn];
    
    UIView *cuttingLineView = [[UIView alloc]initWithFrame:CGRectMake(32 * wScale, 94 * hScale, self.frame.size.width - 64 *wScale, 2 * hScale)];
    cuttingLineView.backgroundColor = [UIColor hexString:@"#33FFFFFF"];
    [pictuerImageView addSubview:cuttingLineView];
    
    //融资规模 标题
    UILabel *financialSizeTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(cuttingLineView.frame) + 56 * hScale, 142 * wScale, 24 * hScale)];
    financialSizeTitleLabel.text = @"融资规模(元)";
    financialSizeTitleLabel.font = [UIFont systemFontOfSize:12];
    financialSizeTitleLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
	financialSizeTitleLabel.alpha = 0.65;
    [pictuerImageView addSubview:financialSizeTitleLabel];
    
    //融资规模
    self.financialSizeLabel = [[UILabel alloc]initWithFrame:CGRectMake( 32 * wScale, CGRectGetMaxY(financialSizeTitleLabel.frame) + 16 * hScale, self.frame.size.width, 44 * hScale)];
    self.financialSizeLabel.font = [UIFont systemFontOfSize:22];
    self.financialSizeLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    [pictuerImageView addSubview:self.financialSizeLabel];
    
    //虚线
    UIImageView *dottedLineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(self.financialSizeLabel.frame) + 56 * hScale, self.frame.size.width - 64 * wScale, 1.2*hScale)];
    dottedLineImgView.image = [UIImage imageNamed:@"line_cell_xuxian"];
    [pictuerImageView addSubview:dottedLineImgView];
    
    //贷款期限 标题
    UILabel *loanPeriodTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(dottedLineImgView.frame) + 48 * hScale, 142 * wScale, 24 * hScale)];
    loanPeriodTitleLabel.text = @"贷款期限(月)";
    loanPeriodTitleLabel.font = [UIFont systemFontOfSize:12];
    loanPeriodTitleLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
	loanPeriodTitleLabel.alpha = 0.65;
    [pictuerImageView addSubview:loanPeriodTitleLabel];

    //贷款期限
    self.loanPeriodLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(loanPeriodTitleLabel.frame) + 16 *hScale, self.frame.size.width/2, 44 * hScale)];
    self.loanPeriodLabel.font = [UIFont systemFontOfSize:22];
    self.loanPeriodLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    [pictuerImageView addSubview:self.loanPeriodLabel];
    
    //首付比例 标题
    UILabel *downpaymentsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 + 32 * wScale, CGRectGetMaxY(dottedLineImgView.frame) + 48 * hScale, 142 * wScale, 24 * hScale)];
    downpaymentsTitleLabel.text = @"首付比例(%)";
    downpaymentsTitleLabel.font = [UIFont systemFontOfSize:12];
    downpaymentsTitleLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
	downpaymentsTitleLabel.alpha = 0.65;
    [pictuerImageView addSubview:downpaymentsTitleLabel];

    //首付比例
    self.downpaymentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 + 32 * wScale, CGRectGetMaxY(loanPeriodTitleLabel.frame) + 16 * hScale, self.frame.size.width/2, 44 * hScale)];
    self.downpaymentsLabel.font = [UIFont systemFontOfSize:22];
    self.downpaymentsLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    [pictuerImageView addSubview:self.downpaymentsLabel];
    
    //月供金额 标题
    UILabel *monthlyMoneyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(self.loanPeriodLabel.frame) + 32 * hScale, 142 * wScale, 24 * hScale)];
    monthlyMoneyTitleLabel.text = @"月供金额(元)";
    monthlyMoneyTitleLabel.font = [UIFont systemFontOfSize:12];
    monthlyMoneyTitleLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
	monthlyMoneyTitleLabel.alpha = 0.65;
    [pictuerImageView addSubview:monthlyMoneyTitleLabel];
	
	//白色横条
	UIView *whiteRailView = [[UIView alloc]initWithFrame:CGRectMake(0, 594 * hScale, self.frame.size.width, 10 * hScale)];
	whiteRailView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
	whiteRailView.alpha = 0.3;
	[pictuerImageView addSubview:whiteRailView];
    
    //月供金额
    self.monthlyMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(32 * wScale, CGRectGetMaxY(monthlyMoneyTitleLabel.frame) + 16 * hScale, self.frame.size.width/2, 44*hScale)];
    self.monthlyMoneyLabel.font = [UIFont systemFontOfSize:22];
    self.monthlyMoneyLabel.textColor = [UIColor hexString:@"#FFFFFFFF"];
    [pictuerImageView addSubview:self.monthlyMoneyLabel];
    
    //实际购车成本 标题
    UILabel *costOfCarTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 688 * hScale, self.frame.size.width, 24 * hScale)];
    costOfCarTitleLabel.text = @"实际购车成本";
    costOfCarTitleLabel.font = [UIFont systemFontOfSize:12];
    costOfCarTitleLabel.textAlignment = NSTextAlignmentCenter;
    costOfCarTitleLabel.textColor = [UIColor hexString:@"#FF999999"];
    [bgView addSubview:costOfCarTitleLabel];
    
    //实际购车成本
    self.costOfCarLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(costOfCarTitleLabel.frame) + 16 * hScale, self.frame.size.width, 44*hScale)];
    self.costOfCarLabel.font = [UIFont systemFontOfSize:22];
    self.costOfCarLabel.textAlignment = NSTextAlignmentCenter;
    self.costOfCarLabel.textColor = [UIColor hexString:@"#FF333333"];
    [bgView addSubview:self.costOfCarLabel];
    
    //选择
    self.chooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(102 * wScale, CGRectGetMaxY(self.costOfCarLabel.frame) + 84 * hScale, 456 * wScale, 68 * hScale)];
    [self.chooseBtn setTitle:@"选择" forState:UIControlStateNormal];
    [self.chooseBtn setTitle:@"已选择" forState:UIControlStateSelected];
    self.chooseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.chooseBtn.layer.masksToBounds = YES;
    self.chooseBtn.layer.borderWidth = 0.5f;
    self.chooseBtn.layer.borderColor = [UIColor hexString:@"#FF999999"].CGColor;
    [self.chooseBtn setTitleColor:[UIColor hexString:@"#FF666666"]];
    self.chooseBtn.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
    [bgView addSubview:self.chooseBtn];
	
	//删除
	self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(102 * wScale, CGRectGetMaxY(self.costOfCarLabel.frame) + 84 * hScale, 456 * wScale, 68 * hScale)];
	[self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
	self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
	self.deleteButton.layer.masksToBounds = YES;
	self.deleteButton.layer.borderWidth = 0.5f;
	self.deleteButton.layer.borderColor = [UIColor hexString:@"#FF999999"].CGColor;
	[self.deleteButton setTitleColor:[UIColor hexString:@"#FFFFFFFF"]];
	self.deleteButton.backgroundColor = [UIColor hexString:@"#FFFF5252"];
	[bgView addSubview:self.deleteButton];
	self.deleteButton.hidden = YES;
	
    //添加金融方案
    self.addFinancialProgramImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.addFinancialProgramImgView.image = [UIImage imageNamed:@"btn_normal_tianjiajinrongfangan"];
    self.addFinancialProgramImgView.hidden = YES;
	
    [bgView addSubview:pictuerImageView];
	self.pictuerImageView = pictuerImageView;
    [self addSubview:bgView];
    
    [self addSubview:self.addFinancialProgramImgView];
}

@end
