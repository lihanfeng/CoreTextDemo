//
//  AroundTextLabel.m
//  CoreTextDemo
//
//  Created by hanfeng.li on 2017/10/19.
//  Copyright © 2017年 hanfeng.li. All rights reserved.
//

#import "AroundTextLabel.h"
#import <CoreText/CoreText.h>

@implementation AroundTextLabel

- (void)setText:(NSString *)text {
    _text = text;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:_text ?: @""];
    
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping;
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    CTParagraphStyleSetting setting[] = {lineBreakMode};
    CTParagraphStyleRef style = CTParagraphStyleCreate(setting, 1);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:(__bridge id)style forKey:(id)kCTParagraphStyleAttributeName];
    [attributeStr addAttributes:attributes range:NSMakeRange(0, attributeStr.length)];

    UIImage *image = [UIImage imageNamed:@"weixin"];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    UIBezierPath *cirPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(120, 40, image.size.width, image.size.height)];
    [path appendPath:cirPath];
    
    NSInteger length = attributeStr.length;
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path.CGPath, NULL);
    CTFrameDraw(frame, context);

    UIImage *cirImage = [self circleImage:image];
    CGContextDrawImage(context,CGRectMake(120, 40, image.size.width, image.size.height), cirImage.CGImage);
    
    // 释放不归ARC管理的对象
    CFRelease(frame);
    CFRelease(frameSetter);
}

- (UIImage *)circleImage:(UIImage*)image {
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}


@end
