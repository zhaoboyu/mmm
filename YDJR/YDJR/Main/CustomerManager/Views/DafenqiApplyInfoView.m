//
//  DafenqiApplyInfoView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/4/5.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "DafenqiApplyInfoView.h"
#import "LSBankCardInfoTableViewCell.h"
#import "CTTXRequestServer+FileUpload.h"
#define  CELLID @"CELLID"
@interface DafenqiApplyInfoView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *contentAry;
@property (nonatomic,strong)HGBPromgressHud *phud;
@property (nonatomic,strong)UIButton *cancleButton;
@end

@implementation DafenqiApplyInfoView
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
	self.backgroundColor = [UIColor hex:@"#FFF2F3F7"];
	
	//顶部栏
	UIView *topBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 96 * hScale)];
	topBgView.backgroundColor = [UIColor hex:@"#ffffff"];
	[self addSubview:topBgView];
	
	//返回按钮
	UIImageView *iconBackImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_back"]];
	iconBackImageView.frame = CGRectMake(32 * wScale, 36 * hScale, 25 * wScale, 25 * hScale);
	iconBackImageView.userInteractionEnabled = YES;
	[topBgView addSubview:iconBackImageView];
	
	UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconBackImageView.frame), 32 * hScale, 70 * wScale, 32 * hScale)];
	backLabel.text = @"返回";
	backLabel.textColor = [UIColor hex:@"#FF274A72"];
	backLabel.font = [UIFont systemFontOfSize:16.0];
	backLabel.textAlignment = NSTextAlignmentLeft;
	[topBgView addSubview:backLabel];
	
	UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
	backButton.frame = CGRectMake(0, 0, CGRectGetMaxX(backLabel.frame), CGRectGetHeight(topBgView.frame));
	[backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	[topBgView addSubview:backButton];
	
	UILabel *topTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(topBgView.frame) - 200 * wScale) / 2, 0, 200 * wScale, CGRectGetHeight(topBgView.frame))];
	topTitleLabel.text = @"达分期";
	topTitleLabel.textColor = [UIColor hex:@"#FF333333"];
	topTitleLabel.font = [UIFont systemFontOfSize:18.0];
	topTitleLabel.textAlignment = NSTextAlignmentCenter;
	[topBgView addSubview:topTitleLabel];
	
    self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancleButton.frame = CGRectMake(CGRectGetWidth(topBgView.frame) - CGRectGetWidth(backButton.frame) - 15, 0, CGRectGetWidth(backButton.frame) + 15, CGRectGetHeight(topBgView.frame));
    [self.cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleButton setTitle:@"取消申请" forState:(UIControlStateNormal)];
    [self.cancleButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [self.cancleButton setTitleColor:[UIColor hex:@"#FF999999"] forState:(UIControlStateDisabled)];
    self.cancleButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    
    [topBgView addSubview:self.cancleButton];
	/*
	 *********************内容与顶部栏分割线***********************************
	 */
	UIView *oneLineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topBgView.frame), CGRectGetWidth(topBgView.frame), 1 * hScale)];
	oneLineView.backgroundColor = [UIColor hex:@"#FFDDDDDD"];
	[self addSubview:oneLineView];
	
	/*
	 *********************内容UIScrollView***********************************
	 */
	UIScrollView *BGScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(oneLineView.frame), CGRectGetWidth(self.frame), self.frame.size.height - CGRectGetMaxY(oneLineView.frame))];
	BGScrollview.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
	BGScrollview.contentSize = CGSizeMake(self.frame.size.width, 1971 * hScale);
	BGScrollview.contentOffset = CGPointMake(0, 0);
	[self addSubview:BGScrollview];
	/*
	 *********************银行卡信息***********************************
	 */
	self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(oneLineView.frame), CGRectGetWidth(self.frame), self.frame.size.height - CGRectGetMaxY(oneLineView.frame))];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[self.tableView registerClass:[LSBankCardInfoTableViewCell class] forCellReuseIdentifier:CELLID];
	[self addSubview:self.tableView];
}
#pragma mark 点击按钮响应事件
//返回响应事件
- (void)backButtonAction:(UIButton *)sender
{
	CGRect frame = self.frame;
	frame.origin.x = frame.size.width;
	[UIView animateWithDuration:0.2 animations:^{
		self.frame = frame;
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
        if (self.back) {
           self.back();
        }
	}];
}
#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LSBankCardInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
	cell.L_TitleLable.text = [self bigTitleArr][indexPath.row];
	cell.daFenQiApplyInfoTitleArr = [self daFenQiApplyInfoTitleArr][indexPath.row];
	cell.daFenQiApplyInfContentArr = [self daFenQiApplyInfContentArr][indexPath.row];
	
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		return 240 * hScale;
	}else if (indexPath.row == 1){
		return 298 * hScale;
	}else if (indexPath.row == 2){
		return 240 * hScale;
	}else if (indexPath.row == 3){
		return [self jisuanHight];
	}else{
		return 240 * hScale;
	}
}

