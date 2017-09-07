//
//  LSTextField.m
//  YDJR
//
//  Created by 李爽 on 2016/10/16.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSTextField.h"

@implementation LSTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 16*wScale, 0)];
		self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.leftViewWidth, 0)];
        //设置显示模式为永远显示(默认不显示)
        self.leftViewMode = UITextFieldViewModeAlways;
        self.layer.masksToBounds  = YES;
        self.layer.cornerRadius = 2.0f;
    }
    return self;
}


- (void)drawPlaceholderInRect:(CGRect)rect{
    UIColor *placeholderColor = [UIColor hexString:@"#FFABADB3"];//设置颜色
    [placeholderColor setFill];
    
    CGRect placeholderRect = CGRectMake(0, (rect.size.height- self.font.pointSize)/2, rect.size.width, self.height);//设置距离
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = self.textAlignment;
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, self.font, NSFontAttributeName, placeholderColor, NSForegroundColorAttributeName, nil];
    
    [self.placeholder drawInRect:placeholderRect withAttributes:attr];
}

@end
