//
//  PreviewContractPopView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/4/28.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "PreviewContractPopView.h"
#import "CTTXRequestServer+uploadContract.h"
//#import <WebKit/WebKit.h>
#import <QuickLook/QuickLook.h>
@interface PreviewContractPopView ()<QLPreviewControllerDataSource,QLPreviewControllerDelegate>
/**
 背景图层
 */
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *wihtBgView;
@property (nonatomic,strong)HGBPromgressHud *phud;

/**
 订单号
 */
@property (nonatomic,copy)NSString *businessID;

/**
 影像代码
 */
@property (nonatomic,copy)NSString *typeNo;

/**
 操作类型
 */
@property (nonatomic,copy)NSString *operationType;

@property (nonatomic,copy)NSString *imageName;
@property (nonatomic,copy)NSURL *fileUrl;
@end

@implementation PreviewContractPopView

- (instancetype)initWithFrame:(CGRect)frame businessID:(NSString *)businessID typeNo:(NSString *)typeNo operationType:(NSString *)operationType imageName:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor hexString:@"#4D000000"];
        self.businessID = businessID;
        //        self.businessID = @"14938010765099800";
        self.typeNo = typeNo;
        self.operationType = operationType;
        self.imageName = imageName;
        //        self.imageName = @"DFQOL201700408-1.pdf";
        
        [self p_setupView];
    }
    return self;
}
- (void)p_setupView
{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(414 * wScale, 82 * hScale, 1220 * wScale, 1372 * hScale)];
    self.bgView.backgroundColor = [UIColor hex:@"#4DFFFFFF"];
    [self addSubview:self.bgView];
    
    self.wihtBgView = [[UIView alloc]initWithFrame:CGRectMake(10 * hScale, 10 * hScale, CGRectGetWidth(self.bgView.frame) - 20 * wScale, CGRectGetHeight(self.bgView.frame) - 20 * hScale)];
    self.wihtBgView.backgroundColor = [UIColor hex:@"#FFF3F3F3"];
    [self.bgView addSubview:self.wihtBgView];
    
    UIView *topBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.wihtBgView.frame), 95 * hScale)];
    topBgView.backgroundColor = [UIColor hex:@"#FFFFFFFF"];
    [self.wihtBgView addSubview:topBgView];
    
    UIButton *closeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    closeButton.frame = CGRectMake(0, 0, 100 * wScale, CGRectGetHeight(topBgView.frame));
    [closeButton setTitle:@"关闭" forState:(UIControlStateNormal)];
    [closeButton setTitleColor:[UIColor hex:@"#FF666666"]];
    closeButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [closeButton addTarget:self action:@selector(hideView) forControlEvents:(UIControlEventTouchUpInside)];
    [topBgView addSubview:closeButton];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(closeButton.frame), 0, CGRectGetWidth(topBgView.frame) - CGRectGetWidth(closeButton.frame) * 2, CGRectGetHeight(topBgView.frame))];
    topLabel.text = @"预览";
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor hex:@"#FF333333"];
    topLabel.font = [UIFont systemFontOfSize:17.0];
    [topBgView addSubview:topLabel];
    
    UIButton *uploadButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    uploadButton.frame = CGRectMake(CGRectGetWidth(topBgView.frame) - 100 * wScale, 0, 100 * wScale, CGRectGetHeight(topBgView.frame));
    [uploadButton setTitle:@"上传" forState:(UIControlStateNormal)];
    [uploadButton setTitleColor:[UIColor hex:@"#FF333333"]];
    uploadButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [uploadButton addTarget:self action:@selector(uploadButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [topBgView addSubview:uploadButton];
    
    //    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topBgView.frame) + 1 * hScale, CGRectGetWidth(topBgView.frame), CGRectGetHeight(self.wihtBgView.frame) - CGRectGetHeight(topBgView.frame) - 1 * hScale)];
    //    NSString *url = [NSString stringWithFormat:@"%@DownLoadServlet.do?businessID=%@&fileName=%@",baseNetWorkURL,self.businessID,self.imageName];
    //    NSString *url = [NSString stringWithFormat:@"http://222.73.7.130:8080/NGOSS_Front/DownLoadServlet.do?businessID=%@&fileName=%@",@"14937085927607346",@"DFQOL201700386-1.pdf"];
    //    self.webView.delegate = self;
    [self.phud showHUDSaveAddedTo:self.wihtBgView];
    [[CTTXRequestServer shareInstance]downContractWithBusinessID:self.businessID fileName:self.imageName SuccessBlock:^(NSString *contractPath) {
        [self.phud hideSave];
        NSURL *url = [NSURL fileURLWithPath:contractPath];
        self.fileUrl = url;
        
        if ([QLPreviewController canPreviewItem:(id<QLPreviewItem>)url]) {
            QLPreviewController *qlVc = [[QLPreviewController alloc] init];
            qlVc.view.frame = CGRectMake(0, CGRectGetMaxY(topBgView.frame) + 1 * hScale, CGRectGetWidth(topBgView.frame), CGRectGetHeight(self.wihtBgView.frame) - CGRectGetHeight(topBgView.frame) - 1 * hScale);
            qlVc.delegate = self;
            qlVc.dataSource = self;
            qlVc.navigationController.navigationBar.userInteractionEnabled = YES;
            qlVc.view.userInteractionEnabled = YES;
            [self.wihtBgView addSubview:qlVc.view];
//                        [[UIViewController currentViewController] presentViewController:qlVc animated:YES completion:nil];
        }
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        self.phud.promptStr = @"文档加载失败,请重新加载!";
        [self.phud showHUDResultAddedTo:self];
    }];
    //    [self loadDocument:url inView:self.webView];
    //    [self.wihtBgView addSubview:self.webView];
    
}
#pragma mark - QLPreviewController 代理方法
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    return self.fileUrl;
}
-(void)loadDocumentWithPdfPath:(NSString *)pdfPath
{
    //    NSLog(@"%@",documentName);
    ////    NSString *path = [[NSBundle mainBundle] pathForResource:documentName ofType:nil];
    //    NSURL *url = [NSURL URLWithString:documentName];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    [webView loadRequest:request];
    
    
}
//关闭
- (void)hideView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = CGRectMake(414 * wScale, kHeight, 1220 * wScale, 1372 * hScale);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
//上传合同
- (void)uploadButtonAction:(UIButton *)sender
{
    [self.phud showHUDSaveAddedTo:self.wihtBgView];
    [[CTTXRequestServer shareInstance] uploadContractInBGWithBusinessID:self.businessID typeNo:self.typeNo operationType:self.operationType imageName:self.imageName SuccessBlock:^(NSDictionary *dic) {
        [self.phud hideSave];
        NSString *ReturnCode = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"SYS_HEAD"] objectForKey:@"ReturnCode"]];
        
        if ([ReturnCode isEqualToString:@"0"]) {
            self.phud.promptStr = @"上传合同成功!";
            [self.phud showHUDResultAddedTo:self];
            if (_deleate && [_deleate respondsToSelector:@selector(clickWithType:)]) {
                [_deleate clickWithType:@"1"];
            }
        }else{
            NSString *ReturnMessage = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"SYS_HEAD"] objectForKey:@"ReturnMessage"]];
            self.phud.promptStr = ReturnMessage;
            [self.phud showHUDResultAddedTo:self];
        }
        
    } failedBlock:^(NSError *error) {
        [self.phud hideSave];
        self.phud.promptStr = @"上传合同失败!";
        [self.phud showHUDResultAddedTo:self];
        if (_deleate && [_deleate respondsToSelector:@selector(clickWithType:)]) {
            [_deleate clickWithType:@"2"];
        }
    }];
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}
@end
