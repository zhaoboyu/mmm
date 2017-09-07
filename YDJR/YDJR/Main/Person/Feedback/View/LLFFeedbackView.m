//
//  LLFFeedbackView.m
//  YDJR
//
//  Created by 吕利峰 on 2017/1/10.
//  Copyright © 2017年 agree.com.cn. All rights reserved.
//

#import "LLFFeedbackView.h"
#import "LLFFeedBackImageView.h"
#import "LLFPhoneCamerManger.h"
#import "WPQCarGroupViewController.h"
#import "AppDelegate.h"
#import "CTTXRequestServer+Login.h"
#import "CTTXRequestServer+FileUpload.h"
#import "CTTXRequestServer+fileManger.h"
#import "LLFPersonCenterPopView.h"
const CGFloat imageViewWidh = 150;
@interface LLFFeedbackView ()<LLFPhoneCamerMangerDelegate,LLFFeedBackImageViewDelegate,UITextViewDelegate>

@property (nonatomic,strong)UITextView *idealContentTextView;

@property (nonatomic,strong)UILabel *totalContentLabel;

@property (nonatomic,strong)NSMutableArray *imageViewArr;

@property (nonatomic,strong)UIButton *addImageViewButton;

@property (nonatomic,strong)HGBPromgressHud *phud;

@property (nonatomic,strong)UILabel *label1;

@property(nonatomic,strong)NSString *selectString;

@property(nonatomic,strong) UIButton *submitButton;
@end


@implementation LLFFeedbackView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self p_setupView];
    }
    return self;
}

