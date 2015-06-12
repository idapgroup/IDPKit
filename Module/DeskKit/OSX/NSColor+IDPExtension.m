//
//  NSColor+IDPExtension.m
//  IDPMailView
//
//  Created by Artem Chabanniy on 2/18/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "NSColor+IDPExtension.h"

@implementation NSColor (IDPExtension)

#pragma mark -
#pragma mark Class methods

+ (instancetype)colorWithIntRed:(NSInteger)red
                          green:(NSInteger)green
                           blue:(NSInteger)blue
                          alpha:(NSInteger)alpha
{
    CGFloat divider = 255;
    return [[self class] colorWithRed:(CGFloat)red/divider
                                green:(CGFloat)green/divider
                                 blue:(CGFloat)blue/divider
                                alpha:(CGFloat)alpha/divider];
}

@end
