//
//  LSAddProgramDetailsView.m
//  YDJR
//
//  Created by 李爽 on 2016/10/13.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LSAddProgramDetailsView.h"
#import "LSFinancialProductsModel.h"
#import "LSFPDetailCollectionViewCell.h"
#import "LSFPDetailEasyCollectionViewCell.h"
#import "LSFPDetailHeaderCollectionReusableView.h"
#import "LSFPDetailFooterCollectionReusableView.h"
#import "LSTextField.h"
#import "LSFPDetailExtraCollectionViewCell.h"
#import "CTTXRequestServer+LetterofIntent.h"
#import "LSMaterialModel.h"
#import "LSFinancialProductsModel.h"
#import <YYModel.h>
#import "LSChoosedProductsModel.h"

#define CELL_ID      @"CELL_ID"
#define EASY_CELL_ID      @"EASY_CELL_ID"
#define EXTRA_CELL_ID      @"EXTRA_CELL_ID"

@interface LSAddProgramDetailsView ()<UITextFieldDelegate>
@property (nonatomic,strong)UIView *grayView;/** 灰色背景*/
@property (nonatomic,copy)NSArray *titleArray;
@property (nonatomic,copy)NSArray *headerTitleArray;
@property (nonatomic,copy)NSArray *footerTitleArray;
@property (nonatomic,copy)NSArray *subTitleArray;
@property (nonatomic,strong)LSFPDetailFooterCollectionReusableView *footerReusableView;
@property (nonatomic,copy)NSString *totalExpenditure;/** 表面总支出*/
@property (nonatomic,copy)NSString *costOfCar;/** 实际购车车本*/

@property (nonatomic,copy)NSMutableArray *contextArr;
@property (nonatomic,copy)NSMutableArray *materialModelArr;
@property (nonatomic,copy)NSMutableDictionary *dict;
@property (nonatomic,copy)NSString *rzgm;/** 融资规模*/
@property (nonatomic,copy)NSString *wk;/** 尾款*/
@property (nonatomic,copy)NSString *lx;/** 利息*/
@property (nonatomic,copy)NSString *sf;/** 首付*/
@property (nonatomic,copy)NSString *dkfwf;/** 贷款服务费*/
@property (nonatomic,copy)NSString *bmzzc;/** 表面总支出*/
@property (nonatomic,copy)NSString *ntzhbl;/** 年投资回报率*/
@property (nonatomic,copy)NSString *snzjly;/** 三年资金利用*/
@property (nonatomic,copy)NSString *ncpi;/** 年cpi*/
@property (nonatomic,copy)NSString *cjrl;/** 车价让利*/
@property (nonatomic,copy)NSString *tzhb;/** 投资回报*/
@property (nonatomic,copy)NSString *by;/** 保养*/
@property (nonatomic,copy)NSString *gskds;/** 公司可抵税*/
@property (nonatomic,copy)NSString *nbz;/** 年贬值*/
@property (nonatomic,copy)NSString *bzj;/** 保证金*/

@property (nonatomic,copy)NSString *yg;/** 月供*/
@property (nonatomic,copy)NSString *khsjgccb;/** 客户实际购车车本*/
@property (nonatomic,copy)NSString *khrhcsjzc;/** 客户若换车实际支出*/
@property (nonatomic,copy)NSString *cz;/** 残值*/

@property (nonatomic,copy)NSString *productDict;
@property (nonatomic,strong)HGBPromgressHud *phud;
@end
@implementation LSAddProgramDetailsView

- (instancetype)initWithFrame:(CGRect)frame andWithModel:(id)productsModel withPrice:(NSString *)price withProductDict:(NSString *)productDict
{
    self = [super initWithFrame:frame];
    if (self) {
        self.productsModel = productsModel;
        self.catModelDetailPrice = price;
        self.productDict = productDict;
        [self obtainDataFromNet];
    }
    return self;
}
/**
 从网络上获取数据
 */
