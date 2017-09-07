//
//  DIYSegmentView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/3/13.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "DIYSegmentView.h"

@interface DIYSegmentView ()
@property (nonatomic,strong)NSMutableArray *items;
@property (nonatomic,strong)NSMutableArray *itemTitleLabelArr;
@end

@implementation DIYSegmentView
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = [NSMutableArray arrayWithArray:items];
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    //设置圆角及边框颜色
    self.layer.borderWidth = 1 * wScale;
    self.layer.borderColor = [UIColor hex:@"#FF999999"].CGColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8 * wScale;
    
    
    //标题个数
    NSInteger itemCount = self.items.count;
    
    //单个标题宽度
    CGFloat itemWith = self.frame.size.width / itemCount;
    //单个标题高度
    CGFloat itemHeigh = self.frame.size.height;
    
    //中间割线x
    CGFloat midLineX = self.frame.size.width / itemCount;
    
    self.itemTitleLabelArr = [NSMutableArray array];
    //设置标题
    for (NSInteger i = 0; i < itemCount; i++) {
        
        //创建标题
        NSString *titleStr = self.items[i];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(itemWith * i, 0, itemWith, itemHeigh)];
        titleLabel.backgroundColor = [UIColor clearColor];
//        titleLabel.font = [UIFont systemFontOfSize:13.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.attributedText = [self getAttributeStrWithStr:titleStr firstColor:@"#FF999999" secondColor:@"#FFFF5252"];
        titleLabel.userInteractionEnabled = YES;
        [self addSubview:titleLabel];
        [self.itemTitleLabelArr addObject:titleLabel];
        
        //创建点击控件
        UIButton *itemButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        itemButton.frame = titleLabel.bounds;
        itemButton.tag = 500 + i;
        [itemButton addTarget:self action:@selector(itemButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [titleLabel addSubview:itemButton];
        
        if (i != 0) {
            UIView *midlineView = [[UIView alloc]initWithFrame:CGRectMake(midLineX * i, 10 * hScale, 1 * wScale, self.frame.size.height - 20 * hScale)];
            midlineView.backgroundColor = [UIColor hex:@"#FFD9D9D9"];
            [self addSubview:midlineView];
        }
    }
     self.currentIndex = 0;
}
/**
 更新标题
 
 @param items 要更新的标题数组
 */
- (void)updataWithItems:(NSArray *)items
{
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:items];
    for (int i = 0; i < self.itemTitleLabelArr.count; i++) {
        NSString *titleStr = self.items[i];
        UILabel *titleLabel = self.itemTitleLabelArr[i];
        if (i == _currentIndex) {
            titleLabel.backgroundColor = [UIColor hex:@"#FF333333"];
            titleLabel.attributedText = [self getAttributeStrWithStr:titleStr firstColor:@"#FFFFFFFF" secondColor:@"#FFFF5252"];
        }else{
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.attributedText = [self getAttributeStrWithStr:titleStr firstColor:@"#FF999999" secondColor:@"#FFFF5252"];
        }
    }
}
#pragma mark 设置默认选中item
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self clickItemActionWithIndex:_currentIndex];
}
#pragma mark 点击事件
- (void)itemButtonAction:(UIButton *)sender
{
    self.currentIndex = sender.tag - 500;
//    [self clickItemActionWithIndex:sender.tag - 500];
}
- (void)clickItemActionWithIndex:(NSInteger)index
{
    for (int i = 0; i < self.itemTitleLabelArr.count; i++) {
        NSString *titleStr = self.items[i];
        UILabel *titleLabel = self.itemTitleLabelArr[i];
        if (i == index) {
            titleLabel.backgroundColor = [UIColor hex:@"#FF333333"];
            titleLabel.attributedText = [self getAttributeStrWithStr:titleStr firstColor:@"#FFFFFFFF" secondColor:@"#FFFF5252"];
        }else{
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.attributedText = [self getAttributeStrWithStr:titleStr firstColor:@"#FF999999" secondColor:@"#FFFF5252"];
        }
    }
    
    //传递选中的索引值
    if (_delegate && [_delegate respondsToSelector:@selector(passDIYSegmentViewWithIndex:)]) {
        [_delegate passDIYSegmentViewWithIndex:index];
    }
}
#pragma mark 获取富文本
- (NSMutableAttributedString *)getAttributeStrWithStr:(NSString *)string firstColor:(NSString *)firstColor secondColor:(NSString *)secondColor
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor hex:firstColor] range:NSMakeRange(0,4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor hex:secondColor] range:NSMakeRange(4,string.length - 4)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(0, 4)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0] range:NSMakeRange(4, string.length - 4)];
    return str;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
