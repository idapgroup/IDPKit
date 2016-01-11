//
//  NSView+IDPExtension.m
//  MovieScript
//
//  Created by Artem Chabanniy on 12/09/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSView+IDPExtension.h"
#import <objc/runtime.h>

@implementation NSView (IDPExtension)

- (void)setBackgroundColor:(NSColor *)backgroundColor {
    self.wantsLayer = YES;
    self.layer.backgroundColor = backgroundColor == nil ? NULL : backgroundColor.CGColor;
}

- (NSColor *)backgroundColor {
    return self.layer.backgroundColor == NULL ? nil : [NSColor colorWithCGColor:self.layer.backgroundColor];
}

- (CGPoint)center {
    CGRect frame = self.frame;
    return CGPointMake(frame.origin.x + CGRectGetWidth(frame) / 2, frame.origin.y + CGRectGetHeight(frame) / 2);
}

- (void)setCenter:(CGPoint)center {
    CGRect frame = self.frame;
    frame.origin = CGPointMake(center.x - CGRectGetWidth(frame), center.y - CGRectGetHeight(frame));
    [self setFrame:frame];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.wantsLayer = YES;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.wantsLayer = YES;
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderColor:(NSColor *)borderColor {
    self.wantsLayer = YES;
    self.layer.borderColor = borderColor == nil ? NULL : borderColor.CGColor;
}

- (NSColor *)borderColor {
    return self.layer.borderColor == NULL ? nil : [NSColor colorWithCGColor:self.layer.borderColor];
}

- (NSImage *)imageRepresentation {
    return [self imageRepresentationWithRect:self.bounds];
}

- (NSImage *)imageRepresentationWithRect:(NSRect)rect {
    NSBitmapImageRep *bitmapImageRep = [self bitmapImageRepForCachingDisplayInRect:rect];
    [self cacheDisplayInRect:rect toBitmapImageRep:bitmapImageRep];
    NSImage *image = [[NSImage alloc] initWithCGImage:[bitmapImageRep CGImage] size:bitmapImageRep.size];
    [image addRepresentation:bitmapImageRep];
    
    return image;
}

- (NSPoint)pointWithEvent:(NSEvent *)event {
    return [self convertPoint:event.locationInWindow fromView:nil];
}

@end