-(void)obtainDataFromNet
{
    [self.phud showHUDSaveAddedTo:self];
    [[CTTXRequestServer shareInstance]checkMaterialWithDictitem:self.productDict WithType:100 SuccessBlock:^(NSMutableArray *materialModelArr) {
        [self.phud hideSave];
        self.materialModelArr = materialModelArr;
        for (LSMaterialModel *m in materialModelArr) {
            [self calculationWithDictName:m];
        }
        
        [self p_setupView];
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        self.phud.promptStr = @"网络状况不好...请稍后重试!";
        [self.phud showHUDResultAddedTo:self];
    }];
}

#pragma mark - p_setupView
- (void)p_setupView
{
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1408*wScale, 970*hScale)];
    grayView.backgroundColor = [UIColor hexString:@"#FFF0F1F5"];
    [self addSubview:grayView];
    
    UICollectionViewFlowLayout *layOut=[[UICollectionViewFlowLayout alloc]init];
    layOut.minimumLineSpacing = 0;
    layOut.minimumInteritemSpacing = 0;//UICollectionView横向cell间距，会出现多10
    layOut.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    layOut.headerReferenceSize = CGSizeMake(grayView.width, 112.0f *hScale);  //设置header大小
    layOut.footerReferenceSize = CGSizeMake(grayView.width, 152.0f *hScale);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, grayView.width, grayView.height) collectionViewLayout:layOut];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[LSFPDetailCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
    [self.collectionView registerClass:[LSFPDetailEasyCollectionViewCell class] forCellWithReuseIdentifier:EASY_CELL_ID];
    [self.collectionView registerClass:[LSFPDetailExtraCollectionViewCell class] forCellWithReuseIdentifier:EXTRA_CELL_ID];
    
    //注册header
    [self.collectionView registerClass:[LSFPDetailHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[LSFPDetailFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    self.collectionView.backgroundColor = [UIColor hexString:@"#FFFFFFFF"];
    //self.financialProgramView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    
    [grayView addSubview:self.collectionView];
    [self addSubview:grayView];
    self.grayView = grayView;
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([self.productsModel.productState isEqualToString:@"2"]) {
        return 1;
    }else{
        return 2;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  section == 1 ? 5 : 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 1 && indexPath.row == 0) ||(indexPath.section == 1 && indexPath.row == 3)||(indexPath.section == 1 && indexPath.row == 4) ) {
        if (indexPath.section == 1 && indexPath.row == 0) {
            LSFPDetailEasyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EASY_CELL_ID forIndexPath:indexPath];
            cell.moneyTitleLabel.text = self.titleArray[indexPath.section][indexPath.row];
            if (indexPath.row == 0) {
                //三年资金利用
                if (self.contextArr.count == 0) {
                    cell.moneyLabel.text = @"";
                }else{
                    cell.moneyLabel.text = [self.contextArr[11] cut];
                }
            }
            return cell;
        }else{
            LSFPDetailExtraCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EXTRA_CELL_ID forIndexPath:indexPath];
            cell.moneyTitleLabel.text = self.titleArray[indexPath.section][indexPath.row];
            cell.moneyTextField.tag = 3 + indexPath.row;
            cell.moneyTextField.delegate = self;
            switch (indexPath.row) {
                case 3:
                    //车价让利(元)
                    if (self.contextArr.count == 0) {
                        cell.moneyTextField.text = @"";
                    }else{
                        cell.moneyTextField.text = [self.contextArr[9] cut];
                    }
                    break;
                case 4:
                    //保养/精品赠送(元)
                    if (self.contextArr.count == 0) {
                        cell.moneyTextField.text = @"";
                    }else{
                        cell.moneyTextField.text = [self.contextArr[10] cut];
                    }
                    break;
                default:
                    break;
            }
            return cell;
        }
        }else{
        LSFPDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
        cell.conditionTilteLabel.text = self.titleArray[indexPath.section][indexPath.row];
        
        NSArray *titleContentArray = @[@[self.productsModel.paymentradio,self.productsModel.loanyear,self.productsModel.interestrate,self.productsModel.servicecharge],@[@"",self.productsModel.investret,self.productsModel.cpi,@"",@""]];
        
        cell.conditionTextField.text = titleContentArray[indexPath.section][indexPath.row];
        cell.conditionTextField.delegate = self;
        cell.moneyTitleLabel.text = self.subTitleArray[indexPath.section][indexPath.row];
        
        if (indexPath.section == 0) {
            cell.conditionTextField.tag = indexPath.row;
			if (indexPath.row == 2) {
				cell.conditionTextField.textColor = [UIColor hex:@"#FFFC5A5A"];
				cell.moneyLabel.textColor = [UIColor hex:@"#FFFC5A5A"];
			}else{
				cell.conditionTextField.textColor = [UIColor hexString:@"#FF333333"];
				cell.moneyLabel.textColor = [UIColor hexString:@"#FF333333"];
			}
            switch (indexPath.row) {
                case 0:
                    //首付
                    if (self.contextArr.count == 0) {
                        cell.moneyLabel.text = @"";
                    }else{
                        cell.moneyLabel.text = [self.contextArr[0] cut];
                    }
                    break;
                case 1:
                    //月供金额(元)
                    if (self.contextArr.count == 0) {
                        cell.moneyLabel.text = @"";
                    }else{
                        if ([self.productsModel.productState isEqualToString:@"2"]) {
                            cell.moneyLabel.text = [self.contextArr[1] cut];
                        }else{
                            cell.moneyLabel.text = [self.contextArr[6] cut];
                        }
                    }
                    break;
                case 2:
                    //利息
                    if (self.contextArr.count == 0) {
                        cell.moneyLabel.text = @"";
                    }else{
                        if ([self.productsModel.productState isEqualToString:@"2"]) {
                            cell.moneyLabel.text = [self.contextArr[3] cut];
                        }else{
                            cell.moneyLabel.text = [self.contextArr[5] cut];
                        }
                    }
                    break;
                case 3:
                    //手续费
                    if (self.contextArr.count == 0) {
                        cell.moneyLabel.text = @"";
                    }else{
                        if ([self.productsModel.productState isEqualToString:@"2"]) {
                            //cell.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[[self.contextArr[4] cut] floatValue]];
                            cell.moneyLabel.text = @"0";
                        }else{
                            //cell.moneyLabel.text = [NSString stringWithFormat:@"%.2f",[[self.contextArr[7] cut] floatValue]];
                            cell.moneyLabel.text = @"0";
                        }
                    }
                    break;
                default:
                    break;
            }
        } else {
            cell.conditionTextField.tag = 3 + indexPath.row;
            switch (indexPath.row) {
                case 1:
                    //年投资回报
                    if (self.contextArr.count == 0) {
                        cell.moneyLabel.text = @"";
                    }else{
                        cell.moneyLabel.text = [self.contextArr[13] cut];
                    }
                    break;
                case 2:
                    //年贬值
                    if (self.contextArr.count == 0) {
                        cell.moneyLabel.text = @"";
                    }else{
                        cell.moneyLabel.text = [self.contextArr[15] cut];
                    }
                    break;
                    
                default:
                    break;
            }
        }
        //表面总支出
        if ([self.productsModel.productState isEqualToString:@"2"]) {
            if (self.contextArr.count == 0) {
                self.totalExpenditure = @"";
            }else{
                self.totalExpenditure = self.contextArr[2];
            }
        }else{
            if (self.contextArr.count == 0) {
                self.totalExpenditure = @"";
            }else{
                self.totalExpenditure = self.contextArr[8];
            }
        }
        //实际购车车本
        if (![self.productsModel.productState isEqualToString:@"2"]) {
            if (self.contextArr.count == 0) {
                self.costOfCar = @"";
            }else{
                self.costOfCar = self.contextArr[17];
            }

        }else{
            self.costOfCar = @"";
        }
            return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.grayView.width/4,280*hScale);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSArray *valueArray = @[[self.totalExpenditure cut],[self.costOfCar cut]];
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        LSFPDetailHeaderCollectionReusableView *reusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        reusableView.headerTitleLabel.text = self.headerTitleArray[indexPath.section];
        return reusableView;
    }else{
        LSFPDetailFooterCollectionReusableView *footerReusableView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footerReusableView.footerTitleLabel.text = self.footerTitleArray[indexPath.section];
        footerReusableView.footerValueLabel.text = valueArray[indexPath.section];
        return footerReusableView;
    }
}

