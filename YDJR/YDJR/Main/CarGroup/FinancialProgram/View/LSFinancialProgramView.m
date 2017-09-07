//
//  LSFinancialProgramView.m
//  YDJR
//
//  Created by 李爽 on 16/9/28.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSFinancialProgramView.h"
#import "LSTextField.h"

@interface LSFinancialProgramView ()<UITextFieldDelegate>

@end
@implementation LSFinancialProgramView

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
	self.suggestedRetailPriceTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 32*hScale, 168*wScale, 24*hScale)];
	self.suggestedRetailPriceTitleLabel.text = @"建议零售价(元)";
	self.suggestedRetailPriceTitleLabel.font = [UIFont systemFontOfSize:12];
	self.suggestedRetailPriceTitleLabel.textColor = [UIColor hexString:@"#666666"];
	[self addSubview:self.suggestedRetailPriceTitleLabel];
	
	self.suggestedRetailPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, CGRectGetMaxY(self.suggestedRetailPriceTitleLabel.frame) + 24*hScale, 348*wScale, 40*hScale)];
	self.suggestedRetailPriceLabel.font = [UIFont systemFontOfSize:20];
	self.suggestedRetailPriceLabel.textColor = [UIColor hexString:@"#FC5A5A"];
	[self addSubview:self.suggestedRetailPriceLabel];
	
	self.firstCuttingLine = [[UIView alloc]initWithFrame:CGRectMake(380*wScale, 48*hScale, wScale, 64*hScale)];
	self.firstCuttingLine.backgroundColor = [UIColor hexString:@"#E6E6E6"];
	[self addSubview:self.firstCuttingLine];
	
	self.realPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.firstCuttingLine.frame) + 64*wScale, 32*hScale, 100*wScale, 24*hScale)];
	self.realPriceLabel.text = @"实际价格";
	self.realPriceLabel.font = [UIFont systemFontOfSize:12];
	self.realPriceLabel.textColor = [UIColor hexString:@"#666666"];
	[self addSubview:self.realPriceLabel];
	
	self.realPriceInputTextField = [[LSTextField alloc]initWithFrame:CGRectMake(self.realPriceLabel.frame.origin.x, CGRectGetMaxY(self.realPriceLabel.frame) + 12*hScale, 420*wScale, 64*hScale)];
	self.realPriceInputTextField.placeholder = @"请输入";
	self.realPriceInputTextField.keyboardType = UIKeyboardTypeNumberPad;
	self.realPriceInputTextField.font = [UIFont systemFontOfSize:14];
	self.realPriceInputTextField.backgroundColor = [UIColor hexString:@"#FFF2F3F7"];
	self.realPriceInputTextField.delegate = self;
	self.realPriceInputTextField.tag = 111;
	[self addSubview:self.realPriceInputTextField];
	
	//self.secondCuttingLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.realPriceInputTextField.frame) + 64*wScale, 48*hScale, wScale, 64*hScale)];
	//self.secondCuttingLine.backgroundColor = [UIColor hexString:@"#E6E6E6"];
	//[self addSubview:self.secondCuttingLine];
	
	//self.insuranceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.secondCuttingLine.frame) + 64*wScale, 32*hScale, 100*wScale, 24*hScale)];
	//self.insuranceLabel.text = @"保险";
	//self.insuranceLabel.font = [UIFont systemFontOfSize:12];
	//self.insuranceLabel.textColor = [UIColor hexString:@"#666666"];
	//[self addSubview:self.insuranceLabel];
	//
	//self.insuranceInputTextField = [[LSTextField alloc]initWithFrame:CGRectMake(self.insuranceLabel.frame.origin.x, CGRectGetMaxY(self.insuranceLabel.frame) + 12*hScale, 420*wScale, 64*hScale)];
	//self.insuranceInputTextField.placeholder = @"请输入";
	//self.insuranceInputTextField.keyboardType = UIKeyboardTypeNumberPad;
	//self.insuranceInputTextField.font = [UIFont systemFontOfSize:14];
	//self.insuranceInputTextField.backgroundColor = [UIColor hexString:@"#FFF2F3F7"];
	//self.insuranceInputTextField.delegate = self;
	//self.insuranceInputTextField.tag = 112;
	//[self addSubview:self.insuranceInputTextField];
	//
	//self.checkBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.insuranceInputTextField.frame) + 12*wScale, CGRectGetMaxY(self.insuranceLabel.frame) + 12*hScale, 64*wScale, 64*hScale)];
	//[self.checkBtn setImage:[UIImage imageNamed:@"icon_normal_xuanze-1"] forState:UIControlStateNormal];
	//[self.checkBtn setImage:[UIImage imageNamed:@"icon_pressed_xuanze"] forState:UIControlStateSelected];
	//[self.checkBtn addTarget:self action:@selector(desectCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
	//[self addSubview:self.checkBtn];
	
	//底部分割线
	UIView *cuttingLine = [[UIView alloc]initWithFrame:CGRectMake(0, 159*hScale, kWidth, hScale)];
	cuttingLine.backgroundColor = [UIColor hexString:@"#F0D9D9D9"];
	[self addSubview:cuttingLine];
}

#pragma mark - 勾选购置税
-(void)desectCheckBtn:(UIButton*)sender{
	sender.selected = !sender.selected;
}

@end
