//
//  LSAddProgramDetailsViewController.m
//  YDJR
//
//  Created by 李爽 on 16/10/8.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddProgramDetailsViewController.h"
#import "LSAddProgramDetailsView.h"

@interface LSAddProgramDetailsViewController ()
@property (nonatomic,strong)LSAddProgramDetailsView *addProgramDetailsView;
@property (nonatomic,strong)HGBPromgressHud *phud;
@end

@implementation LSAddProgramDetailsViewController

-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.addProgramDetailsView == nil) {
        self.addProgramDetailsView = [[LSAddProgramDetailsView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) andWithModel:self.productsModel withPrice:self.catModelDetailPrice withProductDict:@""];
        [self.view addSubview:self.addProgramDetailsView];
        //self.addProgramDetailsView = addProgramDetailsView;
    }
}

#pragma mark - LSAddProgramDetailsViewControllerDelegate
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    if (_delegate && ([_delegate respondsToSelector:
                       @selector(popToAddProgramViewControllerWithChoosedProductModel:)])) {
        [_delegate popToAddProgramViewControllerWithChoosedProductModel:self.addProgramDetailsView.choosedProductsModel];
    }
}

@end