#pragma mark - textField delegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0) {
        self.productsModel.paymentradio = textField.text;
    }
    if (textField.tag == 1) {
        self.productsModel.loanyear = textField.text;
    }
    if (textField.tag == 2) {
        self.productsModel.interestrate = textField.text;
    }
    if (textField.tag == 3) {
        self.productsModel.servicecharge = textField.text;
    }
    if (textField.tag == 4) {
        self.productsModel.investret = textField.text;
    }
    if (textField.tag == 5) {
        self.productsModel.cpi = textField.text;
    }
    if (textField.tag == 6) {
        self.productsModel.carlet = textField.text;
    }
    if (textField.tag == 7) {
        self.productsModel.cargive = textField.text;
    }
    [self.contextArr removeAllObjects];
    for (LSMaterialModel *m in self.materialModelArr) {
        [self calculationWithDictName:m];
    }
    [self.collectionView reloadData];
}

-(void)calculationWithDictName:(LSMaterialModel *)m
{
    if ([m.dictvalue isEqualToString:@"sf"]) {
        NSString *sf = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"首付%@",sf);
        self.sf = sf;
        [self.contextArr addObject:sf];
    }
    if ([m.dictvalue isEqualToString:@"bzj"]) {
        NSString *bzj = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"保证金%@",bzj);
        self.bzj = bzj;
        [self.contextArr addObject:bzj];
    }
    if ([m.dictvalue isEqualToString:@"rzgm"]) {
        NSString *rzgm = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"融资规模%@",rzgm);
        self.rzgm = rzgm;
        [self.contextArr addObject:rzgm];
    }
    if ([m.dictvalue isEqualToString:@"wk"]) {
        NSString *wk = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"尾款%@",wk);
        self.wk = wk;
        [self.contextArr addObject:wk];
    }
    if ([m.dictvalue isEqualToString:@"ll"]) {
        NSString *ll = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"利率%@",ll);
        [self.contextArr addObject:ll];
    }
    if ([m.dictvalue isEqualToString:@"lx"]) {
        NSString *lx = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"利息%@",lx);
        self.lx = lx;
        [self.contextArr addObject:lx];
    }
    if ([m.dictvalue isEqualToString:@"yg"]) {
        NSString *yg = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"月供%@",yg);
        self.yg = yg;
        [self.contextArr addObject:yg];
    }
    if ([m.dictvalue isEqualToString:@"dkfwf"]) {
        NSString *dkfwf = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"贷款服务费%@",dkfwf);
        self.dkfwf = dkfwf;
        [self.contextArr addObject:dkfwf];
    }
    if ([m.dictvalue isEqualToString:@"bmzzc"]) {
        NSString *bmzzc = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"表面总支出%@",bmzzc);
        self.bmzzc = bmzzc;
        [self.contextArr addObject:bmzzc];
    }
    
    if ([m.dictvalue isEqualToString:@"cjrl"]) {
        NSString *cjrl = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"车价让利%@",cjrl);
        self.cjrl = cjrl;
        [self.contextArr addObject:cjrl];
    }
    if ([m.dictvalue isEqualToString:@"by"]) {
        NSString *by = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"保养精品赠送%@",by);
        self.by = by;
        [self.contextArr addObject:by];
    }
    if ([m.dictvalue isEqualToString:@"snzjly"]) {
        NSString *snzjly = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"三年资金利用%@",snzjly);
        [self.contextArr addObject:snzjly];
        self.snzjly = snzjly;
    }
    if ([m.dictvalue isEqualToString:@"ntzhbl"]) {
        NSString *ntzhbl = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"年投资回报率%@",ntzhbl);
        self.ntzhbl = ntzhbl;
        [self.contextArr addObject:ntzhbl];
    }
    if ([m.dictvalue isEqualToString:@"tzhb"]) {
        NSString *tzhb = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"投资回报%@",tzhb);
        self.tzhb = tzhb;
        [self.contextArr addObject:tzhb];
    }
    if ([m.dictvalue isEqualToString:@"ncpi"]) {
        NSString *ncpi = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"年cpi%@",ncpi);
        self.ncpi = ncpi;
        [self.contextArr addObject:ncpi];
    }
    if ([m.dictvalue isEqualToString:@"nbz"]) {
        NSString *nbz = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"年贬值%@",nbz);//snzjly,*,ncpi,*,loanyear,/,12
        self.nbz = nbz;
        [self.contextArr addObject:nbz];
    }
    if ([m.dictvalue isEqualToString:@"gskds"]) {
        NSString *gskds = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"公司可抵税%@",gskds);
        self.gskds = gskds;
        [self.contextArr addObject:gskds];
    }
    if ([m.dictvalue isEqualToString:@"khsjgccb"]) {
        NSString *khsjgccb = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"客户实际购车车本%@",khsjgccb);
        self.khsjgccb = khsjgccb;
        [self.contextArr addObject:khsjgccb];
    }
    if ([m.dictvalue isEqualToString:@"cz"]) {
        NSString *cz = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"残值%@",cz);
        self.cz = cz;
        [self.contextArr addObject:cz];
    }
    if ([m.dictvalue isEqualToString:@"khrhcsjzc"]) {
        NSString *khrhcsjzc = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"客户若换车实际支出%@",khrhcsjzc);
        self.khrhcsjzc = khrhcsjzc;
        [self.contextArr addObject:khrhcsjzc];
    }
    if ([m.dictvalue isEqualToString:@"czl"]) {
        NSString *czl = [self calculationWithAlgorithm:m.dictname];
        //NSLog(@"残值率%@",czl);
        [self.contextArr addObject:czl];
    }
}

