//
//  LLFCheckAgencyListView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/5/15.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFCheckAgencyListView.h"
#import "LLFWorkBenchModel.h"

@interface LLFCheckAgencyListView ()<LLFAgencyListTableViewDelegate>

/**
 是否选中待办
 yes:待办
 no:已办
 */
@property (nonatomic,assign)BOOL isAgency;
/**
 代办标题
 */
@property (nonatomic,strong)UILabel *agencyTitleLabel;

/**
 已办标题
 */
@property (nonatomic,strong)UILabel *haveDoneTitleLabel;

/**
 任务列表
 */
@property (nonatomic,strong)UITableView *tableView;

/**
 下划线
 */
@property (nonatomic,strong)UIView *bottomLineView;
@property (nonatomic,strong)UIView *topBGView;
@property (nonatomic,strong)UIView *topTitleBGView;
@end

@implementation LLFCheckAgencyListView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
        self.isAgency = YES;
        [self p_setupView];
    }
    return self;
}
- (void)p_setupView
{
    self.layer.cornerRadius = 4 * wScale;
    self.layer.borderWidth = 1 * wScale;
    self.layer.borderColor = [UIColor hex:@"#FFD9D9D9"].CGColor;
    
    [self creatTopAgencyView];
    [self creattopTitleView];
    self.agencyListTableView = [[LLFAgencyListTableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topTitleBGView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(self.topTitleBGView.frame) - CGRectGetHeight(self.topBGView.frame))];
    self.agencyListTableView.delegate = self;
    [self addSubview:self.agencyListTableView];
    
}
#pragma mark UI布局
//创建顶部
- (void)creatTopAgencyView
{
    self.topBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 88 * hScale)];
    self.topBGView.backgroundColor = [UIColor hex:@"#FFF9F9FA"];
    [self addSubview:self.topBGView];
    
    
    //代办
    self.agencyTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(50 * wScale, 29 * hScale, 198 * wScale, 30 * hScale)];
    self.agencyTitleLabel.attributedText = [Tool makeText:@"我的待办(0)" index:4 firstColor:@"#FF333333" secondColor:@"#FFFF5956"];
    [self.topBGView addSubview:self.agencyTitleLabel];
    
    //下划线
    self.bottomLineView = [[UIView alloc]initWithFrame:CGRectMake(20 * wScale, CGRectGetMaxY(self.agencyTitleLabel.frame) + 25 * hScale, 218 * wScale, 4 * hScale)];
    self.bottomLineView.backgroundColor = [UIColor hex:@"#FF333333"];
    [self.topBGView addSubview:self.bottomLineView];
    
    UIButton *agencyTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    agencyTitleButton.frame = CGRectMake(0, 0, 248 * wScale, CGRectGetHeight(self.topBGView.frame));
    [agencyTitleButton addTarget:self action:@selector(agencyTitleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topBGView addSubview:agencyTitleButton];
    
    //间隔线
    UIView *midLineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.agencyTitleLabel.frame), (CGRectGetHeight(self.topBGView.frame) - 40 * hScale) / 2, 1 * wScale, 40 * hScale)];
    midLineView.backgroundColor = [UIColor hex:@"#FFD9D9D9"];
    [self.topBGView addSubview:midLineView];
    
    //已办
    self.haveDoneTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(midLineView.frame) + 31 * wScale, 29 * hScale, 198 * wScale, 30 * hScale)];
    self.haveDoneTitleLabel.attributedText = [Tool makeText:@"我的已办(0)" index:4 firstColor:@"#FF9D9D9D" secondColor:@"#FFFF5956"];
    [self.topBGView addSubview:self.haveDoneTitleLabel];
    
    UIButton *haveDoneTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    haveDoneTitleButton.frame = CGRectMake(CGRectGetMaxX(agencyTitleButton.frame), 0, 248 * wScale, CGRectGetHeight(self.topBGView.frame));
    [haveDoneTitleButton addTarget:self action:@selector(haveDoneTitleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topBGView addSubview:haveDoneTitleButton];
    
    //更多
//    UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.topBGView.frame) - 118 * wScale, CGRectGetHeight(self.topBGView.frame) - 59 * hScale, 74 * wScale, 30 * hScale)];
//    moreLabel.text = @"更多";
//    moreLabel.textColor = [UIColor hex:@"#FF373D48"];
//    moreLabel.font = [UIFont systemFontOfSize:15.0];
//    [self.topBGView addSubview:moreLabel];
//    
//    UIImageView *moreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(moreLabel.frame), 30 * hScale, 14 * wScale, 24 * hScale)];
//    moreImageView.image = [UIImage imageNamed:@"workBench_Combined Shape"];
//    [self.topBGView addSubview:moreImageView];
//    
//    UIButton *moerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    moerButton.frame = CGRectMake(CGRectGetWidth(self.topBGView.frame) - 118 * wScale, 0, 118 * wScale, CGRectGetHeight(self.topBGView.frame));
////    [moerButton setTitle:@"更多>" forState:(UIControlStateNormal)];
////    [moerButton setTitleColor:[UIColor hex:@"#FF373D48"]];
////    moerButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
//    [moerButton addTarget:self action:@selector(moerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.topBGView addSubview:moerButton];
    
}
//创建顶部标题栏
- (void)creattopTitleView
{
    self.topTitleBGView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topBGView.frame), CGRectGetWidth(self.topBGView.frame), 80 * hScale)];
    self.topTitleBGView.backgroundColor = [UIColor hex:@"#FFDFE3E7"];
    [self addSubview:self.topTitleBGView];
    
    //客户姓名
    UILabel *customerNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(29 * wScale, 25 * hScale, 136 * wScale, 31 * hScale)];
    customerNameLabel.text = @"客户姓名";
    customerNameLabel.textColor = [UIColor hex:@"#FF373D48"];
    customerNameLabel.font = [UIFont systemFontOfSize:12.0];
    customerNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.topTitleBGView addSubview:customerNameLabel];
    //产品名称
    UILabel *productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(customerNameLabel.frame), CGRectGetMinX(customerNameLabel.frame), 266 * wScale, CGRectGetHeight(customerNameLabel.frame))];
    productNameLabel.text = @"产品名称";
    productNameLabel.textColor = [UIColor hex:@"#FF373D48"];
    productNameLabel.font = [UIFont systemFontOfSize:12.0];
    productNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.topTitleBGView addSubview:productNameLabel];
    //车辆品牌
    UILabel *ppNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(productNameLabel.frame), CGRectGetMinX(customerNameLabel.frame), 146 * wScale, CGRectGetHeight(customerNameLabel.frame))];
    ppNameLabel.text = @"车辆品牌";
    ppNameLabel.textColor = [UIColor hex:@"#FF373D48"];
    ppNameLabel.font = [UIFont systemFontOfSize:12.0];
    ppNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.topTitleBGView addSubview:ppNameLabel];
    //车辆型号
    UILabel *carModelLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(ppNameLabel.frame), CGRectGetMinX(customerNameLabel.frame), 228 * wScale, CGRectGetHeight(customerNameLabel.frame))];
    carModelLabel.text = @"车辆型号";
    carModelLabel.textColor = [UIColor hex:@"#FF373D48"];
    carModelLabel.font = [UIFont systemFontOfSize:12.0];
    carModelLabel.textAlignment = NSTextAlignmentLeft;
    [self.topTitleBGView addSubview:carModelLabel];
    //融资期限(月)
    UILabel *rzqxLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(carModelLabel.frame), CGRectGetMinX(customerNameLabel.frame), 147 * wScale, CGRectGetHeight(customerNameLabel.frame))];
    rzqxLabel.text = @"期限(月)";
    rzqxLabel.textColor = [UIColor hex:@"#FF373D48"];
    rzqxLabel.font = [UIFont systemFontOfSize:12.0];
    rzqxLabel.textAlignment = NSTextAlignmentLeft;
    [self.topTitleBGView addSubview:rzqxLabel];
    //日期
    UILabel *creatDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(rzqxLabel.frame), CGRectGetMinX(customerNameLabel.frame), 189 * wScale, CGRectGetHeight(customerNameLabel.frame))];
    creatDataLabel.text = @"日期";
    creatDataLabel.textColor = [UIColor hex:@"#FF373D48"];
    creatDataLabel.font = [UIFont systemFontOfSize:12.0];
    creatDataLabel.textAlignment = NSTextAlignmentLeft;
    [self.topTitleBGView addSubview:creatDataLabel];
    //状态
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(creatDataLabel.frame), CGRectGetMinX(customerNameLabel.frame), 169 * wScale, CGRectGetHeight(customerNameLabel.frame))];
    stateLabel.text = @"状态";
    stateLabel.textColor = [UIColor hex:@"#FF373D48"];
    stateLabel.font = [UIFont systemFontOfSize:12.0];
    stateLabel.textAlignment = NSTextAlignmentLeft;
    [self.topTitleBGView addSubview:stateLabel];
    
}

