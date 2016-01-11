//
//  NSImage+IDPExtension.m
//  OSX
//
//  Created by Artem Chabannyi on 6/12/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "NSImage+IDPExtension.h"

@implementation NSImage (IDPExtension)

#pragma mark -
#pragma mark Public methods

- (NSColor *)averageColor {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3]) / 255.0;
        CGFloat multiplier = alpha / 255.0;
        return [NSColor colorWithRed:((CGFloat)rgba[0]) * multiplier
                               green:((CGFloat)rgba[1]) * multiplier
                                blue:((CGFloat)rgba[2]) * multiplier
                               alpha:alpha];
    }
    else {
        return [NSColor colorWithRed:((CGFloat)rgba[0]) / 255.0
                               green:((CGFloat)rgba[1]) / 255.0
                                blue:((CGFloat)rgba[2]) / 255.0
                               alpha:((CGFloat)rgba[3]) / 255.0];
    }
}

- (CGImageRef)CGImage {
    CGImageSourceRef source;
    source = CGImageSourceCreateWithData((CFDataRef)[self TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    
    return maskRef;
}

@end
