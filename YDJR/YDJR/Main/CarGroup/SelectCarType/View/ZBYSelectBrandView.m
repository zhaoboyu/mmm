//
//  ZBYSelectBrandView.m
//  YDJR
//
//  Created by 赵博宇 on 2017/6/7.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "ZBYSelectBrandView.h"
#import "ZBYBrandSelectTableViewCell.h"
#import "LLFChangTypeListTableViewCell.h"
@interface ZBYSelectBrandView ()<UITableViewDelegate,UITableViewDataSource>

//@property(nonatomic,strong)UITableView *selectTable;
@property(nonatomic,strong)UIImageView *backimage;
//@property(nonatomic,strong)UIImageView *backImageView;
@property(nonatomic,strong)NSArray *dataarr;
@property(nonatomic,assign)NSInteger whichSelected;
@property(nonatomic,strong)UIView *firstView;
@property(nonatomic,strong)UITableView *firstTableView;
@property(nonatomic,strong)UILabel *firstBrandLabel;
@property(nonatomic,strong)UIView *secondView;
@property(nonatomic,strong)UITableView *secondTableView;
@property(nonatomic,strong)UILabel *secondBrandLabel;
@property(nonatomic,assign)NSInteger selectType;
@end



@implementation ZBYSelectBrandView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.selectType = -1;
        self.whichSelected = 0;
//     self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.backimage = [[UIImageView alloc]initWithFrame:self.bounds];
        self.backimage.userInteractionEnabled = YES;
        self.backimage.clipsToBounds = YES;
        self.backimage.image = [self resizAbleImageWithImageName:@"selectBrand"];
        [self addSubview:self.backimage];
        [self.backimage addSubview:self.firstView];
        self.dataarr = @[@"品牌",@"机构"];
        [self.firstTableView reloadData];
       
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.firstTableView]) {
        LLFChangTypeListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LLFChangTypeListTableViewCell"];
        [cell cell:self.dataarr[indexPath.row]];
        return cell;
    }else{
        ZBYBrandSelectTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ZBYBrandSelectTableViewCell"];
        if (self.selectType == 0) {
            NSString *ppName = [self.dataarr[indexPath.row] objectForKey:@"ppName"];
            [cell cell:ppName selected:[ppName isEqualToString:[Tool getPpName]]?YES:NO ];
        }else if(self.selectType == 1){
            NSString *mechanismName = [self.dataarr[indexPath.row] objectForKey:@"mechanismName"];
            [cell cell:mechanismName selected:[mechanismName isEqualToString:[Tool getMechanismName]]?YES:NO ];
        }
        
        return cell;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100*wScale;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView isEqual:self.firstTableView]) {
        [self.backimage addSubview:self.secondView];
        if (indexPath.row == 0) {
            self.selectType = 0;
            //品牌
            self.secondBrandLabel.text = @"品牌";
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSInteger index = [defaults integerForKey:[NSString stringWithFormat:@"%@MechinsIdIndex",[UserDataModel sharedUserDataModel].userName]];
            NSArray *MechinsIdArr = [UserDataModel sharedUserDataModel].mechanismID;
            NSArray *carPpNameArr;
            if (index && index >= 0) {
                carPpNameArr = [MechinsIdArr[index] objectForKey:@"ppName"];
            }else{
                carPpNameArr = [MechinsIdArr[0] objectForKey:@"ppName"];
            }
            self.dataarr = carPpNameArr;
        }else if(indexPath.row == 1){
            self.selectType = 1;
            //机构
            self.dataarr = [UserDataModel sharedUserDataModel].mechanismName;
            self.secondBrandLabel.text = @"门店";
        }
        [self.secondTableView reloadData];
        self.secondView.frame = CGRectMake(self.frame.size.width, 3 * hScale, self.frame.size.width, self.frame.size.height - 3 * hScale);
        
        
        
        [UIView animateWithDuration:0.2 animations:^{
            self.secondView.frame = CGRectMake(0, 3 * hScale, self.frame.size.width, self.frame.size.height - 3 * hScale);
        } completion:^(BOOL finished) {
            CGRect viewFrame = self.frame;
            viewFrame.size.height = self.dataarr.count > 5 ? (103 + 100 * 5) * hScale : (103 + 100 * self.dataarr.count) * hScale;
            self.frame = viewFrame;
            self.backimage.frame = self.bounds;
            self.secondView.frame = CGRectMake(0, 3 * hScale, self.frame.size.width, self.frame.size.height - 3 * hScale);
            self.secondTableView.frame = CGRectMake(0, CGRectGetMaxY(self.secondBrandLabel.frame), self.frame.size.width, self.frame.size.height-CGRectGetMaxY(self.secondBrandLabel.frame) + 1 * hScale);
        }];
    }else{
        if (self.selectType == 0) {
            //品牌
            [Tool savePpNameWithIndex:indexPath.row];
        }else if (self.selectType == 1){
            //机构
            [Tool saveMechinsIdWithIndex:indexPath.row];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 0;
                
            } completion:^(BOOL finished) {
                @autoreleasepool {
                    [self removeFromSuperview];
                }
                
            }];
            
            [self.brandDelegate brandSelected];
        });
    }
}
- (void)removeFromSuperview{
    [super removeFromSuperview];
    [self.brandDelegate removeBtnUser];
}
- (void)backButtonAction:(UIButton *)sender
{
    
    
    self.secondView.frame = CGRectMake(0, 3 * hScale, self.frame.size.width, self.frame.size.height - 3 * hScale);
    
    [UIView animateWithDuration:0.2 animations:^{
        self.secondView.frame = CGRectMake(self.frame.size.width, 3 * hScale, self.frame.size.width, self.frame.size.height - 3 * hScale);
    } completion:^(BOOL finished) {
        [self.secondView removeFromSuperview];
        CGRect viewFrame = self.frame;
        viewFrame.size.height = (103 + 100 * 2) * hScale;
        self.frame = viewFrame;
        self.backimage.frame = self.bounds;
//        self.firstView.frame = CGRectMake(0, 3 * hScale, self.frame.size.width, self.frame.size.height - 3 * hScale);
    }];
}
- (UIView *)firstView{
    if (!_firstView) {
        _firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 3 * hScale, self.frame.size.width, self.frame.size.height - 3 * hScale)];
        
        self.firstBrandLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _firstView.frame.size.width, 100*hScale)];
        self.firstBrandLabel.backgroundColor = [UIColor hexString:@"#f9f9fa"];
