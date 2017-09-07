//
//  SDCCustomerInfoView.m
//  YDJR
//
//  Created by sundacheng on 16/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

//view
#import "SDCCustomerInfoView.h"
#import "DetailListCellPopView.h"
#import "SDCCustomInfoBox.h"

//工具
#import "UIView+ViewController.h"
#import "Tool.h"

//model
#import "SDCCustomerContactModel.h"

//api
#import "CTTXRequestServer+CustomerManager.h"

//size
#define viewW 1780/2
#define viewH (1060 - 64)/2

//tag
#define Label_Tag 143

@interface SDCCustomerInfoView ()
@property (nonatomic,strong)NSArray *arrEnterprise;
@property (nonatomic,strong)NSArray *arrPersonal;
@property (nonatomic, copy) NSMutableDictionary *idsType; //身份类型
@property (nonatomic ,strong)NSMutableArray *idsTypesArr;

@property (nonatomic, copy) NSDictionary *customerType; //客户类型

@property (nonatomic, strong) NSMutableArray *infoArray;//客户信息

//加载框
@property (nonatomic, strong) MBProgressHUD *progress;

@end

@implementation SDCCustomerInfoView
{
    NSMutableArray *_boxArray; //盒子数组
    BOOL _isEditState; //是否是编辑状态
    
//    NSString *_oldIdType; //旧身份类型
//    NSString *_oldIdNumer; //旧id号
    NSString*  oldCustomerType;
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _isEditState = NO;
        [self createUI];
    }
    return self;
}

#pragma mark - ui
- (void)createUI {
    //背景
    UIView *bgview = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:bgview];
    bgview.backgroundColor = [UIColor blackColor];
    bgview.alpha = 0.2;
    
    //主视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH)];
    [self addSubview:view];
    
    view.backgroundColor = [UIColor hex:@"#ffffff"];
    view.center = CGPointMake(kWidth/2, (kHeight - 64)/2);
    
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 7;
    
    //导航
    UIView *navTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, 49)];
    [view addSubview:navTitleView];
    navTitleView.backgroundColor = [UIColor whiteColor];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 49)];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [closeBtn setTitleColor:[UIColor hex:@"#4A4A4A"] forState:UIControlStateNormal];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [navTitleView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(viewW - 65, 0, 65, 49)];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [editBtn setTitleColor:[UIColor hex:@"#FC5A5A"] forState:UIControlStateNormal];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [navTitleView addSubview:editBtn];
    [editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    titleLb.center = navTitleView.center;
    titleLb.text = @"客户信息";
    titleLb.textColor = [UIColor hex:@"#333333"];
    [navTitleView addSubview:titleLb];
    titleLb.textAlignment = NSTextAlignmentCenter;
    
    //小标题
    UIView *stitleView = [self titleMsgView:@"客户信息"];
    [view addSubview:stitleView];
    stitleView.top = 122/2;
    
    //间隙背景
    UIView *gapView = [[UIView alloc] initWithFrame:CGRectMake(0, navTitleView.bottom, viewW, navTitleView.bottom - stitleView.top)];
    gapView.backgroundColor = [UIColor hex:@"#F2F3F7"];
    [view addSubview:gapView];
    
    //Box
    _boxArray = [[NSMutableArray alloc] init];
    
    CGFloat boxW = viewW/4;
    CGFloat boxH = 208/2;
    
    for (NSInteger i = 0; i < 4; i++) {
        SDCCustomInfoBox *boxView = [[SDCCustomInfoBox alloc] initWithFrame:CGRectMake(boxW*i, 210/2, boxW, boxH)];
        [view addSubview:boxView];
        
        UITapGestureRecognizer *tapFixGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFixGesture:)];
        
        [boxView.inputLabel addGestureRecognizer:tapFixGesture];
        
        [_boxArray addObject:boxView];
        boxView.inputLabel.tag = Label_Tag + i;
    }
    
    for (NSInteger i = 0; i < 3; i++) {
        SDCCustomInfoBox *boxView;
        if (i == 2) {
            boxView = [[SDCCustomInfoBox alloc] initWithFrame:CGRectMake(boxW*i, 210/2 + boxH, boxW*2, boxH)];
            //            boxView.backgroundColor = [UIColor redColor];
        }else{
            boxView = [[SDCCustomInfoBox alloc] initWithFrame:CGRectMake(boxW*i, 210/2 + boxH, boxW, boxH)];
        }
        //        SDCCustomInfoBox *boxView = [[SDCCustomInfoBox alloc] initWithFrame:CGRectMake(boxW*i, 210/2 + boxH, boxW, boxH)];
        [view addSubview:boxView];
        boxView.inputLabel.tag = Label_Tag + i + 4;
        UITapGestureRecognizer *tapFixGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFixGesture:)];
        
        [boxView.inputLabel addGestureRecognizer:tapFixGesture];
        [_boxArray addObject:boxView];
    }
}