- (void)p_setupView
{
    
    self.backgroundColor = [UIColor hex:@"#ffffff"];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 95 * hScale)];
    topLabel.text = @"意见反馈";
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor hex:@"#FF333333"];
    topLabel.font = [UIFont systemFontOfSize:17.0];
    [self addSubview:topLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,  95 * hScale, CGRectGetWidth(self.frame), 2 * hScale)];
    lineView.backgroundColor = [UIColor hex:@"#D9D9D9"];
    [self addSubview:lineView];
    

    void (^labelBlock)(CGRect ,NSString *) = ^(CGRect frame,NSString *text){
        
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        label.text = text;
        label.textColor = [UIColor hex:@"#333333"];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
      
    };
    NSArray *titleArr = [NSArray arrayWithObjects:@"意见类型",@"功能问题",@"界面问题",@"操作问题",@"其他",nil];
    for (int i=0; i <5; i++) {
        labelBlock(CGRectMake((64+(140+144)*i)*wScale, 177*hScale, 140*wScale, 34*hScale),titleArr[i]);
        if (i >0) {
            UIImageView *imagecheck = [[UIImageView alloc]initWithFrame:CGRectMake((284+(i-1)*284)*wScale, 177*hScale, 44*wScale, 44*hScale)];
            imagecheck.tag = 9998+i;
            imagecheck.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [imagecheck addGestureRecognizer:tap];
            imagecheck.image = [UIImage imageNamed:@"Check"];
            [self addSubview: imagecheck];
        }
    }
    labelBlock(CGRectMake(64*wScale, 296*hScale, 140*wScale, 34*hScale),@"意见内容");
    
   [self addObserver:self forKeyPath:@"selectString" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
  
    
    
    self.idealContentTextView = [[UITextView alloc]initWithFrame:CGRectMake(264*wScale, 296*wScale, 900*wScale, 300*hScale)];
    self.idealContentTextView.layer.borderColor = [UIColor hex:@"#d9d9d9"].CGColor;
    self.idealContentTextView.layer.borderWidth =0.5;
    self.idealContentTextView.layer.cornerRadius =0.5;
    self.idealContentTextView.delegate = self;
    
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(30*wScale, 10*hScale, 258*wScale, 34*hScale)];
    self.label1.textColor = [UIColor hex:@"#d5d5d9"];
    self.label1.text =@"请输入意见内容";
    self.label1.font = [UIFont systemFontOfSize:15];
    [self.idealContentTextView addSubview:_label1];
    [self addSubview:_idealContentTextView];
    
    labelBlock(CGRectMake(64*wScale, 694*hScale, 140*wScale, 34*hScale),@"上传图片");

    self.addImageViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addImageViewButton.frame = CGRectMake(264 * wScale, 694* hScale, 150 * wScale, 150 * hScale);
    [self.addImageViewButton setBackgroundImage:[UIImage imageNamed:@"LLF_Person_Feedback_icon"] forState:(UIControlStateNormal)];
    [self.addImageViewButton addTarget:self action:@selector(addImageViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addImageViewButton];
    
    self.imageViewArr = [NSMutableArray array];
    
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.frame = CGRectMake(264*wScale ,1004*hScale, 400 * wScale, 80 * hScale);
        [submitButton setTitle:@"提交" forState:(UIControlStateNormal)];
    submitButton.backgroundColor = [UIColor hex:@"#d3d3d3"];
        [submitButton setTitleColor:[UIColor hex:@"#ffffff"]];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [submitButton addTarget:self action:@selector(submibuttonAction:) forControlEvents:UIControlEventTouchUpInside];
       self.submitButton = submitButton;
        [self addSubview:submitButton];
 
    
}
- (void)tapAction:(UITapGestureRecognizer *)sender{
    for (int i =0; i < 4; i ++) {
        UIImageView  *imageCheck = [self viewWithTag:9999+i];
        imageCheck.image = [UIImage imageNamed:@"Check"];
    }
    UIImageView *imageC =(UIImageView*)sender.self.view;
    imageC.image = [UIImage imageNamed:@"Check _pressed"];
    switch (imageC.tag-9999) {
        case 0:
            self.selectString = @"功能问题";
            break;
        case 1:
            self.selectString = @"界面问题";
            break;
        case 2:
            self.selectString = @"操作问题";
            break;
        case 3:
            self.selectString = @"其他";
            break;
        default:
            break;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""]) {
        _label1.hidden = YES;
        if (self.selectString.length>0) {
            self.submitButton.backgroundColor = [UIColor hexString:@"#333333"];
        }
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        _label1.hidden = NO;
       self.submitButton.backgroundColor = [UIColor hexString:@"#d3d3d3"];
    }
    
    return YES;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"selectString"])
    {
        if (self.selectString.length>0) {
            if (![self.idealContentTextView.text isEqualToString:@""]) {
                self.submitButton.backgroundColor = [UIColor hexString:@"#333333"];
            }
        }
        
    }
}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    [self.messageDelegate feedBack];
    [self removeObserver:self forKeyPath:@"selectString"];
}
//提交
- (void)submibuttonAction:(UIButton *)sender
{
    if (self.selectString.length > 0 && self.idealContentTextView.text.length > 0) {
        [self.phud showHUDSaveAddedTo:self];
        self.submitButton.userInteractionEnabled = NO;
        [[CTTXRequestServer shareInstance] feedbackWithUserCode:[UserDataModel sharedUserDataModel].userName content:self.idealContentTextView.text opinionType:[[self getIdealTypeDic] objectForKey:self.selectString] SuccessBlock:^(NSDictionary *resultDic) {
            [self.phud hideSave];
            BOOL results = [[resultDic objectForKey:@"SYS_HEAD"] objectForKey:@"result"];
            if (results) {
                NSString *opinionId = [[resultDic objectForKey:@"RespInfo"] objectForKey:@"opinionId"];
                //
                [self uploadIamgeWithOpinionId:opinionId];
                self.phud.promptStr = @"反馈提交成功";
             
                [self.phud showHUDResultAddedTo:self];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [self removeFromSuperview];
                });
               
             
            }else{
                 self.submitButton.userInteractionEnabled = YES;
                self.phud.promptStr = @"网络状况不好...请稍后重试!";
                [self.phud showHUDResultAddedTo:self];
            }
            
        } failedBlock:^(NSError *error) {
            [self.phud hideSave];
             self.submitButton.userInteractionEnabled = YES;
            self.phud.promptStr = @"网络状况不好...请稍后重试!";
            [self.phud showHUDResultAddedTo:self];
        }];
    }else{
        self.submitButton.userInteractionEnabled = YES;
        self.phud.promptStr = @"请输入反馈内容及类型";
        [self.phud showHUDResultAddedTo:self];
    }
    
}
//上传图片
- (void)uploadIamgeWithOpinionId:(NSString *)opinionId
{
    for (LLFFeedBackImageView *feedBackImageView in self.imageViewArr) {
        NSString *imageName = [NSString stringWithFormat:@"%@%@.jpg",[Tool getTimeStr],[Tool getUdidCode]];
        NSData *imageData = UIImageJPEGRepresentation(feedBackImageView.contentImageView.image, 0.5);
        //    NSString *dataStr = [imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
        NSString *imagePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imageName]];
        //创建一个文件
        NSFileManager *fileManage = [NSFileManager defaultManager];
        [fileManage createFileAtPath:imagePath contents:nil attributes:nil];
        
        BOOL soult =[imageData writeToFile:imagePath options:(NSDataWritingAtomic) error:nil];
        if (soult) {
            //opinionId TEXT, fileName TEXT, filePath TEXT, Type TEXT
            NSMutableDictionary *objectDic = [NSMutableDictionary dictionary];
            [objectDic setObject:@"1" forKey:@"Type"];
            [objectDic setObject:imagePath forKey:@"filePath"];
            [objectDic setObject:opinionId forKey:@"opinionId"];
            BOOL res = [[DBManger sharedDMManger]insertTable:feedBackImage withObjectDictionary:objectDic];
            if (res) {
                NSLog(@"成功");
            }
            
        }
        
    }
}
//添加图片
- (void)addImageViewButtonAction:(UIButton *)sender
{
    if (self.imageViewArr.count <= 3) {
        LLFPhoneCamerManger *phoneCamerManger = [LLFPhoneCamerManger sharedPhoneCamerManger];
        phoneCamerManger.type = camer_all;
        phoneCamerManger.delegate = self;
        //    phoneCamerManger.parent = part;
        [phoneCamerManger show];
    }else{
        self.phud.promptStr = @"最多只能上传四张图片!";
        [self.phud showHUDResultAddedTo:self];
    }
}
//计算反馈文字长度
- (void)idealContentTextFieldAction:(UITextField *)sender
{
    //    NSLog(@"%ld",sender.text.length);
    self.totalContentLabel.text = [NSString stringWithFormat:@"%ld/50",sender.text.length];
}
#pragma mark 代理事件
//LLFPhoneCamerManger_LLFPhoneCamerMangerDelegate
- (void)setImageWithPhotoSelector:(UIImage *)image
{
    NSInteger imageViewNum = self.imageViewArr.count;
    LLFFeedBackImageView *feedBackImageView = [[LLFFeedBackImageView alloc]initWithFrame:CGRectMake(200 * wScale + imageViewNum * imageViewWidh * wScale+40*wScale *imageViewNum,674*hScale, imageViewWidh * wScale, 150 * hScale)];
    feedBackImageView.delegate = self;
    //    feedBackImageView.backgroundColor = [UIColor redColor];
    feedBackImageView.contentImageView.image = image;
    [self addSubview:feedBackImageView];
    [self.imageViewArr addObject:feedBackImageView];
    
    imageViewNum = self.imageViewArr.count;
    CGRect frame = self.addImageViewButton.frame;
    frame.origin.x = feedBackImageView.frame.origin.x+imageViewWidh * wScale  +40*wScale;
    self.addImageViewButton.frame = frame;
}
//LLFFeedBackImageView_LLFFeedBackImageViewDelegate
- (void)sendButtonState:(NSString *)state view:(UIView *)view
{
    if ([state isEqualToString:@"1"]) {
        //删除
        [self.imageViewArr removeObject:view];
        NSInteger imageViewNum = self.imageViewArr.count;
        for (int i = 0; i < self.imageViewArr.count; i++) {
            LLFFeedBackImageView *feedBackImageView = self.imageViewArr[i];
            feedBackImageView.frame = CGRectMake(200 * wScale + i * imageViewWidh * wScale+40*wScale *i,674*hScale, imageViewWidh * wScale, 150 * hScale);
            feedBackImageView.isClose = NO;
        }
        CGRect frame = self.addImageViewButton.frame;
        frame.origin.x =imageViewNum==0?264*wScale:200 * wScale + (imageViewNum-1) * imageViewWidh * wScale+40*wScale *(imageViewNum-1)+imageViewWidh * wScale  +40*wScale;
        self.addImageViewButton.frame = frame;
        
    }else if ([state isEqualToString:@"2"]){
        //长按
        for (LLFFeedBackImageView *feedBackImageView in self.imageViewArr) {
            feedBackImageView.isClose = YES;
        }
    }
}

#pragma mark 获取数据源
- (NSDictionary *)getIdealTypeDic
{
    return @{
             @"功能问题":@"01",
             @"界面问题":@"02",
             @"操作问题":@"03",
             @"其他":@"00",
             };
}
-(HGBPromgressHud *)phud
{
    if(_phud==nil){
        _phud=[[HGBPromgressHud alloc]init];
    }
    return _phud;
}

@end
