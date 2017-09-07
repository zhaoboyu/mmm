//
//  SDC_CMSearchBar.m
//  YDJR
//
//  Created by sundacheng on 16/9/29.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "SDC_CMSearchBar.h"

#define SearchBarH 28
#define SearchBarW 210
#define CornerRadius 6

@implementation SDC_CMSearchBar

//布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
    UITextField *searchField = (UITextField *)[self valueForKey:@"_searchField"];
    searchField.textColor = [UIColor whiteColor];
    
    searchField.layer.borderWidth = 0.5;
    searchField.layer.borderColor = [UIColor hex:@"#D8D8D8"].CGColor;
    searchField.height = SearchBarH;
    searchField.width = SearchBarW;
    searchField.layer.masksToBounds = YES;
    searchField.layer.cornerRadius = CornerRadius;
    searchField.placeholder = @"搜索";
    searchField.backgroundColor = [UIColor hex:@"#373D48"];
    
    UIImage *img = [UIImage imageWithColor:[UIColor hex:@"#373D48"]];
    [self setBackgroundImage:img];
    
    UIImage *image = [UIImage imageNamed:@"ic_search"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:image];
    iconView.frame = CGRectMake(0, 0, image.size.width , image.size.height);
    searchField.leftView = iconView;
}

@end