- (UIView *)titleMsgView:(NSString *)msgInfo {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 12)];
    [view addSubview:titleLb];
    titleLb.centerY = 44/2;
    titleLb.left = 16;
    titleLb.text = msgInfo;
    titleLb.textColor = [UIColor hex:@"#21456E"];
    titleLb.font = [UIFont systemFontOfSize:13];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, msgInfo.length*13.5, 1)];
    [view addSubview:line];
    line.backgroundColor = [UIColor hex:@"#21456E"];
    line.left = 14;
    line.bottom = 44 - 0.5;
    
    UIView *buttomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 44 - 0.5, viewW, 0.5)];
    buttomLine.backgroundColor = [UIColor hex:@"#D9D9D9"];
    [view addSubview:buttomLine];
    
    return view;
}

#pragma mark - 刷新数据
//flag 0:本类调用    1:外部类调用
- (void)reloadDataWithCustomerArray:(NSArray *)array   outsideflag:(int)flag{
    
    for (NSInteger i = 0; i < _boxArray.count; i++) {
        SDCCustomInfoBox *box = _boxArray[i];
        if (i<array.count) {
            NSDictionary *dict = array[i];
            box.titleLb.text = dict[@"title"];
            box.inputLabel.text = dict[@"content"];
        }
        else{
            box.titleLb.text = @"";
            box.inputLabel.text = @"";
        }
        if (flag == 0) {
            box.inputLabel.userInteractionEnabled = YES;
        }
        else{
            box.inputLabel.userInteractionEnabled = NO;
            oldCustomerType=self.customerContactModel.customerType;
        }
    }
    
    
    
}

#pragma mark - 修改接口
- (void)fixCustomInfoApi {
    SDCCustomerContactModel *model = self.customerContactModel;
    
    NSDictionary *dict = [model yy_modelToJSONObject];
    
    self.progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    self.progress.userInteractionEnabled = NO;
    
    [[CTTXRequestServer shareInstance] customerInfoFixWithCustomer:dict SuccessBlock:^{
        [self.progress hide:YES];
    } failedBlock:^(NSError *error) {
        [self.progress hide:YES];
//        self.progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//        self.progress.detailsLabelText = @"服务器异常";
//        self.progress.labelText = @"提示";
//        self.progress.userInteractionEnabled = NO;
//        self.progress.mode = MBProgressHUDModeText;
//        [self.progress hide:YES afterDelay:2];
          [self showIdcardView:@"服务器异常"];
        return;
    }];
}

#pragma mark - action
//点击修改
- (void)tapFixGesture:(UITapGestureRecognizer *)sender {
    UILabel *label = (UILabel *)[sender view];
    
    switch ([sender view].tag - Label_Tag) {
        case 0:case 3:case 4:case 6:
        {
            [self setLabelView:label];
        }
            break;
        case 1:case 2:case 5:
        {
            [self selectTypeWithLabelView:label];
        }
            break;
            
        default:
            break;
    }
}

