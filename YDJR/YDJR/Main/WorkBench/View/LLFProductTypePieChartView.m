//
//  LLFProductTypePieChartView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/5/27.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFProductTypePieChartView.h"
#import "YDJR-Bridging-Header.h"

//数据Model
#import "LLFPieChartViewDataModel.h"
#import "LLFProductTypePieChartViewModel.h"
@interface LLFProductTypePieChartView ()
@property (nonatomic,strong)UIView *topBGView;
@property (nonatomic,strong)UILabel *totalOrderLabel;
/**
 饼状图
 */
@property (nonatomic,strong)PieChartView *pieChartView;
@end

@implementation LLFProductTypePieChartView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.layer.cornerRadius = 4 * wScale;
    self.layer.borderWidth = 1 * wScale;
    self.layer.borderColor = [UIColor hex:@"#FFD9D9D9"].CGColor;
    
//    self.topBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 88 * hScale)];
//    self.topBGView.backgroundColor = [UIColor hex:@"#FFF9F9FA"];
//    self.topBGView.layer.borderWidth = 1 * wScale;
//    self.topBGView.layer.borderColor = [UIColor hex:@"#FFD9D9D9"].CGColor;
//    [self addSubview:self.topBGView];
//    
//    self.totalOrderLabel = [[UILabel alloc]initWithFrame:CGRectMake(30 * wScale, 29 * hScale, 400 * wScale, 30 * hScale)];
//    self.totalOrderLabel.textColor = [UIColor hex:@"#FF333333"];
//    self.totalOrderLabel.font = [UIFont systemFontOfSize:15.0];
//    self.totalOrderLabel.text = @"订单:100";
//    [self.topBGView addSubview:self.totalOrderLabel];
    
    [self creatPieChartView];
}

- (void)creatPieChartView
{
    self.pieChartView = [[PieChartView alloc] initWithFrame:self.bounds];
    //    self.pieChartView.backgroundColor = [UIColor redColor];
    [self addSubview:self.pieChartView];
    [self.pieChartView setExtraOffsetsWithLeft:0 top:0 right:0 bottom:0];//饼状图距离边缘的间隙
    self.pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
    self.pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
    self.pieChartView.drawSliceTextEnabled = NO;//是否显示区块文本
    
    self.pieChartView.drawHoleEnabled = YES;//饼状图是否是空心
    self.pieChartView.holeRadiusPercent = 0.6;//空心半径占比
    self.pieChartView.holeColor = [UIColor clearColor];//空心颜色
    self.pieChartView.transparentCircleRadiusPercent = 0.6;//半透明空心半径占比
    self.pieChartView.transparentCircleColor = [UIColor whiteColor];//半透明空心的颜色
    
    self.pieChartView.descriptionText = @"移动展业不同产品种类订单数详情";
    self.pieChartView.descriptionFont = [UIFont systemFontOfSize:10];
    self.pieChartView.descriptionTextColor = [UIColor grayColor];
    
    self.pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    self.pieChartView.legend.yEntrySpace = 10;//文本行间隔
    self.pieChartView.legend.formToTextSpace = 5;//文本间隔
    self.pieChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
    self.pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
    self.pieChartView.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
    self.pieChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
    self.pieChartView.legend.formSize = 12;//图示大小
}

- (void)setPieChartViewData
{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    //每个区块的数据
    for (int i = 0; i < self.pieChartViewDataModelArr.count; i++)
    {
        LLFPieChartViewDataModel *model = [self.pieChartViewDataModelArr objectAtIndex:i];
        [values addObject:[[PieChartDataEntry alloc] initWithValue:model.pieValue label:model.pieText icon: [UIImage imageNamed:@"icon"]]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@""];
    
    dataSet.drawIconsEnabled = YES;//是否绘制显示数据
    //
    dataSet.sliceSpace = 2.0;//区块之间的间隔
    //    dataSet.iconsOffset = CGPointMake(0, 50);
    
    // add a lot of colors
    
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
    [colors addObjectsFromArray:ChartColorTemplates.joyful];
    [colors addObjectsFromArray:ChartColorTemplates.colorful];
    [colors addObjectsFromArray:ChartColorTemplates.liberty];
    [colors addObjectsFromArray:ChartColorTemplates.pastel];
    [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
    
    dataSet.colors = colors;//区块颜色
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 0;//小数位数
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];//设置数据显示格式
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    self.pieChartView.data = data;
    [self.pieChartView highlightValues:nil];
}
#pragma mark 私有方法
- (void)setPieChartViewDataModelArr:(NSArray *)pieChartViewDataModelArr
{
    _pieChartViewDataModelArr = pieChartViewDataModelArr;
    [self setPieChartViewData];
}
- (void)setProductTypePieChartViewModel:(LLFProductTypePieChartViewModel *)productTypePieChartViewModel
{
    _productTypePieChartViewModel = productTypePieChartViewModel;
    _pieChartViewDataModelArr = productTypePieChartViewModel.pieChartViewDataModelArr;
    [self setPieChartViewData];
    [self setcentText:productTypePieChartViewModel.centText total:productTypePieChartViewModel.total];
}
- (void)setcentText:(NSString *)centText total:(NSInteger)total
{
    NSString *string = [NSString stringWithFormat:@"%@"
                        @"\n"
                        @"%ld",centText,total];
    //NSAttributedString
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:string];
    UIFont *baseFont = [UIFont systemFontOfSize:12.0];
    [attrString addAttribute:NSFontAttributeName value:baseFont range:[string rangeOfString:centText]];
    //颜色
    UIColor *color = [UIColor hex:@"#FF9D9D9D"];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:[string rangeOfString:centText]];
    
    UIFont *baseFont1 = [UIFont systemFontOfSize:30.0];
    [attrString addAttribute:NSFontAttributeName value:baseFont1 range:[string rangeOfString:[NSString stringWithFormat:@"%ld",total]]];
    //颜色
    UIColor *color1 = [UIColor hex:@"#FF333333"];
    [attrString addAttribute:NSForegroundColorAttributeName value:color1 range:[string rangeOfString:[NSString stringWithFormat:@"%ld",total]]];
    //段落对齐，间距，换行
    NSMutableParagraphStyle *
    style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:[string rangeOfString:centText]];
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:style
                       range:[string rangeOfString:[NSString stringWithFormat:@"%ld",total]]];
    if (self.pieChartView.isDrawHoleEnabled == YES) {
        self.pieChartView.drawCenterTextEnabled = YES;//是否显示中间文字
        //普通文本
        // self.pieChartView.centerText = @"饼状图";//中间文字
        //富文本
        self.pieChartView.centerAttributedText = attrString;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
