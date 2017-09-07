//
//  LLFRunloopView.m
//  YDJR
//
//  Created by 吕利峰 on 2016/12/19.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFRunloopView.h"
#import "LoadingView.h"
@interface LLFRunloopView ()<UIScrollViewDelegate>
{
    NSInteger _currentIndex;
}
@property (nonatomic,strong)NSTimer *time;

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *page;
@property (nonatomic,strong)NSMutableArray *lodingAnmationArr;
@end
@implementation LLFRunloopView

- (void)dealloc{
    [self.time invalidate];
    self.time = nil;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
//        self.time = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    }
    return self;
}
#pragma mark 布局
- (void)p_setupView
{
    self.backgroundColor = [UIColor whiteColor];
    _currentIndex = 0;
    self.lodingAnmationArr = [NSMutableArray array];
    
    //创建scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = [UIColor hex:@"#FFF5F5F5"];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    [self addSubview:self.scrollView];
    //创建pageControl
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame) - 50, CGRectGetWidth(self.frame), 50)];
    // 设置内部的原点图片
    [self.page setValue:[UIImage imageNamed:@"LLF_SelectNewCarType_icon_dim_oval"] forKeyPath:@"pageImage"];
    [self.page setValue:[UIImage imageNamed:@"LLF_SelectNewCarType_icon_active_oval"] forKeyPath:@"currentPageImage"];
    self.page.hidesForSinglePage = YES;
    [self addSubview:_page];
    //监听被点击事件
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
//    [self addGestureRecognizer:tap];
}

- (void)clickView:(UITapGestureRecognizer *)gesture{
    if (_delegate && [_delegate respondsToSelector:@selector(clickRunloopViewWithIndex:)]) {
        [self.delegate clickRunloopViewWithIndex:_currentIndex];
    }
}

#pragma mark 重写dataModel的set方法,轮播图布局
- (void)setDataModel:(LLFRunloopModel *)dataModel
{
    if (!_dataModel) {
        [self.lodingAnmationArr removeAllObjects];
        _dataModel = dataModel;
        if (dataModel.imageUrlArr.count > 1) {
            self.time = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
            //有多张图片时
            
            self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * (_dataModel.imageUrlArr.count + 2), CGRectGetHeight(self.scrollView.frame));
            
            UIImageView *firstIV = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
            [self setImageWithUrl:[_dataModel.imageUrlArr lastObject] imageView:firstIV index:0];
            [self.scrollView addSubview:firstIV];
            
            LoadingView *firstLodingView = [[LoadingView alloc]initWithFrame:firstIV.bounds];
            [firstIV addSubview:firstLodingView];
            [self.lodingAnmationArr addObject:firstLodingView];
            
            for (int i = 0; i < _dataModel.imageUrlArr.count; i++) {
                UIImageView *tempIV = [[UIImageView alloc]initWithFrame:CGRectMake((i + 1) * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
                tempIV.backgroundColor = [UIColor blueColor];
                [self.scrollView addSubview:tempIV];
                
                LoadingView *tempLodingView = [[LoadingView alloc]initWithFrame:tempIV.bounds];
                [tempIV addSubview:tempLodingView];
                [self.lodingAnmationArr addObject:tempLodingView];
                [self setImageWithUrl:_dataModel.imageUrlArr[i] imageView:tempIV index:self.lodingAnmationArr.count - 1];
                
            }
            
            UIImageView *lastIV = [[UIImageView alloc]initWithFrame:CGRectMake((_dataModel.imageUrlArr.count + 1) * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame))];
            [self.scrollView addSubview:lastIV];
            
            LoadingView *lastLodingView = [[LoadingView alloc]initWithFrame:lastIV.bounds];
            [lastIV addSubview:lastLodingView];
            [self.lodingAnmationArr addObject:lastLodingView];
            [self setImageWithUrl:[_dataModel.imageUrlArr firstObject] imageView:lastIV index:self.lodingAnmationArr.count - 1];
            
            self.page.numberOfPages = _dataModel.imageUrlArr.count;
            [self.page addTarget:self action:@selector(pageAction:) forControlEvents:(UIControlEventTouchUpInside)];
            self.scrollView.pagingEnabled = YES;
            self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        }else if (dataModel.imageUrlArr.count == 1){
            //当有一张图片时
            self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
            
            UIImageView *firstIV = [[UIImageView alloc]initWithFrame:self.scrollView.bounds];
            [self setImageWithUrl:[_dataModel.imageUrlArr firstObject] imageView:firstIV index:0];
            [self.scrollView addSubview:firstIV];
            
            LoadingView *firstLodingView = [[LoadingView alloc]initWithFrame:firstIV.bounds];
            [firstIV addSubview:firstLodingView];
//            [self.lodingAnmationArr addObject:firstLodingView];
            
        }else{
            self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
            
            UILabel *firstIV = [[UILabel alloc]initWithFrame:self.scrollView.bounds];
            firstIV.text = @"暂无图片,敬请期待...";
            firstIV.textColor = [UIColor hex:@"#FFA6A6A6"];
            firstIV.textAlignment = NSTextAlignmentCenter;
            firstIV.font = [UIFont systemFontOfSize:15.0];
            firstIV.backgroundColor = [UIColor hex:@"#FFF5F5F5"];
            [self.scrollView addSubview:firstIV];
        }
        
    }
}