- (void)setLabelView:(UILabel *)label {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入修改内容";
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.keyboardType= UIKeyboardTypeNumberPad;
        if (label.tag - Label_Tag == 0) {
            //客户姓名
            textField.keyboardType = UIKeyboardTypeDefault;
        }
    }];
    
    [[self viewController] presentViewController:alert animated:YES completion:nil];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (alert.textFields[0].text.length == 0) {
            return ;
        } else {
            
            if (label.tag - Label_Tag == 0) {
                //
                if ([Tool isCustomerPersonTypeWithCustomerType:self.customerContactModel.customerType]) {
                     self.customerContactModel.customerLxr = alert.textFields[0].text;
                }
                else{//客户姓名
                     self.customerContactModel.customerName = alert.textFields[0].text;
                }
               
            } else if (label.tag - Label_Tag == 3) {
                //客户证件号
                if (![Tool checkIDCardNum:alert.textFields[0].text] && self.customerContactModel.idsType.intValue == 1) {
                    //验证身份证
//                    self.progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//                    self.progress.detailsLabelText = @"身份证号格式不正确";
//                    self.progress.labelText = @"提示";
//                    self.progress.userInteractionEnabled = NO;
//                    self.progress.mode = MBProgressHUDModeText;
//                    [self.progress hide:YES afterDelay:2];
                    [self showIdcardView:@"身份证号格式不正确"];
                    return;
                }
                
                self.customerContactModel.idsNumber = alert.textFields[0].text;
                
            } else if (label.tag - Label_Tag == 4) {
                //客户电话
                if (![Tool isMobileNumberWithPhoneNum:alert.textFields[0].text]) {
                    //电话号码验证
//                    self.progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//                    self.progress.detailsLabelText = @"电话号码格式不正确";
//                    self.progress.labelText = @"提示";
//                    self.progress.userInteractionEnabled = NO;
//                    self.progress.mode = MBProgressHUDModeText;
//                    [self.progress hide:YES afterDelay:2];
                    [self showIdcardView:@"电话号码格式不正确"];
                    return;
                }
                self.customerContactModel.customerPhone = alert.textFields[0].text;
            }else if (label.tag - Label_Tag == 6){
                //客户地址
//                self.customerContactModel.address = alert.textFields[0].text;
                self.customerContactModel.customerName = alert.textFields[0].text;
                
            }
            
            label.text = alert.textFields[0].text;
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
}

- (void)selectTypeWithLabelView:(UILabel *)label  {
    CGRect originInSuperView = [self.window convertRect:label.bounds fromView:label];
    
    NSArray *array;
    BOOL isCardType = NO;
    if (label.tag - Label_Tag == 1) {
        //客户性别
        array = @[@"男",@"女"];
    } else if (label.tag - Label_Tag == 2) {
        //证件类型
        array = self.idsTypesArr;
        isCardType = YES;
    } else if (label.tag - Label_Tag == 5) {
        //客户类型
        array = [[Tool customerTypeDictionary] allKeys];
    }
    
    DetailListCellPopView *dcPopView = [[DetailListCellPopView alloc]initWithFrame:[[UIScreen mainScreen] bounds] ListFrame:originInSuperView listArr:array isOtherTitle:isCardType];
    
    [dcPopView setConfirmBlock:^(NSString *text) {
        if (label.tag - Label_Tag == 1) {
            //客户性别
            self.customerContactModel.customerSex  = text;
        } else if (label.tag - Label_Tag == 2) {
            //控制身份类型
//            _oldIdType = nil;
//            if ([self.idsType[text] intValue] == 1) {
//                _oldIdType = [self.customerContactModel.idsType mutableCopy];
//                _oldIdNumer = [self.customerContactModel.idsNumber mutableCopy];
//            }
            
            //身份类型
            self.customerContactModel.idsType = self.idsType[text];
            
        } else if (label.tag - Label_Tag == 5) {
            //客户类型
            self.customerContactModel.customerType = self.customerType[text];
            
            if ([Tool isCustomerPersonTypeWithCustomerType:self.customerContactModel.customerType]) {
                
                //之前是个人客户
                if (![Tool isCustomerPersonTypeWithCustomerType:oldCustomerType]){
                    _customerContactModel.customerLxr= _customerContactModel.customerName;
                    _customerContactModel.customerName=@"";
                }
                else{
                //什么都不做
                    
                }
//                if ([oldCustomerType isEqualToString:@"01"]) {

                
                //                boxView.titleLb.text=@"企业名称";
                
                oldCustomerType=self.customerContactModel.customerType;
                [self reloadDataWithCustomerArray:self.arrEnterprise outsideflag:0];
            }
            else{
//                boxView.titleLb.text=@"客户姓名";
                
                //之前是企业客户
                if ([Tool isCustomerPersonTypeWithCustomerType:oldCustomerType]){
                    _customerContactModel.customerName=_customerContactModel.customerLxr;
//                    _customerContactModel.customerLxr=@"";
                    
                }
                else{
                    //什么都不做
                    
                }
                 oldCustomerType=self.customerContactModel.customerType;;
                [self reloadDataWithCustomerArray:self.arrPersonal  outsideflag:0];
            }
            
        }
        label.text = text;
    }];
    
    [dcPopView showPopView];
}

//关闭
- (void)closeAction {
//    if ((_oldIdType && self.customerContactModel.idsType.intValue == 1 && ![Tool checkIDCardNum:self.customerContactModel.idsNumber]) || self.customerContactModel.idsType == _oldIdType) {
//        self.customerContactModel.idsType = _oldIdType;
//        self.customerContactModel.idsNumber = _oldIdNumer;
//    }
//    
    [self removeFromSuperview];
}

