//
//  CircleLabel.m
//  CoreTextDemo
//
//  Created by hanfeng.li on 2017/10/18.
//  Copyright © 2017年 hanfeng.li. All rights reserved.
//

#import "CircleLabel.h"
#import <CoreText/CoreText.h>

@implementation CircleLabel

- (void)setText:(NSString *)text {
    _text = text;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    float diameter = MIN(rect.size.width, rect.size.height);
    float x = (rect.size.width - diameter) / 2;
    float y = (rect.size.height - diameter) / 2;
    rect = CGRectMake(x, y, diameter, diameter);

    CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:rect].CGPath;
    
    CFAttributedStringRef attributedString = CFAttributedStringCreate(kCFAllocatorSystemDefault, (__bridge CFStringRef)(_text ?: @""), NULL);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(attributedString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, CFAttributedStringGetLength(attributedString)), path, nil);
    CTFrameDraw(frame,context);

    // 释放不归ARC管理的对象
    CFRelease(attributedString);
    CFRelease(frame);
    CFRelease(frameSetter);
}


@end