//        self.firstBrandLabel.backgroundColor = [UIColor redColor];
        self.firstBrandLabel.text = @"品牌与门店";
        self.firstBrandLabel.clipsToBounds = YES;
        self.firstBrandLabel.layer.cornerRadius = 10 * wScale;
        self.firstBrandLabel.textAlignment = NSTextAlignmentCenter;
        self.firstBrandLabel.textColor = [UIColor hexString:@"#344343"];
        [_firstView addSubview:self.firstBrandLabel];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.firstBrandLabel.frame.size.height +self.firstBrandLabel.frame.origin.y-1*wScale , self.frame.size.width, 1*wScale)];
        line.backgroundColor = [UIColor hexString:@"#d9d9d9"];
        [_firstView addSubview:line];
        
        self.firstTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), self.frame.size.width, self.frame.size.height-CGRectGetMaxY(line.frame))];
//        self.firstTableView.backgroundColor = [UIColor redColor];
        self.firstTableView.delegate = self;
        
        self.firstTableView.dataSource = self;
        self.firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.firstTableView registerClass:[LLFChangTypeListTableViewCell class] forCellReuseIdentifier:@"LLFChangTypeListTableViewCell"];
        
        //    self.selectTable.scrollEnabled = [UserDataModel sharedUserDataModel].ppName.count>5?YES:NO;
        [_firstView addSubview:self.firstTableView];

    }
    return _firstView;
}

- (UIView *)secondView{
    if (!_secondView) {
        _secondView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width, 3 * hScale, self.frame.size.width, self.frame.size.height - 3 * hScale)];
        
        self.secondBrandLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100*hScale)];
        self.secondBrandLabel.backgroundColor = [UIColor hexString:@"#f9f9fa"];
//        self.secondBrandLabel.backgroundColor = [UIColor redColor];
//        self.secondBrandLabel.text = @"机构";
        self.secondBrandLabel.clipsToBounds = YES;
        self.secondBrandLabel.layer.cornerRadius = 10 * wScale;
        self.secondBrandLabel.textAlignment = NSTextAlignmentCenter;
        self.secondBrandLabel.textColor = [UIColor hexString:@"#344343"];
        [_secondView addSubview:self.secondBrandLabel];
        
        UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20 * wScale, 35 * hScale, 18 * wScale, 30 * hScale)];
        backImageView.image = [UIImage imageNamed:@"LLF_SelectNewCarType_back"];
        [self.secondBrandLabel addSubview:backImageView];
        
        UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(6 * wScale + CGRectGetMaxX(backImageView.frame), 33 * hScale, 80 * wScale, 34 * hScale)];
        backLabel.text = @"返回";
        backLabel.textColor = [UIColor hex:@"#FF434343"];
        backLabel.font = [UIFont systemFontOfSize:15.0];
        [self.secondBrandLabel addSubview:backLabel];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 124, 100 * hScale);
        [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_secondView addSubview:backButton];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.secondBrandLabel.frame.size.height +self.secondBrandLabel.frame.origin.y-1*wScale , self.frame.size.width, 1*wScale)];
        line.backgroundColor = [UIColor hexString:@"#d9d9d9"];
        [_secondView addSubview:line];
        
        self.secondTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), self.frame.size.width, self.frame.size.height-CGRectGetMaxY(self.secondBrandLabel.frame) + 1 * hScale)];
        self.secondTableView.delegate = self;
        
        self.secondTableView.dataSource = self;
        self.secondTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.secondTableView registerClass:[ZBYBrandSelectTableViewCell class] forCellReuseIdentifier:@"ZBYBrandSelectTableViewCell"];
        
        //    self.selectTable.scrollEnabled = [UserDataModel sharedUserDataModel].ppName.count>5?YES:NO;
        [_secondView addSubview:self.secondTableView];
        
    }
    return _secondView;
}

/**
 图片拉伸处理

 @param imageName 需要拉伸的图片
 @return 拉伸后的图片
 */
- (UIImage *)resizAbleImageWithImageName:(NSString *)imageName
{
    // 加载图片
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    return newImage;
}
@end