//编辑
- (void)editAction:(UIButton *)btn {
    if (!_isEditState) {
        for (SDCCustomInfoBox *box in _boxArray) {
            box.inputLabel.textColor = [UIColor hex:@"#FC5A5A"];
            box.inputLabel.userInteractionEnabled = YES;
        }
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        _isEditState = YES;
    } else {
        
        ////        if ((_oldIdType && self.customerContactModel.idsType.intValue == 1 && ![Tool checkIDCardNum:self.customerContactModel.idsNumber]) || self.customerContactModel.idsType == _oldIdType) {
        //        if ((_oldIdType && self.customerContactModel.idsType.intValue == 1) || self.customerContactModel.idsType == _oldIdType) {
        ////            self.progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        ////            self.progress.detailsLabelText = @"身份证号码格式不正确";
        ////            self.progress.labelText = @"提示";
        ////            self.progress.userInteractionEnabled = NO;
        ////            self.progress.mode = MBProgressHUDModeText;
        ////            [self.progress hide:YES afterDelay:2];
        ////
        ////            self.customerContactModel.idsType = _oldIdType;
        ////            self.customerContactModel.idsNumber = _oldIdNumer;
        //            [self showIdcardView:@"身份证号码格式不正确"];
        //            return;
        //        }
        
        
        if ( ![self checkCustomerContactModel_is_true] ) {
            return;
        }
        //保存接口
        [self fixCustomInfoApi];
        
        for (SDCCustomInfoBox *box in _boxArray) {
            box.inputLabel.textColor = [UIColor hex:@"#333333"];
            box.inputLabel.userInteractionEnabled = NO;
        }
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        _isEditState = NO;
    }
}

#pragma mark - 校验 customerContactModel
-(BOOL)checkCustomerContactModel_is_true{
    
    //也不选择证件类型，不填写证件信息
    NSString* str=[self idsTypeToString];
    if ([str isEqualToString:@""]) {
        return YES;
    }
    
    if(![self.idsTypesArr containsObject:str]) {
        [self showIdcardView:@"证件类型和客户类型不匹配"];
        return NO;
    }
    
    //01:企业,02:个人
    if (![Tool isCustomerPersonTypeWithCustomerType:self.customerContactModel.customerType]) {
        //判断是否为身份证
        if ([self.customerContactModel.idsType isEqualToString:@"1"]) {
            if (![Tool checkIDCardNum:self.customerContactModel.idsNumber]) {
                [self showIdcardView:@"身份证号码格式不正确"];
                return NO;
            }
        }
        
    }
    
    return YES;

}


-(NSString*)idsTypeToString{
    
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *cardTypeDic = tempArr[0];
    //获取客户类型列表
    
    NSString* str=@"";
    NSArray *cardTypeArr;
    if ([Tool isCustomerPersonTypeWithCustomerType:self.customerContactModel.customerType]) {
        cardTypeArr = [cardTypeDic objectForKey:@"IDFS000322"];
        
        
        for (NSDictionary* dic in cardTypeArr) {
            if ([dic[@"dictvalue"] isEqualToString:self.customerContactModel.idsType]) {
                str=dic[@"dictname"];
            }
        }

        
//        //设置 idsType
//        if ([str isEqualToString:@""]) {
//            str=@"营业执照";
//        }
        for (NSDictionary* dic in cardTypeArr) {
            if ([dic[@"dictname"] isEqualToString:str]) {
                self.customerContactModel.idsType=dic[@"dictvalue"];
            }
        }
        
        
        
    }else{
        cardTypeArr = [cardTypeDic objectForKey:@"IDFS000210"];
        
        for (NSDictionary* dic in cardTypeArr) {
            if ([dic[@"dictvalue"] isEqualToString:self.customerContactModel.idsType]) {
                str=dic[@"dictname"];
            }
        }
        
        //设置 idsType
//        if ([str isEqualToString:@""]) {
//            str=@"身份证";
//        }
        for (NSDictionary* dic in cardTypeArr) {
            if ([dic[@"dictname"] isEqualToString:str]) {
                self.customerContactModel.idsType=dic[@"dictvalue"];
            }
        }
        
    }

    
    
    
    
    return str;
}


