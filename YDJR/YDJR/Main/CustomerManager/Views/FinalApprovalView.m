//
//  FinalApprovalView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/3/23.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "FinalApprovalView.h"
#import "LLFFinalApprovalModel.h"
#import "UIView+MakeImage.h"
#import "LLFPrintPageRenderer.h"
@interface FinalApprovalView ()<UIPrintInteractionControllerDelegate>
/**
 终审批文信息
 */
@property (nonatomic,strong)LLFFinalApprovalModel *finalApprovalModel;
@property (nonatomic,strong)HGBPromgressHud *phud;
@property (nonatomic,strong) UIView *topBgView;
@property (nonatomic,assign)BOOL benchOrNo;
@end

@implementation FinalApprovalView

- (instancetype)initWithFrame:(CGRect)frame finalApprovalModel:(LLFFinalApprovalModel *)finalApprovalModel from:(BOOL)benchOrNo
{
    self = [super initWithFrame:frame];
    if (self) {
        self.finalApprovalModel = finalApprovalModel;
        self.benchOrNo = benchOrNo;
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    self.backgroundColor = [UIColor hex:@"#FFF2F3F7"];
    //顶部栏
    UIView *topback = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 96 * hScale)];
   topback.backgroundColor = [UIColor hex:@"#ffffff"];
    [self addSubview:topback];
    UIView *topBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 96 * hScale)];
    topBgView.backgroundColor = [UIColor hex:@"#ffffff"];
    [self addSubview:topBgView];
    self.topBgView =topBgView;
    
    //返回按钮
    UIImageView *iconBackImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_back"]];
    iconBackImageView.frame = CGRectMake(32 * wScale, 36 * hScale, 25 * wScale, 25 * hScale);
    iconBackImageView.userInteractionEnabled = YES;
    [topBgView addSubview:iconBackImageView];
    
    UILabel *backLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(iconBackImageView.frame), 32 * hScale, 70 * wScale, 32 * hScale)];
    backLabel.text = @"返回";
    backLabel.textColor = [UIColor hex:@"#FF274A72"];
    backLabel.font = [UIFont systemFontOfSize:16.0];
    backLabel.textAlignment = NSTextAlignmentLeft;
    [topBgView addSubview:backLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, CGRectGetMaxX(backLabel.frame), CGRectGetHeight(topBgView.frame));
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [topBgView addSubview:backButton];
    
    UILabel *topTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(topBgView.frame) - 200 * wScale) / 2, 0, 200 * wScale, CGRectGetHeight(topBgView.frame))];
    topTitleLabel.text = @"审批完成";
    topTitleLabel.textColor = [UIColor hex:@"#FF333333"];
    topTitleLabel.font = [UIFont systemFontOfSize:18.0];
    topTitleLabel.textAlignment = NSTextAlignmentCenter;
    [topBgView addSubview:topTitleLabel];
    
    //打印终审批复单
    UIButton *printButton = [UIButton buttonWithType:UIButtonTypeCustom];
    printButton.frame = CGRectMake(CGRectGetWidth(topBgView.frame) - 73 * wScale, 28 * hScale, 44 * wScale, 40 * hScale);
    [printButton setBackgroundImage:[UIImage imageNamed:@"LLF_customerManager_Print"] forState:(UIControlStateNormal)];
    [printButton addTarget:self action:@selector(printButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [topBgView addSubview:printButton];
    
    /*
     ***************************内容顶部***************************************
     */
    UIView *contentBGView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topBgView.frame) + 24 * hScale, CGRectGetWidth(topBgView.frame), 1288 * hScale)];
    contentBGView.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
    [self addSubview:contentBGView];
    
    UILabel *contentTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60 * hScale, CGRectGetWidth(contentBGView.frame), 34 * hScale)];
    contentTitleLabel.text = @"上海永达融资租赁审批通知书";
    contentTitleLabel.textColor = [UIColor hex:@"#FF333333"];
    contentTitleLabel.font = [UIFont systemFontOfSize:15.0];
    contentTitleLabel.textAlignment = NSTextAlignmentCenter;
    [contentBGView addSubview:contentTitleLabel];
    
    UIView *oneLineView = [[UIView alloc]initWithFrame:CGRectMake(24 * wScale, CGRectGetMaxY(contentTitleLabel.frame) + 50 * hScale, 1422 * wScale, 1 * hScale)];
    oneLineView.backgroundColor = [UIColor hex:@"#FFDDDDDD"];
    [contentBGView addSubview:oneLineView];
    
    /*
     ************************最左列***************************************
     */
    for (int i = 0; i < 4; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 52 * hScale + i * 64 * hScale + CGRectGetMaxY(oneLineView.frame), 228 * wScale, 30 * hScale)];
        titleLabel.text = [[self leftTitleArr] objectAtIndex:i];
        titleLabel.textColor = [UIColor hex:@"#FF999999"];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.textAlignment = NSTextAlignmentRight;
        [contentBGView addSubview:titleLabel];
        
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 50 * hScale + i * 64 * hScale + CGRectGetMaxY(oneLineView.frame), 238 * wScale, 34 * hScale)];
        contentLabel.text = [[self leftContentArr] objectAtIndex:i];
        contentLabel.textColor = [UIColor hex:@"#FF333333"];
        contentLabel.font = [UIFont systemFontOfSize:14.0];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        [contentBGView addSubview:contentLabel];
    }
    
    /*
     ************************中列***************************************
     */
    for (int i = 0; i < 4; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(466 * wScale, 52 * hScale + i * 64 * hScale + CGRectGetMaxY(oneLineView.frame), 182 * wScale, 30 * hScale)];
        titleLabel.text = [[self midTitleArr] objectAtIndex:i];
        titleLabel.textColor = [UIColor hex:@"#FF999999"];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.textAlignment = NSTextAlignmentRight;
        [contentBGView addSubview:titleLabel];
        
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 50 * hScale + i * 64 * hScale + CGRectGetMaxY(oneLineView.frame), 222 * wScale, 34 * hScale)];
        contentLabel.text = [[self midContentArr] objectAtIndex:i];
        contentLabel.textColor = [UIColor hex:@"#FF333333"];
        contentLabel.font = [UIFont systemFontOfSize:14.0];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        [contentBGView addSubview:contentLabel];
    }
    
    /*
     ************************右列***************************************
     */
    for (int i = 0; i < 4; i++) {
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(870 * wScale, 52 * hScale + i * 64 * hScale + CGRectGetMaxY(oneLineView.frame), 238 * wScale, 30 * hScale)];
        titleLabel.text = [[self rightTitleArr] objectAtIndex:i];
        titleLabel.textColor = [UIColor hex:@"#FF999999"];
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        titleLabel.textAlignment = NSTextAlignmentRight;
        [contentBGView addSubview:titleLabel];
        
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 50 * hScale + i * 64 * hScale + CGRectGetMaxY(oneLineView.frame), 362 * wScale, 34 * hScale)];
        contentLabel.text = [[self rightContentArr] objectAtIndex:i];
        contentLabel.textColor = [UIColor hex:@"#FF333333"];
        contentLabel.font = [UIFont systemFontOfSize:14.0];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        [contentBGView addSubview:contentLabel];
    }
    
    /*
     ***************************内容底部***************************************
     */
    UIView *twoLineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(oneLineView.frame), CGRectGetMaxY(oneLineView.frame) + 326 * hScale, CGRectGetWidth(oneLineView.frame), CGRectGetHeight(oneLineView.frame))];
    twoLineView.backgroundColor = [UIColor hex:@"#FFDDDDDD"];
    [contentBGView addSubview:twoLineView];
    
    /*
     ***************************批复意见***************************************
     */
    UILabel *replyOpinionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 52 * hScale + CGRectGetMaxY(twoLineView.frame), 228 * wScale, 30 * hScale)];
    replyOpinionTitleLabel.text = @"批复意见：";
    replyOpinionTitleLabel.textColor = [UIColor hex:@"#FF999999"];
    replyOpinionTitleLabel.font = [UIFont systemFontOfSize:14.0];
    replyOpinionTitleLabel.textAlignment = NSTextAlignmentRight;
    [contentBGView addSubview:replyOpinionTitleLabel];
    
    UILabel *replyOpinionContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(replyOpinionTitleLabel.frame), 50 * hScale + CGRectGetMaxY(twoLineView.frame), CGRectGetWidth(contentBGView.frame) - CGRectGetMaxX(replyOpinionTitleLabel.frame), 34 * hScale)];
    replyOpinionContentLabel.text = self.finalApprovalModel.phaseActionType;
    replyOpinionContentLabel.textColor = [UIColor hex:@"#FF333333"];
    replyOpinionContentLabel.font = [UIFont systemFontOfSize:14.0];
    replyOpinionContentLabel.textAlignment = NSTextAlignmentLeft;
    [contentBGView addSubview:replyOpinionContentLabel];
    
    /*
     ***************************批复方案***************************************
     */
    UILabel *opinionDescriptionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(replyOpinionTitleLabel.frame), 34 * hScale + CGRectGetMaxY(replyOpinionTitleLabel.frame), CGRectGetWidth(replyOpinionTitleLabel.frame), 30 * hScale)];
    opinionDescriptionTitleLabel.text = @"批复方案：";
    opinionDescriptionTitleLabel.textColor = [UIColor hex:@"#FF999999"];
    opinionDescriptionTitleLabel.font = [UIFont systemFontOfSize:14.0];
    opinionDescriptionTitleLabel.textAlignment = NSTextAlignmentRight;
    [contentBGView addSubview:opinionDescriptionTitleLabel];
    
    UILabel *opinionDescriptionContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(opinionDescriptionTitleLabel.frame), CGRectGetMinY(opinionDescriptionTitleLabel.frame), CGRectGetWidth(contentBGView.frame) - CGRectGetMaxX(opinionDescriptionTitleLabel.frame), CGRectGetHeight(opinionDescriptionTitleLabel.frame))];