-(NSString *)calculationWithAlgorithm:(NSString *)algorithm
{
    NSMutableDictionary *dict = [self.productsModel yy_modelToJSONObject];
    //B1
    [dict setValue:self.catModelDetailPrice forKey:@"catModelDetailPrice"];
    //7
    [dict setValue:self.sf forKey:@"sf"];
    //9
    [dict setValue:self.rzgm forKey:@"rzgm"];
    //10
    [dict setValue:self.wk forKey:@"wk"];
    //12
    [dict setValue:self.lx forKey:@"lx"];
    //14
    [dict setValue:self.dkfwf forKey:@"dkfwf"];
    //15
    [dict setValue:self.bmzzc forKey:@"bmzzc"];
    //16
    [dict setValue:self.cjrl forKey:@"cjrl"];
    //17
    [dict setValue:self.by forKey:@"by"];
    //18
    [dict setValue:self.snzjly forKey:@"snzjly"];
    //19
    [dict setValue:self.ntzhbl forKey:@"ntzhbl"];
    //20
    [dict setValue:self.tzhb forKey:@"tzhb"];
    //21
    [dict setValue:self.ncpi forKey:@"ncpi"];
    //22
    [dict setValue:self.nbz forKey:@"nbz"];
    //23
    [dict setValue:self.gskds forKey:@"gskds"];
    
    [dict setValue:self.bzj forKey:@"bzj"];
    
    //月供
    [dict setValue:self.yg forKey:@"yg"];
    //
    [dict setValue:self.khsjgccb forKey:@"khsjgccb"];
    //
    [dict setValue:self.khrhcsjzc forKey:@"khrhcsjzc"];
    //残值
    [dict setValue:self.cz forKey:@"cz"];
    self.dict = dict;
    
    NSArray *transferArr=[algorithm componentsSeparatedByString:@","];
    NSString *newAlgorithmstr=@"";
    for(NSString *tempStr in transferArr){
        if ([tempStr isEqualToString:@"0"]) {
            newAlgorithmstr = tempStr;
        }else{
            NSString *s=[dict objectForKey:tempStr];
            if ([tempStr isEqualToString:@"paymentradio"]||[tempStr isEqualToString:@"marginradio"]||[tempStr isEqualToString:@"interestrate"]||[tempStr isEqualToString:@"investret"]||[tempStr isEqualToString:@"cpi"]||[tempStr isEqualToString:@"residualrate"]||[tempStr isEqualToString:@"servicecharge"]) {
                s = [NSString stringWithFormat:@"%.4f",[s floatValue]/100];
            }
            if(s!=nil&&s.length!=0){
                newAlgorithmstr=[newAlgorithmstr stringByAppendingFormat:@"%@",s];
            }
            else{
                newAlgorithmstr=[newAlgorithmstr stringByAppendingFormat:@"%@",tempStr];
            }
        }
    }
    NSLog(@"gsh=%@",newAlgorithmstr);
    NSString *str= [[[UIWebView alloc]init]stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"eval(%@)",newAlgorithmstr]];
    self.choosedProductsModel = [LSChoosedProductsModel yy_modelWithDictionary:self.dict];
    self.choosedProductsModel.productState = self.productsModel.productState;
    self.choosedProductsModel.intentID = self.productDict;
    self.choosedProductsModel.mechanismID = self.productsModel.mechanismID;
    self.choosedProductsModel.productCode = self.productsModel.productCode;
    self.choosedProductsModel.dataDictP = self.productsModel.dataDictP;
    self.choosedProductsModel.dataDictQ = self.productsModel.dataDictQ;
    self.choosedProductsModel.inputPrice = self.catModelDetailPrice;
	if ([str floatValue] < 1) {
		return str;
	}else{
		return [str cutOutStringContainsDot];
	}
}

