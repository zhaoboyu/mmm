//
//  LLFPrintPageRenderer.m
//  YDJR
//
//  Created by 吕利峰 on 16/10/26.
//  Copyright © 2016年 agree.com.cn. All rights reserved.
//

#import "LLFPrintPageRenderer.h"

@implementation LLFPrintPageRenderer
- (NSData*) printToPDF
{
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData( pdfData, self.paperRect, nil );
    [self prepareForDrawingPages: NSMakeRange(0, self.numberOfPages)];
    CGRect bounds = UIGraphicsGetPDFContextBounds();
    for ( int i = 0 ; i < self.numberOfPages ; i++ )
    {
        UIGraphicsBeginPDFPage();
        [self drawPageAtIndex: i inRect: bounds];
    }
    UIGraphicsEndPDFContext();
    return pdfData;
}
@end