//    opinionDescriptionContentLabel.backgroundColor = [UIColor redColor];
//    self.finalApprovalModel.phaseOpinion = @"我我我";
    opinionDescriptionContentLabel.text = self.finalApprovalModel.phaseOpinion;
//    opinionDescriptionContentLabel.text = @"我我我";
    opinionDescriptionContentLabel.textColor = [UIColor hex:@"#FF333333"];
    opinionDescriptionContentLabel.font = [UIFont systemFontOfSize:14.0];
    opinionDescriptionContentLabel.textAlignment = NSTextAlignmentLeft;
    opinionDescriptionContentLabel.numberOfLines = 0;
    if (self.finalApprovalModel.phaseOpinion.length > 0) {
        [opinionDescriptionContentLabel sizeToFit];
    }
    
    [contentBGView addSubview:opinionDescriptionContentLabel];
    
    /*
     ***************************签约落实条件***************************************
     */
    UILabel *loanTermsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(opinionDescriptionTitleLabel.frame), 40 * hScale + CGRectGetMaxY(opinionDescriptionContentLabel.frame), CGRectGetWidth(opinionDescriptionTitleLabel.frame), 30 * hScale)];
    loanTermsTitleLabel.text = @"签约落实条件：";
    loanTermsTitleLabel.textColor = [UIColor hex:@"#FF999999"];
    loanTermsTitleLabel.font = [UIFont systemFontOfSize:14.0];
    loanTermsTitleLabel.textAlignment = NSTextAlignmentRight;
    [contentBGView addSubview:loanTermsTitleLabel];
    
    UILabel *loanTermsContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(loanTermsTitleLabel.frame), CGRectGetMinY(loanTermsTitleLabel.frame), CGRectGetWidth(contentBGView.frame) - CGRectGetMaxX(loanTermsTitleLabel.frame), 0)];
    loanTermsContentLabel.text = [NSString stringWithFormat:@"相关法律文本须经上海永达融资租赁法律部门审定。%@",self.finalApprovalModel.putoutClause];
    loanTermsContentLabel.textColor = [UIColor hex:@"#FF333333"];
    loanTermsContentLabel.font = [UIFont systemFontOfSize:14.0];
    loanTermsContentLabel.textAlignment = NSTextAlignmentLeft;
    [loanTermsContentLabel sizeToFit];
    [contentBGView addSubview:loanTermsContentLabel];
    