#pragma mark - lazy load
-(NSArray *)headerTitleArray
{
	if (!_headerTitleArray) {
		_headerTitleArray = @[@"金融方案详情",@"金融优惠政策"];
	}
	return _headerTitleArray;
}

-(NSArray *)titleArray
{
	if (!_titleArray) {
		_titleArray = @[@[@"首付比例(%)",@"贷款期限(期)",@"产品执行利率(%)",@"手续费(%)"],@[@"三年资金利用",@"年投资回报率(%)",@"年CPI(%)",@"车价让利(元)",@"保养/精品赠送(元)"]];
	}
	return _titleArray;
}

-(NSArray *)subTitleArray
{
	if (!_subTitleArray) {
		_subTitleArray = @[@[@"首付款(元)",@"月供金额(元)",@"利息",@"贷款手续费"],@[@"",@"投资回报(元)",@"年贬值(元)",@"",@""]];
	}
	return _subTitleArray;
}

-(NSArray *)footerTitleArray
{
	if (!_footerTitleArray) {
		if ([self.productsModel.productState isEqualToString:@"2"]) {
			_footerTitleArray = @[@"实际购车成本(元)",@""];
		}else{
			_footerTitleArray = @[@"表面总支出(元)",@"实际购车成本(元)"];
		}
	}
	return _footerTitleArray;
}

-(NSMutableArray *)contextArr
{
	if (!_contextArr) {
		_contextArr = [NSMutableArray array];
	}
	return _contextArr;
}

-(HGBPromgressHud *)phud
{
	if(_phud==nil){
		_phud=[[HGBPromgressHud alloc]init];
	}
	return _phud;
}

@end
