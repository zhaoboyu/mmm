//
//  LLFProductTypeDIYLineChartView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/5/27.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFProductTypeDIYLineChartView.h"
#import "YDJR-Bridging-Header.h"
//#import "LLFBarChartsManger.h"
//#import "PNChart.h"
//#import "PNChartDelegate.h"
#import "LLFProductTypeDIYLineChartViewModel.h"
@interface LLFProductTypeDIYLineChartView ()<ChartViewDelegate,IChartAxisValueFormatter>
@property (nonatomic,strong)UIView *topBGView;
@property (nonatomic,strong)UILabel *totalOrderLabel;

//@property (nonatomic,strong)CombinedChartView * combineChartView;

@property (nonatomic,strong)LineChartView *lineChartView;
@property (nonatomic,strong)NSArray *colorArray;
@property (nonatomic,strong)NSArray *xTitles;
@end

@implementation LLFProductTypeDIYLineChartView
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
    
    self.topBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 88 * hScale)];
    self.topBGView.backgroundColor = [UIColor hex:@"#FFF9F9FA"];
    self.topBGView.layer.borderWidth = 1 * wScale;
    self.topBGView.layer.borderColor = [UIColor hex:@"#FFD9D9D9"].CGColor;
    [self addSubview:self.topBGView];
    
    self.totalOrderLabel = [[UILabel alloc]initWithFrame:CGRectMake(30 * wScale, 29 * hScale, 400 * wScale, 30 * hScale)];
    self.totalOrderLabel.textColor = [UIColor hex:@"#FF333333"];
    self.totalOrderLabel.font = [UIFont systemFontOfSize:15.0];
    self.totalOrderLabel.text = @"订单";
    [self.topBGView addSubview:self.totalOrderLabel];
    
    [self createCombineBarChartView];
}