-(void)showIdcardView:(NSString*)str{
    
    self.progress = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    self.progress.detailsLabelText = str;
    self.progress.labelText = @"提示";
    self.progress.userInteractionEnabled = NO;
    self.progress.mode = MBProgressHUDModeText;
    [self.progress hide:YES afterDelay:2];
    
//    self.customerContactModel.idsType = _oldIdType;
//    self.customerContactModel.idsNumber = _oldIdNumer;
    
    
}

#pragma mark - getter and setter
- (NSMutableDictionary *)idsType {
    //    if (_idsType == nil) {
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *cardTypeDic = tempArr[0];
    //获取客户类型列表
    NSArray *cardTypeArr;
    if ([Tool isCustomerPersonTypeWithCustomerType:self.customerContactModel.customerType]) {
        cardTypeArr = [cardTypeDic objectForKey:@"IDFS000322"];
    }else{
        cardTypeArr = [cardTypeDic objectForKey:@"IDFS000210"];
    }
    //        NSArray *cardTypeArr = [cardTypeDic objectForKey:@"IDFS000210"];
    _idsType = [NSMutableDictionary dictionary];
    for (NSDictionary *tempDic in cardTypeArr) {
        NSString *cardType = [tempDic objectForKey:@"dictname"];
        NSString *cardTypeCode = [tempDic objectForKey:@"dictvalue"];
        [_idsType setObject:cardTypeCode forKey:cardType];
    }
    //    }
    return _idsType;
}
- (NSMutableArray *)idsTypesArr
{
    //    if (_idsTypesArr == nil) {
    NSArray *tempArr = [Tool unarcheiverWithfileName:DATALISTPATH];
    NSDictionary *cardTypeDic = tempArr[0];
    //获取客户类型列表
    NSArray *cardTypeArr;
    if ([Tool isCustomerPersonTypeWithCustomerType:self.customerContactModel.customerType]) {
        cardTypeArr = [cardTypeDic objectForKey:@"IDFS000322"];
    }else{
        cardTypeArr = [cardTypeDic objectForKey:@"IDFS000210"];
    }
    _idsTypesArr = [NSMutableArray array];
    for (NSDictionary *tempDic in cardTypeArr) {
        NSString *cardType = [tempDic objectForKey:@"dictname"];
        //            NSString *cardTypeCode = [tempDic objectForKey:@"dictvalue"];
        [_idsTypesArr addObject:cardType];
    }
    //    }
    return _idsTypesArr;
}
- (NSDictionary *)customerType {
    if (_customerType == nil) {
        _customerType = [Tool customerTypeDictionary];
    }
    return _customerType;
}
- (NSArray *)arrEnterprise{
    
    
    NSString* str=[self idsTypeToString];
    _arrEnterprise = @[
                       @{
                           @"title":@"企业联系人",
                           @"content":self.customerContactModel.customerLxr
                           },
                       @{
                           @"title":@"性别",
                           @"content":self.customerContactModel.customerSex
                           },
                       @{
                           @"title":@"证件类型",
                           //				  @"content":self.customerContactModel.idsType
                           @"content":str
                           },
                       @{
                           @"title":@"证件号",
                           @"content":self.customerContactModel.idsNumber
                           },
                       @{
                           @"title":@"联系电话",
                           @"content":self.customerContactModel.customerPhone
                           },
                       @{
                           @"title":@"客户类型",
                           @"content":@"企业客户"
                           },
                       //			  @{
                       //				  @"title":@"客户地址",
                       //				  @"content":self.customerContactModel.address
                       //				  },
                       @{
                           @"title":@"单位名称",
                           @"content":self.customerContactModel.customerName
                           }
                       ];
    
    return _arrEnterprise;
    
}
- (NSArray *)arrPersonal{
    
    NSString* str=[self idsTypeToString];
    
    _arrPersonal = @[
                     @{
                         @"title":@"客户名称",
                         @"content":self.customerContactModel.customerLxr
                         },
                     @{
                         @"title":@"性别",
                         @"content":self.customerContactModel.customerSex
                         },
                     @{
                         @"title":@"证件类型",
                         //				  @"content":self.customerContactModel.idsType
                         @"content":str
                         },
                     @{
                         @"title":@"证件号",
                         @"content":self.customerContactModel.idsNumber
                         },
                     @{
                         @"title":@"联系电话",
                         @"content":self.customerContactModel.customerPhone
                         },
                     @{
                         @"title":@"客户类型",
                         @"content":@"个人客户"
                         },
                     //			  @{
                     //				  @"title":@"客户地址",
                     //				  @"content":self.customerContactModel.address
                     //				  }
                     ];
    
    return _arrPersonal;
    
}
@end