#pragma mark 响应事件
//待办响应
- (void)agencyTitleButtonAction:(UIButton *)sender
{
    [self setAgencyTitleLabelWithTextColer:@"#FF333333"];
    [self setHaveDoneTitleLabelWithTextColer:@"#FF9D9D9D"];
    self.bottomLineView.frame = CGRectMake(20 * wScale, CGRectGetMaxY(self.agencyTitleLabel.frame) + 25 * hScale, 218 * wScale, 4 * hScale);
    self.isAgency = YES;
    self.agencyListTableView.modelArr = _waitTaskModelArr;
}

//已办响应
- (void)haveDoneTitleButtonAction:(UIButton *)sender
{
    [self setAgencyTitleLabelWithTextColer:@"#FF9D9D9D"];
    [self setHaveDoneTitleLabelWithTextColer:@"#FF333333"];
    self.bottomLineView.frame = CGRectMake(258 * wScale, CGRectGetMaxY(self.agencyTitleLabel.frame) + 25 * hScale, 218 * wScale, 4 * hScale);
    self.isAgency = NO;
    self.agencyListTableView.modelArr = _workCompleteTaskModelArr;
}
//更多
- (void)moerButtonAction:(UIButton *)sender
{
    
}
#pragma mark 代理
- (void)clickButtonWithWorkBenchModel:(LLFWorkBenchModel *)workBenchModel
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickButtonWithWorkBenchModel:)]) {
        [_delegate clickButtonWithWorkBenchModel:workBenchModel];
    }
}
#pragma mark 私有方法
- (void)setWaitTaskModelArr:(NSMutableArray *)waitTaskModelArr
{
    _waitTaskModelArr = waitTaskModelArr;
    if (self.isAgency) {
        [self setAgencyTitleLabelWithTextColer:@"#FF333333"];
        [self setHaveDoneTitleLabelWithTextColer:@"#FF9D9D9D"];
        self.bottomLineView.frame = CGRectMake(20 * wScale, CGRectGetMaxY(self.agencyTitleLabel.frame) + 25 * hScale, 218 * wScale, 4 * hScale);
        self.agencyListTableView.modelArr = _waitTaskModelArr;
    }else{
        [self setAgencyTitleLabelWithTextColer:@"#FF9D9D9D"];
        [self setHaveDoneTitleLabelWithTextColer:@"#FF333333"];
        self.bottomLineView.frame = CGRectMake(258 * wScale, CGRectGetMaxY(self.agencyTitleLabel.frame) + 25 * hScale, 218 * wScale, 4 * hScale);
        self.agencyListTableView.modelArr = _workCompleteTaskModelArr;
    }
}
- (void)setWorkCompleteTaskModelArr:(NSMutableArray *)workCompleteTaskModelArr
{
    _workCompleteTaskModelArr = workCompleteTaskModelArr;
    if (self.isAgency) {
        [self setAgencyTitleLabelWithTextColer:@"#FF333333"];
        [self setHaveDoneTitleLabelWithTextColer:@"#FF9D9D9D"];
        self.bottomLineView.frame = CGRectMake(20 * wScale, CGRectGetMaxY(self.agencyTitleLabel.frame) + 25 * hScale, 218 * wScale, 4 * hScale);
        self.agencyListTableView.modelArr = _waitTaskModelArr;
    }else{
        [self setAgencyTitleLabelWithTextColer:@"#FF9D9D9D"];
        [self setHaveDoneTitleLabelWithTextColer:@"#FF333333"];
        self.bottomLineView.frame = CGRectMake(258 * wScale, CGRectGetMaxY(self.agencyTitleLabel.frame) + 25 * hScale, 218 * wScale, 4 * hScale);
        self.agencyListTableView.modelArr = _workCompleteTaskModelArr;
    }
}
#pragma mark 工具方法
//待办标题生成
- (void)setAgencyTitleLabelWithTextColer:(NSString *)textColer
{
    NSInteger waitTaskNum = [self.waitTaskModelArr count];
    if (waitTaskNum > 99) {
        waitTaskNum = 99;
    }
    NSString *waitTitleStr = [NSString stringWithFormat:@"我的待办(%lu)",waitTaskNum];
    self.agencyTitleLabel.attributedText = [Tool makeText:waitTitleStr index:4 firstColor:textColer secondColor:@"#FFFF5956"];
}
//已办标题生成
- (void)setHaveDoneTitleLabelWithTextColer:(NSString *)textColer
{
    NSInteger completeTaskNum = [self.workCompleteTaskModelArr count];
    if (completeTaskNum > 99) {
        completeTaskNum = 99;
    }
    NSString *waitTitleStr = [NSString stringWithFormat:@"我的已办(%lu)",completeTaskNum];
    self.haveDoneTitleLabel.attributedText = [Tool makeText:waitTitleStr index:4 firstColor:textColer secondColor:@"#FFFF5956"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