#pragma mark pageControl响应方法
- (void)pageAction:(UIPageControl *)sender
{
//    NSLog(@"%ld",sender.currentPage);
//    NSLog(@"%ld",self.page.currentPage);
//    NSLog(@"%ld",_currentIndex);
    if (_currentIndex == sender.currentPage) {
        //到了最后一张
        if (_currentIndex == self.dataModel.imageUrlArr.count - 1) {
            NSLog(@"到了最后一张");
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (self.dataModel.imageUrlArr.count + 1), 0);
                
            }];
            self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
            self.page.currentPage = 0;
            _currentIndex = self.page.currentPage;
        }else if(_currentIndex == 0){
            NSLog(@"到了第一张");
            [UIView animateWithDuration:0.5 animations:^{
                self.scrollView.contentOffset = CGPointMake(0, 0);
            }];
            self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (self.dataModel.imageUrlArr.count), 0);
            //将page 的点移到最后
            self.page.currentPage = self.dataModel.imageUrlArr.count - 1;
            _currentIndex = self.page.currentPage;
        }
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (sender.currentPage + 1), 0);
        }];
        //记录当前也
        _currentIndex = sender.currentPage;
    }
//    NSLog(@"%ld",sender.currentPage);
//    NSLog(@"%ld",self.page.currentPage);
//    NSLog(@"%ld",_currentIndex);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollView.contentOffset.x == self.scrollView.frame.size.width * (self.dataModel.imageUrlArr.count + 1)) {
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
    }else if (self.scrollView.contentOffset.x == 0){
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (self.dataModel.imageUrlArr.count), 0);
    }
    //计算当前页
    self.page.currentPage = self.scrollView.contentOffset.x / self.scrollView.frame.size.width - 1;
    //记录当前页
    _currentIndex = self.page.currentPage;
}


#pragma mark 加载图片
- (void)setImageWithUrl:(NSString *)url imageView:(UIImageView *)imageV index:(NSInteger)index
{
//        [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"1"]];
//    imageV.image = [UIImage imageNamed:url];
    imageV.backgroundColor = [UIColor hex:@"#FFF5F5F5"];
    [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        LoadingView *firstLodingView = self.lodingAnmationArr[index];
//        [firstLodingView removeFromSuperview];
        [imageV removeAllSubviews];
    }];
    
}

#pragma mark 图片轮播的定时执行方法
- (void)timeAction:(NSTimer *)sender
{
    if (_currentIndex < self.dataModel.imageUrlArr.count - 1) {
        _currentIndex = _currentIndex + 1;
        
    }else if (_currentIndex >= self.dataModel.imageUrlArr.count - 1){
        _currentIndex = 0;
    }
    self.page.currentPage = _currentIndex;
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (_currentIndex + 1), 0);
    }];
//    [self pageAction:self.page];
    
}


@end