//    UILabel *twoLoanTermsContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(loanTermsContentLabel.frame), 16 * hScale + CGRectGetMaxY(loanTermsContentLabel.frame), CGRectGetWidth(contentBGView.frame) - CGRectGetMaxX(loanTermsTitleLabel.frame), 50 * hScale)];
//    twoLoanTermsContentLabel.text = @"2.相关法律文本须经上海永达融资租赁法律部门审定。";
//    twoLoanTermsContentLabel.textColor = [UIColor hex:@"#FF333333"];
//    twoLoanTermsContentLabel.font = [UIFont systemFontOfSize:14.0];
//    twoLoanTermsContentLabel.textAlignment = NSTextAlignmentLeft;
//    [contentBGView addSubview:twoLoanTermsContentLabel];
    
    /*
     **********************上海永达融资租赁有限公司********************************
     */
    
    UILabel *qiyeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(contentBGView.frame) - 96 * wScale - 376 * wScale, CGRectGetHeight(contentBGView.frame) - 257 * hScale, 376 * wScale, 34 * hScale)];
    qiyeLabel.text = @"上海永达融资租赁有限公司";
    qiyeLabel.textColor = [UIColor hex:@"#FF333333"];
    qiyeLabel.font = [UIFont systemFontOfSize:14.0];
    qiyeLabel.textAlignment = NSTextAlignmentRight;
    [contentBGView addSubview:qiyeLabel];
    
    /*
     **********************时间********************************
     */
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(contentBGView.frame) - 96 * wScale - 376 * wScale, CGRectGetMaxY(qiyeLabel.frame) + 30 * hScale, 376 * wScale, 34 * hScale)];
    timeLabel.text = self.finalApprovalModel.approveDate;
    timeLabel.textColor = [UIColor hex:@"#FF333333"];
    timeLabel.font = [UIFont systemFontOfSize:14.0];
    timeLabel.textAlignment = NSTextAlignmentRight;
    [contentBGView addSubview:timeLabel];
}
#pragma mark 点击按钮响应事件
//返回响应事件
- (void)backButtonAction:(UIButton *)sender
{
    CGRect frame = self.frame;
    frame.origin.x = frame.size.width;
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}
//打印终审批复单
- (void)printButtonAction:(UIButton *)sender
{
   
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择打印方式!" preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"存储到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         self.topBgView.hidden = YES;
         self.backgroundColor = [UIColor hex:@"#ffffff"];
        [weakSelf saveApplyInfoToLocal];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"直接打印" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         self.backgroundColor = [UIColor hex:@"#ffffff"];
         self.topBgView.hidden = YES;
        [weakSelf print];
    }];
    
    [alertVc addAction:confirmAction];
    [alertVc addAction:cancelAction];
    
    [[UIViewController currentViewController] presentViewController:alertVc animated:YES completion:nil];
}
- (void)saveApplyInfoToLocal
{
    UIImage *pageImage = [self makeImagewithSize:self.frame.size];
    NSData *imageData = UIImagePNGRepresentation(pageImage);
    NSString *filePath = [NSString stringWithFormat:@"%@123.png",NSTemporaryDirectory()];
    //Save PDF to directory for usage
    if (imageData) {
        [imageData writeToFile:filePath atomically: YES];
    }
    else
    {
        NSLog(@"PDF couldnot be created");
    }
    UIImageWriteToSavedPhotosAlbum(pageImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    self.topBgView.hidden = NO;
     self.backgroundColor = [UIColor hex:@"#FFF2F3F7"];

    
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败";
    }else{
        msg = @"保存图片成功";
    }
    self.phud.promptStr = msg;
    [self.phud showHUDResultAddedTo:self];
}
- (void)print
{
    
    UIPrintInteractionController *printC = [UIPrintInteractionController sharedPrintController];//显示出打印的用户界面。
    printC.delegate = self;
    NSString *fileName = @"apply";
    //    [self.webView PDFDataWithFileName:fileName];
    //    NSString *filePath = [LLFPDFManager pdfDestPath:fileName];
    NSString *filePath = [NSString stringWithFormat:@"%@tmp.pdf",NSTemporaryDirectory()];
    
    //    filePath = [NSString stringWithFormat:@"file:///%@",filePath];
    NSLog(@"printAction_______%@",filePath);
    
    //    NSURL *fileUrl = [NSURL URLWithString:filePath];
    
//    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    
        UIImage *img = [self makeImagewithSize:self.frame.size];
        NSData *data = [NSData dataWithData:UIImagePNGRepresentation(img)];
//    NSData *data = [self makeImage];
    if (printC && [UIPrintInteractionController canPrintData:data]) {
        
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];//准备打印信息以预设值初始化的对象。
        //        printInfo.duplex = UIPrintInfoDuplexNone;
        printInfo.outputType = UIPrintInfoOutputGrayscale;//设置输出类型。
        printC.showsPageRange = YES;//显示的页面范围
        printInfo.orientation = UIPrintInfoOrientationPortrait;
        printInfo.jobName = fileName;
        
        printC.printInfo = printInfo;
        printC.showsPaperSelectionForLoadedPapers = YES;
        //        UIViewPrintFormatter *viewFormatter = [self.webView viewPrintFormatter];
        //        viewFormatter.startPage = 0;
        //        printC.printFormatter = viewFormatter;
//        printC.printingItem = fileUrl;
        //        NSLog(@"printinfo-%@",printC.printInfo);
                printC.printingItem = data;//single NSData, NSURL, UIImage, ALAsset
        //        NSLog(@"printingitem-%@",printC);
        
        
        //    等待完成
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
        ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
            if (!completed && error) {
                NSLog(@"可能无法完成，因为印刷错误: %@", error);
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"打印失败!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }else if(!completed){
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"打印取消" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
                 self.topBgView.hidden = NO;
                 self.backgroundColor = [UIColor hex:@"#FFF2F3F7"];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"打印成功!" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                [alert show];
            }
        };
        
        //                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //
        //                    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:sender];//调用方法的时候，要注意参数的类型－下面presentFromBarButtonItem:的参数类型是 UIBarButtonItem..如果你是在系统的UIToolbar or UINavigationItem上放的一个打印button，就不需要转换了。
        //                    [printC presentFromBarButtonItem:item animated:YES completionHandler:completionHandler];//在ipad上弹出打印那个页面
        //        //            [printC presentAnimated:YES completionHandler:completionHandler];//在iPhone上弹出打印那个页面
        //
        //
        //                } else {
        [printC presentAnimated:YES completionHandler:completionHandler];//在iPhone上弹出打印那个页面
        self.topBgView.hidden = NO;
          self.backgroundColor = [UIColor hex:@"#FFF2F3F7"];

        //                }
        
        
    }
}
#pragma mark 返回页面数据
//最左列title内容
- (NSArray *)leftTitleArr
{
    return [NSArray arrayWithObjects:@"申请编号：",@"车辆品牌：",@"项目总额：",@"保证金比例：", nil];
}
//最左列content内容
- (NSArray *)leftContentArr
{
    return [NSArray arrayWithObjects:self.finalApprovalModel.contractSerialNo,self.finalApprovalModel.carBrand,self.finalApprovalModel.projectSum,self.finalApprovalModel.bZJPercent, nil];
}
//中列title内容
- (NSArray *)midTitleArr
{
    return [NSArray arrayWithObjects:@"承租人/企业：",@"车辆型号：",@"融资金额：",@"首付比例：", nil];}
//中列content内容
- (NSArray *)midContentArr
{
    return [NSArray arrayWithObjects:self.finalApprovalModel.customerName,self.finalApprovalModel.carModel,self.finalApprovalModel.businessSum,self.finalApprovalModel.fPPercent, nil];
}
//右列title内容
- (NSArray *)rightTitleArr
{
    return [NSArray arrayWithObjects:@"联合承租企业：",@"融资范围：",@"融资期限：",@"担保人：", nil];
}
//右列content内容
- (NSArray *)rightContentArr
{
    return [NSArray arrayWithObjects:self.finalApprovalModel.jointCustomer,self.finalApprovalModel.includeAmountType,self.finalApprovalModel.businessTerm,self.finalApprovalModel.guaranters, nil];
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}
@end