- (void)createCombineBarChartView
{
//    self.combineChartView = [[CombinedChartView alloc] init];
//    self.combineChartView.frame = CGRectMake(0, CGRectGetMaxY(self.topBGView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(self.topBGView.frame));
//    self.combineChartView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:self.combineChartView];
//    
//    //我自己的工具类
//    LLFBarChartsManger *chartManger = [[LLFBarChartsManger alloc] init];
//    [chartManger setCombineBarChart:self.combineChartView xValues:@[@"1",@"2",@"3",@"4",@"5"] lineValues:@[@"30",@"10",@"50",@"30",@"60"] bar1Values:@[@"80",@"40",@"60",@"30",@"70"] bar2Values:@[@"60",@"30",@"53",@"20",@"45"] lineTitle:@"line" bar1Title:@"bar1" bar2Title:@"bar2"];
    [self addSubview:self.lineChartView];
    self.lineChartView.frame = CGRectMake(0, CGRectGetMaxY(self.topBGView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(self.topBGView.frame));
//    [self.lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(10, 20, 10, 10));
//    }];
//    [self setData];

    
}
- (void)setData
{
//    NSArray *array = @[@"5", @"7", @"10", @"<null>", @"<null>"];
//    NSArray *array1 = @[@"6", @"8", @"2", @"<null>", @"<null>"];
//    NSMutableArray *valueArray = [NSMutableArray array];
//    [valueArray addObject:array];
//    [valueArray addObject:array1];
    NSMutableArray *valueArray = _productTypeLineViewMode.valueArr;
    NSMutableArray *dataSets = [NSMutableArray array];
    double leftAxisMin = 0;
    double leftAxisMax = 0;
    for (int i = 0; i < valueArray.count; i++) {
        
        NSArray *values = valueArray[i];
        NSMutableArray *yVals = [NSMutableArray array];
//        NSString *legendName = [NSString stringWithFormat:@"第%d个图例", i];
        NSString *legendName = _productTypeLineViewMode.productNames[i];
        for (int i = 0; i < values.count; i++)
        {
            NSString *valStr = [NSString stringWithFormat:@"%@", values[i]];
            NSInteger val = [valStr integerValue];
            leftAxisMax = MAX(val, leftAxisMax);
            leftAxisMin = MIN(val, leftAxisMax);
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:val];
            [yVals addObject:entry];
        }
        
        LineChartDataSet *dataSet = [[LineChartDataSet alloc] initWithValues:yVals label:legendName];
        dataSet.lineWidth = 3.0f;//折线宽度
        dataSet.drawValuesEnabled = YES;//是否在拐点处显示数据
        dataSet.valueColors = @[self.colorArray[i]];//折线拐点处显示数据的颜色
        [dataSet setColor:self.colorArray[i]];//折线颜色
        dataSet.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        dataSet.drawCirclesEnabled = NO;//是否绘制拐点
        dataSet.circleRadius = 3.0f;//拐点半径
        dataSet.axisDependency = AxisDependencyLeft;
        dataSet.drawCircleHoleEnabled = YES;//是否绘制中间的空心
        dataSet.circleHoleRadius = 1.0f;//空心的半径
        dataSet.circleHoleColor = self.colorArray[i];//空心的颜色
        dataSet.highlightEnabled = YES;//选中拐点,是否开启高亮效果(显示十字线)
        dataSet.highlightColor = [UIColor clearColor];
        dataSet.valueFont = [UIFont systemFontOfSize:12];
        [dataSets addObject:dataSet];
    }
    
    double leftDiff = leftAxisMax - leftAxisMin;
    if (leftAxisMax == 0 && leftAxisMin == 0) {
        leftAxisMax = 100.0;
        leftAxisMin = -10.0;
    } else {
        leftAxisMax = (leftAxisMax + leftDiff * 0.2);
        leftAxisMin = (leftAxisMin - leftDiff * 0.1);
    }
    self.lineChartView.rightAxis.enabled = NO;
    self.lineChartView.leftAxis.axisMaximum = leftAxisMax;
    self.lineChartView.leftAxis.axisMinimum = 0;
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    self.lineChartView.data = nil;
//    self.lineChartView.xAxis.axisMinimum = -0.8;
//    self.lineChartView.xAxis.axisMaximum = 5.1;
    ChartXAxis *xAxis = self.lineChartView.xAxis;
    xAxis.granularityEnabled = YES;//设置重复的值不显示
    xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
//    xAxis.gridColor = [UIColor clearColor];
    xAxis.labelTextColor = [UIColor blackColor];//文字颜色
    xAxis.axisLineColor = [UIColor grayColor];
    self.lineChartView.maxVisibleCount = 999;//设置能够显示的数据数量
    
    //因为x标题数组较少，所有就这么写了，标准的方法：
    self.lineChartView.xAxis.axisMinimum = data.xMin - 0.8;
    self.lineChartView.xAxis.axisMaximum = data.xMax + 0.8;
    self.lineChartView.xAxis.valueFormatter = self;
    self.lineChartView.data = data;
    [self.lineChartView animateWithXAxisDuration:0.3f];
}
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    return self.xTitles[(int)value % self.xTitles.count];
}
#pragma mark - getter and setter
- (void)setProductTypeLineViewMode:(LLFProductTypeDIYLineChartViewModel *)productTypeLineViewMode
{
    _productTypeLineViewMode = productTypeLineViewMode;
    _colorArray = productTypeLineViewMode.colorArray;
    _xTitles = productTypeLineViewMode.xTitles;
    [self setData];
}
- (LineChartView *)lineChartView
{
    if (_lineChartView == nil) {
        
        _lineChartView = [[LineChartView alloc] init];
        
    }
    return _lineChartView;
}
//- (NSArray *)colorArray
//{
//    if (_colorArray == nil) { //橘黄色  蓝色 淡绿色 浅紫色 浅红色
//        _colorArray = @[ RGB(242, 152, 80), RGB(92, 178, 240), RGB(158, 202, 97), RGB(219, 95, 153), RGB(233, 84, 83)];
//    }
//    return _colorArray;
//}
//- (NSArray *)xTitles
//{
//    if (_xTitles == nil) {
//        
//        _xTitles = @[@"第1周", @"第2周", @"第3周", @"第4周", @"第5周"];
//    }
//    return _xTitles;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
