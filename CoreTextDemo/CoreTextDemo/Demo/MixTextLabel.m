//
//  MixTextLabel.m
//  CoreTextDemo
//
//  Created by hanfeng.li on 2017/10/18.
//  Copyright © 2017年 hanfeng.li. All rights reserved.
//

#import "MixTextLabel.h"
#import <CoreText/CoreText.h>

@implementation MixTextLabel

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
    
    CTRunDelegateCallbacks callBacks;
    memset(&callBacks,0,sizeof(CTRunDelegateCallbacks));
    callBacks.getAscent = ascentCallBacks;
    callBacks.getDescent = descentCallBacks;
    callBacks.getWidth = widthCallBacks;
    NSDictionary *dicPic = @{@"height":@72,@"width":@98};
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callBacks, (__bridge void *)dicPic);
    
    unichar placeHolder = 0xFFFC;
    NSString * placeHolderStr = [NSString stringWithCharacters:&placeHolder length:1];
    NSMutableAttributedString *placeHolderAttrStr = [[NSMutableAttributedString alloc] initWithString:placeHolderStr];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)placeHolderAttrStr, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    [attributeStr insertAttributedString:placeHolderAttrStr atIndex:1];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    NSInteger length = attributeStr.length;
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, length), path, NULL);
    CTFrameDraw(frame, context);
    
    UIImage *image = [UIImage imageNamed:@"weixin"];
    CGRect imgFrm = [self calculateImageRectWithFrame:frame];
    CGContextDrawImage(context,imgFrm, image.CGImage);
    
    // 释放不归ARC管理的对象
    CFRelease(frame);
    CFRelease(path);
    CFRelease(frameSetter);
}

static CGFloat ascentCallBacks(void *ref) {
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"height"] floatValue];
}

static CGFloat descentCallBacks(void *ref) {
    return 10;
}

static CGFloat widthCallBacks(void *ref) {
    return [(NSNumber *)[(__bridge NSDictionary *)ref valueForKey:@"width"] floatValue];
}

- (CGRect)calculateImageRectWithFrame:(CTFrameRef)frame {
    NSArray * arrLines = (NSArray *)CTFrameGetLines(frame);
    NSInteger count = [arrLines count];
    CGPoint points[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), points);
    for (int i = 0; i < count; i ++) {
        CTLineRef line = (__bridge CTLineRef)arrLines[i];
        NSArray *arrRuns = (NSArray *)CTLineGetGlyphRuns(line);
        for (int j = 0; j < arrRuns.count; j ++) {
            CTRunRef run = (__bridge CTRunRef)arrRuns[j];
            NSDictionary * attributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[attributes valueForKey:(id)kCTRunDelegateAttributeName];
            if (delegate == nil) {
                continue;
            }
            NSDictionary *dic = CTRunDelegateGetRefCon(delegate);
            if (![dic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            
            CGPoint point = points[i];
            CGFloat ascent;
            CGFloat descent;
            CGRect boundsRun;
            boundsRun.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            boundsRun.size.height = ascent + descent;
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            boundsRun.origin.x = point.x + xOffset;
            boundsRun.origin.y = point.y - descent;
            CGPathRef path = CTFrameGetPath(frame);
            CGRect colRect = CGPathGetBoundingBox(path);
            CGRect imageBounds = CGRectOffset(boundsRun, colRect.origin.x, colRect.origin.y);
            return imageBounds;
        }
    }
    return CGRectZero;
}

@end