- (NSArray *)bigTitleArr
{
	return [NSArray arrayWithObjects:@"银行卡信息",@"授信信息",@"车辆信息",@"保险信息",@"合同信息", nil];
}

- (NSArray *)daFenQiApplyInfoTitleArr
{
    NSMutableArray *tempArr = [NSMutableArray array];
    //银行卡信息
    NSMutableArray *yinhangkaArr = [NSMutableArray array];
    [yinhangkaArr addObject:@"开户名称："];
    [yinhangkaArr addObject:@"开户银行："];
    [yinhangkaArr addObject:@"银行卡卡号："];
    [yinhangkaArr addObject:@"开户人身份证号："];
    [tempArr addObject:yinhangkaArr];
    //授信信息
    NSMutableArray *shouxinArr = [NSMutableArray array];
    [shouxinArr addObject:@"融资金额(元)："];
    [shouxinArr addObject:@"保险融资期限(月)："];
    [shouxinArr addObject:@"是否按揭："];
    [shouxinArr addObject:@"按揭机构："];
    [shouxinArr addObject:@"车辆按揭期限(月)："];
    [tempArr addObject:shouxinArr];
    //车辆信息
    NSMutableArray *carInfoArr = [NSMutableArray array];
    [carInfoArr addObject:@"车辆品牌："];
    [carInfoArr addObject:@"车辆型号："];
    [carInfoArr addObject:@"排量(L)："];
    [carInfoArr addObject:@"使用性质："];
    [tempArr addObject:carInfoArr];
    //保险信息
    NSMutableArray *baoxinArr = [NSMutableArray array];
    [baoxinArr addObject:@"被保险人："];
    [baoxinArr addObject:@"保险公司名称："];
    [baoxinArr addObject:@"保险期限(年)："];
    [baoxinArr addObject:@"预估保险费："];
    [baoxinArr addObject:@"车船税(代收-元)："];
    [baoxinArr addObject:@"投保城市："];
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carLossInsFlag]) {
        [baoxinArr addObject:@"机动车损失险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.thirdDutyFlag]) {
        [baoxinArr addObject:@"机动车第三者责任保险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carRobberyFlag]) {
        [baoxinArr addObject:@"机动车全车盗抢保险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.glassBreakFlag]) {
        [baoxinArr addObject:@"玻璃单独破碎险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carPersonSum]) {
        [baoxinArr addObject:@"机动车车上人员责任保险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carBodyLossSum]) {
        //车身划痕损失险
        [baoxinArr addObject:@"车身划痕损失险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.selfIgniteFlag]) {
        //自燃损失险
        [baoxinArr addObject:@"自燃损失险："];

    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.nofreerFlag]) {
        [baoxinArr addObject:@"不计免赔率险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.addEquipmentLoss]) {
        [baoxinArr addObject:@"新增设备损失险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.engineWadingLoss]) {
        [baoxinArr addObject:@"发动机涉水损失险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.canNotFindThirdPartySpecial]) {
        [baoxinArr addObject:@"机动车损失保险无法找到第三方特约险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.costCompenSation]) {
        [baoxinArr addObject:@"修理期间费用补偿险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carGoresPonsibility]) {
        [baoxinArr addObject:@"车上货物责任险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.mentalinjury]) {
        [baoxinArr addObject:@"精神损害抚慰金责任险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.designatedRepairShop]) {
        [baoxinArr addObject:@"指定修理厂险："];
    }
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.eforceInsurance]) {
        [baoxinArr addObject:@"交强险："];
    }
    
    [tempArr addObject:baoxinArr];
    //合同信息
    NSMutableArray *hetongArr = [NSMutableArray array];
    [hetongArr addObject:@"订单号："];
    [hetongArr addObject:@"借款合同编号："];
    [hetongArr addObject:@"委托投保合同编号："];
    [tempArr addObject:hetongArr];
	return tempArr;
}

- (NSArray *)daFenQiApplyInfContentArr
{
    NSMutableArray *tempArr = [NSMutableArray array];
    //银行卡信息
    NSMutableArray *yinhangkaArr = [NSMutableArray array];
    //开户名称
    [yinhangkaArr addObject:self.dafenqiBusinessModel.accountInfo.accountName];
    //开户银行
    [yinhangkaArr addObject:self.dafenqiBusinessModel.accountInfo.accountOrgID];
    //银行卡卡号
    [yinhangkaArr addObject:self.dafenqiBusinessModel.accountInfo.accountNo];
    //开户人身份证号
    [yinhangkaArr addObject:self.dafenqiBusinessModel.accountInfo.accountCertID];
    [tempArr addObject:yinhangkaArr];
    //授信信息
    NSMutableArray *shouxinArr = [NSMutableArray array];
    //融资金额
    [shouxinArr addObject:self.dafenqiBusinessModel.creditInfo.businessSum];
    //融资期限
    [shouxinArr addObject:self.dafenqiBusinessModel.creditInfo.businessTerm];
    //是否按揭
    [shouxinArr addObject:self.dafenqiBusinessModel.creditInfo.isMortgaged];
    //按揭机构
    [shouxinArr addObject:self.dafenqiBusinessModel.creditInfo.mortgagedOrg];
    //按揭期限
    [shouxinArr addObject:self.dafenqiBusinessModel.creditInfo.mortgagedTerm];
    [tempArr addObject:shouxinArr];
    //车辆信息
    NSMutableArray *carInfoArr = [NSMutableArray array];
    //车辆品牌
    [carInfoArr addObject:self.dafenqiBusinessModel.carInfo.carBrand];
    //车辆型号
    [carInfoArr addObject:self.dafenqiBusinessModel.carInfo.carModel];
    //排量
    [carInfoArr addObject:self.dafenqiBusinessModel.carInfo.displacement];
    //使用性质
    [carInfoArr addObject:self.dafenqiBusinessModel.carInfo.useProperty];
    [tempArr addObject:carInfoArr];
    //保险信息
    NSMutableArray *baoxinArr = [NSMutableArray array];
    //被保险人
    [baoxinArr addObject:self.dafenqiBusinessModel.insuranceInfo.insureObject];
    //保险公司名称
    [baoxinArr addObject:self.dafenqiBusinessModel.insuranceInfo.insuranceOrg];
    //保险期限
    [baoxinArr addObject:self.dafenqiBusinessModel.insuranceInfo.uptoTerm];
    //预估保费
    [baoxinArr addObject:self.dafenqiBusinessModel.insuranceInfo.preInsuranceSum];
    //应付车船税
    [baoxinArr addObject:self.dafenqiBusinessModel.insuranceInfo.payAblevavtAmount];
    //投保城市
    [baoxinArr addObject:self.dafenqiBusinessModel.insuranceInfo.insureCity];
    //机动车损失险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carLossInsFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carLossInsFlag]];
    }
    
    //机动车第三者责任保险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.thirdDutyFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.thirdDutyFlag]];
    }
    
    //机动车全车盗抢保险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carRobberyFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carRobberyFlag]];
    }
    //玻璃单独破碎险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.glassBreakFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.glassBreakFlag]];
    }
    
    //机动车车上人员责任保险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carPersonSum]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carPersonSum]];
    }
    
    //车身划痕损失险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carBodyLossSum]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carBodyLossSum]];
    }
    
    //自燃损失险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.selfIgniteFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.selfIgniteFlag]];
    }
    
    //不计免赔率险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.nofreerFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.nofreerFlag]];
    }
    
    //新增设备损失险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.addEquipmentLoss]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.addEquipmentLoss]];
    }
    
    //发动机涉水损失险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.engineWadingLoss]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.engineWadingLoss]];
    }
    
    //机动车损失保险无法找到第三方特约险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.canNotFindThirdPartySpecial]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.canNotFindThirdPartySpecial]];
    }
    
    //修理期间费用补偿险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.costCompenSation]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.costCompenSation]];
    }
    
    //车上货物责任险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carGoresPonsibility]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carGoresPonsibility]];
    }
    
    //精神损害抚慰金责任险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.mentalinjury]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.mentalinjury]];
    }
    
    //指定修理厂险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.designatedRepairShop]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.designatedRepairShop]];
    }
    
    //交强险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.eforceInsurance]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.eforceInsurance]];
    }
    
    [tempArr addObject:baoxinArr];
    //合同信息
    NSMutableArray *hetongArr = [NSMutableArray array];
    //订单号
    [hetongArr addObject:self.dafenqiBusinessModel.businessID];
    //借款合同编号
    [hetongArr addObject:self.dafenqiBusinessModel.loanContractNo];
    //委托投保合同编号
    [hetongArr addObject:self.dafenqiBusinessModel.insuranceContractNo];
    [tempArr addObject:hetongArr];
    return tempArr;
}
- (void)setDafenqiBusinessModel:(LLFDafenqiBusinessModel *)dafenqiBusinessModel
{
    _dafenqiBusinessModel = dafenqiBusinessModel;
    if ([self.dafenqiBusinessModel isCanCancleApply]) {
        self.cancleButton.enabled = YES;
    }else{
        self.cancleButton.enabled = NO;
    }
    [self.tableView reloadData];
}
/**
 取消申请

 @param sender UIButton
 */
