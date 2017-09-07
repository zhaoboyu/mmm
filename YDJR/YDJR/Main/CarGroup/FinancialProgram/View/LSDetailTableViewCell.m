//
//  LSDetailTableViewCell.m
//  YDJR
//
//  Created by 李爽 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSDetailTableViewCell.h"

@implementation LSDetailTableViewCell

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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.categoryTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*wScale, 41*hScale, 442*wScale, 30*hScale)];
    self.categoryTitleLabel.font = [UIFont systemFontOfSize:15];
    self.categoryTitleLabel.textColor = [UIColor hexString:@"#FF666666"];
    [self addSubview:self.categoryTitleLabel];
    
    self.fullPaymentLabel = [[UILabel alloc]initWithFrame:CGRectMake(380 * wScale, 41 * hScale, 308 * wScale, 30 *hScale)];
    self.fullPaymentLabel.font = [UIFont systemFontOfSize:15];
    self.fullPaymentLabel.textAlignment = NSTextAlignmentRight;
    //self.fullPaymentLabel.textColor = [UIColor hexString:@"#FF000000"];
    [self addSubview:self.fullPaymentLabel];
    
    self.bankLoanLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.fullPaymentLabel.frame), 41 * hScale, 376 * wScale, 30 * hScale)];
    self.bankLoanLabel.font = [UIFont systemFontOfSize:15];
    self.bankLoanLabel.textAlignment = NSTextAlignmentRight;
    self.bankLoanLabel.textColor = [UIColor hexString:@"#FF000000"];
    [self addSubview:self.bankLoanLabel];
}
@end
