//
//  WPQButtonBox.m
//  YDJR
//
//  Created by wanpeiqiang on 2016/12/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "WPQButtonBox.h"

@implementation WPQButtonBox


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.frame=CGRectMake(frame.origin.x, frame.origin.y, 100*wScale, 96*hScale);
//        self.backgroundColor=[UIColor blueColor];
        self.button=[UIButton buttonWithType:UIButtonTypeCustom];
//        self.button.backgroundColor=[UIColor blueColor];
//        [self.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        self.button.frame=CGRectMake(20*wScale,0,56*wScale,56*hScale);
        self.button.frame=self.bounds;
        [self addSubview:self.button];
        
        self.imageView=[[UIImageView alloc] initWithFrame:CGRectMake(32*wScale,0,56*wScale,56*hScale)];
        
        [self addSubview:self.imageView];
        
        self.titleLable=[[UILabel alloc] initWithFrame:CGRectMake(0, 10 * hScale + CGRectGetMaxY(self.imageView.frame), 120*wScale, 26*hScale)];
        self.titleLable.textAlignment=NSTextAlignmentCenter;
        self.titleLable.font=[UIFont systemFontOfSize:13.0];
        self.titleLable.highlightedTextColor=[UIColor hex:@"#000000"];
        self.titleLable.textColor=[UIColor hex:@"#999999"];
//        self.titleLable.backgroundColor=[UIColor redColor];
        [self addSubview:self.titleLable];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