- (void)cancleButtonAction:(UIButton *)sender
{
    [self.phud showHUDSaveAddedTo:self];
    [[CTTXRequestServer shareInstance]upDFQStateWithBusinessID:self.dafenqiBusinessModel.businessID operaTionType:@"17" productType:@"dfq"  WithSuccessBlock:^(NSString *ReturnCode, NSString *ReturnMessage) {
        [self.phud hideSave];
        if ([ReturnCode isEqualToString:@"0"]) {
            [self.phud hideSave];
            self.phud.promptStr = @"取消申请成功!";
            [self.phud showHUDResultAddedTo:self];
//            [self backButtonAction:nil];
        }else{
            [self.phud hideSave];
            self.phud.promptStr = ReturnMessage;
            [self.phud showHUDResultAddedTo:self];
        }
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        self.phud.promptStr = @"取消申请失败,请稍后重试!";
        [self.phud showHUDResultAddedTo:self];
    }];
}
//判断有无险种
- (BOOL)isShowInsuranceTypeWIthInsuranceInfo:(NSString *)insuranceInfo
{
    if (insuranceInfo.length > 0) {
        NSString *isShow = [insuranceInfo substringToIndex:1];
        if ([isShow isEqualToString:@"是"]) {
            return YES;
        }else{
            return NO;
        }
        
    }else{
        return NO;
    }
}
- (NSString *)getInsuranceInfoWithinsuranceInfo:(NSString *)insuranceInfo
{
    if (insuranceInfo.length == 1) {
        return insuranceInfo;
    }else{
        NSString *temp = [insuranceInfo substringFromIndex:2];
        return [temp stringByReplacingOccurrencesOfString:@"#" withString:@"-"];
    }
    
}
- (CGFloat)jisuanHight
{
    //保险信息
    NSMutableArray *baoxinArr = [NSMutableArray array];
    //机动车损失险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carLossInsFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carLossInsFlag]];
    }
    
    //机动车第三者责任保险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.thirdDutyFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.thirdDutyFlag]];
    }
    
    //机动车全车盗抢保险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carRobberyFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carRobberyFlag]];
    }
    //玻璃单独破碎险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.glassBreakFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.glassBreakFlag]];
    }
    
    //机动车车上人员责任保险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carPersonSum]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carPersonSum]];
    }
    
    //车身划痕损失险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carBodyLossSum]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carBodyLossSum]];
    }
    
    //自燃损失险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.selfIgniteFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.selfIgniteFlag]];
    }
    
    //不计免赔率险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.nofreerFlag]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.nofreerFlag]];
    }
    
    //新增设备损失险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.addEquipmentLoss]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.addEquipmentLoss]];
    }
    
    //发动机涉水损失险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.engineWadingLoss]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.engineWadingLoss]];
    }
    
    //机动车损失保险无法找到第三方特约险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.canNotFindThirdPartySpecial]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.canNotFindThirdPartySpecial]];
    }
    
    //修理期间费用补偿险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.costCompenSation]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.costCompenSation]];
    }
    
    //车上货物责任险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carGoresPonsibility]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.carGoresPonsibility]];
    }
    
    //精神损害抚慰金责任险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.mentalinjury]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.mentalinjury]];
    }
    
    //指定修理厂险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.designatedRepairShop]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.designatedRepairShop]];
    }
    
    //交强险
    if ([self isShowInsuranceTypeWIthInsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.eforceInsurance]) {
        [baoxinArr addObject:[self getInsuranceInfoWithinsuranceInfo:self.dafenqiBusinessModel.insuranceTypeInfo.eforceInsurance]];
    }
    NSInteger num = [baoxinArr count];
    NSInteger yuNum = num % 2;
    NSInteger cellHNum;
    if (yuNum == 0) {
        cellHNum = num / 2;
    }else{
        cellHNum = num / 2 + 1;
    }
    CGFloat cellH = 58 * hScale * cellHNum + 300 * hScale;
    return cellH;
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}
@end
