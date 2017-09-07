//
//  UIWebView+ToFile.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/25.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "UIWebView+ToFile.h"
#import <QuartzCore/QuartzCore.h>
#import "LLFPDFManager.h"
@implementation UIWebView (ToFile)
- (UIImage *)imageRepresentation{
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize boundsSize = self.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize contentSize = self.scrollView.contentSize;
    CGFloat contentHeight = contentSize.height;
    
    CGPoint offset = self.scrollView.contentOffset;
    
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    
    NSMutableArray *images = [NSMutableArray array];
    while (contentHeight > 0) {
        UIGraphicsBeginImageContextWithOptions(boundsSize, NO, 0.0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [images addObject:image];
        
        CGFloat offsetY = self.scrollView.contentOffset.y;
        [self.scrollView setContentOffset:CGPointMake(0, offsetY + boundsHeight)];
        contentHeight -= boundsHeight;
    }
    
    [self.scrollView setContentOffset:offset];
    
    CGSize imageSize = CGSizeMake(contentSize.width * scale,
                                  contentSize.height * scale);
    UIGraphicsBeginImageContext(imageSize);
    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
        [image drawInRect:CGRectMake(0,
                                     scale * boundsHeight * idx,
                                     scale * boundsWidth,
                                     scale * boundsHeight)];
    }];
    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return fullImage;
}

- (void)PDFDataWithFileName:(NSString *)fileName
{
	//    UIViewPrintFormatter *fmt = [self viewPrintFormatter];
	//    UIPrintPageRenderer *render = [[UIPrintPageRenderer alloc] init];
	//    [render addPrintFormatter:fmt startingAtPageAtIndex:0];
	//    CGRect page;
	//    page.origin.x=0;
	//    page.origin.y=0;
	//    page.size.width=600;
	//    page.size.height=768;
	//
	//    CGRect printable=CGRectInset( page, 50, 50 );
	//    [render setValue:[NSValue valueWithCGRect:page] forKey:@"paperRect"];
	//    [render setValue:[NSValue valueWithCGRect:printable] forKey:@"printableRect"];
	//
	//    NSMutableData * pdfData = [NSMutableData data];
	//    UIGraphicsBeginPDFContextToData( pdfData, CGRectZero, nil );
	//
	//    for (NSInteger i=0; i < [render numberOfPages]; i++)
	//    {
	//        UIGraphicsBeginPDFPage();
	//        CGRect bounds = UIGraphicsGetPDFContextBounds();
	//        [render drawPageAtIndex:i inRect:bounds];
	//
	//    }
	//    UIGraphicsEndPDFContext();
	UIImage *img = [self imageRepresentation];
	NSData *imgData = UIImageJPEGRepresentation(img, 0.5);
	[LLFPDFManager WQCreatePDFFileWithSrc:imgData toDestFile:fileName withPassword:nil];
	
	//    NSData *pdfData = [NSData dataWithContentsOfFile:[LLFPDFManager pdfDestPath:@"123"]];
	//    return pdfData;
}

- (void)PDFDataWithFileName:(NSString *)fileName SuccessBlock:(void (^)(void))SuccessBlock
{
//    UIViewPrintFormatter *fmt = [self viewPrintFormatter];
//    UIPrintPageRenderer *render = [[UIPrintPageRenderer alloc] init];
//    [render addPrintFormatter:fmt startingAtPageAtIndex:0];
//    CGRect page;
//    page.origin.x=0;
//    page.origin.y=0;
//    page.size.width=600;
//    page.size.height=768;
//    
//    CGRect printable=CGRectInset( page, 50, 50 );
//    [render setValue:[NSValue valueWithCGRect:page] forKey:@"paperRect"];
//    [render setValue:[NSValue valueWithCGRect:printable] forKey:@"printableRect"];
//    
//    NSMutableData * pdfData = [NSMutableData data];
//    UIGraphicsBeginPDFContextToData( pdfData, CGRectZero, nil );
//    
//    for (NSInteger i=0; i < [render numberOfPages]; i++)
//    {
//        UIGraphicsBeginPDFPage();
//        CGRect bounds = UIGraphicsGetPDFContextBounds();
//        [render drawPageAtIndex:i inRect:bounds];
//        
//    }
//    UIGraphicsEndPDFContext();
    UIImage *img = [self imageRepresentation];
    NSData *imgData = UIImageJPEGRepresentation(img, 0.5);
    [LLFPDFManager WQCreatePDFFileWithSrc:imgData toDestFile:fileName withPassword:nil];
	SuccessBlock();
//    NSData *pdfData = [NSData dataWithContentsOfFile:[LLFPDFManager pdfDestPath:@"123"]];
//    return pdfData;
}

@end
