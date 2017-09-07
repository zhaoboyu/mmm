//
//  DetailListCellPopView.m
//  YongDaFinance
//
//  Created by 吕利峰 on 16/8/5.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "DetailListCellPopView.h"
#import "BasicInfoListTableViewCell.h"
#define kcell @"basicInfoListTableViewCell"
@interface DetailListCellPopView ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat _cellHight;
}
@property (nonatomic,strong)UIView *backGroudView;
@property (nonatomic,assign)CGRect listFrame;
@property (nonatomic,strong)NSMutableArray *listArr;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,assign)BOOL isOtherTitle;
@property (nonatomic,strong)NSMutableArray *otherArr;
@end

@implementation DetailListCellPopView

- (instancetype)initWithFrame:(CGRect)frame ListFrame:(CGRect)listFrame listArr:(NSArray *)listArr isOtherTitle:(BOOL)isOtherTitle
{
    if (self = [super initWithFrame:frame]) {
        self.listFrame = listFrame;
        self.listArr = [NSMutableArray array];
        [self.listArr addObjectsFromArray:listArr];
        self.isOtherTitle = isOtherTitle;
        if (isOtherTitle) {
            self.otherArr = [NSMutableArray array];
            [self.otherArr addObject:[listArr firstObject]];
            [self.otherArr addObject:@"其他"];
        }
        _cellHight = listFrame.size.height;
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.backgroundColor = [UIColor clearColor];
    CGFloat vHight1 = kHeight - self.listFrame.origin.y - 64;
    CGFloat vHight2 = self.listFrame.size.height * [self.listArr count];
    CGFloat vHight = vHight1 < vHight2 ? vHight1 : vHight2;
    CGRect viewRect = CGRectMake(self.listFrame.origin.x, self.listFrame.origin.y + _cellHight, self.listFrame.size.width, vHight);
    self.backGroudView = [[UIView alloc]initWithFrame:viewRect];
    self.backGroudView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.backGroudView];
    
    CGRect tableRect = viewRect;
    tableRect.origin.x = 0;
    tableRect.origin.y = 0;
    self.tableView = [[UITableView alloc]initWithFrame:self.backGroudView.bounds style:(UITableViewStylePlain)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.layer.borderColor = [UIColor hexString:@"#FFE6E6E6"].CGColor;
    self.tableView.layer.borderWidth = 0.5;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[BasicInfoListTableViewCell class] forCellReuseIdentifier:kcell];
    [self.backGroudView addSubview:self.tableView];
    [self upListFrame];
    //    [self queryData];
    //设置默认选中cell
    //    NSInteger selectedIndex = 0;
    //    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    //    [self.tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    //
    //    [self tableView:self.tableView didSelectRowAtIndexPath:selectedIndexPath];
}
- (void)upListFrame
{
    
    CGRect viewRect = self.backGroudView.frame;
    if (self.isOtherTitle) {
        CGFloat vHight1 = kHeight - self.listFrame.origin.y - 64;
        CGFloat vHight2 = self.listFrame.size.height * [self.otherArr count];
        CGFloat vHight = vHight1 < vHight2 ? vHight1 : vHight2;
        viewRect.size.height = vHight;
    }else{
        CGFloat vHight1 = kHeight - self.listFrame.origin.y - 64;
        CGFloat vHight2 = self.listFrame.size.height * [self.listArr count];
        CGFloat vHight = vHight1 < vHight2 ? vHight1 : vHight2;
        viewRect.size.height = vHight;
    }
    self.backGroudView.frame = viewRect;
    self.tableView.frame = self.backGroudView.bounds;
    [self.tableView reloadData];
}
#pragma mark tableView的delegate和souce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isOtherTitle) {
        return self.otherArr.count;
    }else{
        return [self.listArr count];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BasicInfoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcell forIndexPath:indexPath];
    if (self.isOtherTitle) {
        NSString *titleStr = self.otherArr[indexPath.row];
        cell.titleLable.text = titleStr;
        cell.lineImageView.hidden = NO;
    }else{
        NSString *titleStr = self.listArr[indexPath.row];
        cell.titleLable.text = titleStr;
        cell.lineImageView.hidden = NO;
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当前屏幕上显示的所有cell
    //    NSArray *cells = [tableView visibleCells];
    //    for (BasicInfoListTableViewCell *showCell in cells) {
    //        showCell.titleLable.textColor = [UIColor hexString:@"#FFA7A7A7"];
    //    }
    //    BasicInfoListTableViewCell *nowShowCell = (BasicInfoListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    //    nowShowCell.titleLable.textColor = [UIColor hexString:@"#FF66A6FF"];
    //    if (_delgate && ([_delgate respondsToSelector:@selector(sendMessageWithIndexPath:message:)])) {
    //        [_delgate sendMessageWithIndexPath:indexPath message:nil];
    //    }
    if (self.isOtherTitle) {
        NSString *titleStr = self.otherArr[indexPath.row];
        if ([titleStr isEqualToString:@"其他"]) {
            self.isOtherTitle = NO;
            [self upListFrame];
        }else{
            [self hidePopView];
            NSString *titleStr = self.otherArr[indexPath.row];
            if (_delegate && [_delegate respondsToSelector:@selector(sendMessageWithMessage:)]) {
                [_delegate sendMessageWithMessage:titleStr];
            }
            
            if (self.confirmBlock) {
                self.confirmBlock(titleStr);
            }
        }
        
        
    }else{
        [self hidePopView];
        NSString *titleStr = self.listArr[indexPath.row];
        if (_delegate && [_delegate respondsToSelector:@selector(sendMessageWithMessage:)]) {
            [_delegate sendMessageWithMessage:titleStr];
        }
        
        if (self.confirmBlock) {
            self.confirmBlock(titleStr);
        }
    }
    
    
}
//出现
- (void)showPopView
{
    
    
    //    self.tableView.frame = CGRectMake(0, -self.listFrame.size.height * [self.listArr count], self.listFrame.size.width, self.listFrame.size.height * [self.listArr count]);
    CGRect rect = self.tableView.frame;
    rect.origin.y = self.backGroudView.frame.size.height;
    self.tableView.frame = rect;
    [self addPopViewToWinder];
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect1 = self.tableView.frame;
        rect1.origin.y = 0;
        self.tableView.frame = rect1;
    } completion:^(BOOL finished) {
        
    }];
}
//取消
- (void)hidePopView
{
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect1 = self.tableView.frame;
        rect1.origin.y = self.backGroudView.frame.size.height;
        self.tableView.frame = rect1;
        
    } completion:^(BOOL finished) {
        [self removePopViewFromWinder];
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hidePopView];
    if (_delegate && [_delegate respondsToSelector:@selector(popViewHide)]) {
        [_delegate popViewHide];
    }
}
@end
