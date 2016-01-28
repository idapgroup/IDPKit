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

+ (instancetype)colorWithHexColorString:(NSString *)hexString {
    NSColor *result = nil;
    unsigned colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != hexString) {
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        [scanner scanHexInt:&colorCode];
    }
    redByte = (unsigned char)(colorCode >> 16);
    greenByte = (unsigned char)(colorCode >> 8);
    blueByte = (unsigned char)(colorCode);
    
    result = [[self class] colorWithCalibratedRed:(CGFloat)redByte / 0xff
                                            green:(CGFloat)greenByte / 0xff
                                             blue:(CGFloat)blueByte / 0xff
                                            alpha:1.0];
    
    return result;
}

#pragma mark -
#pragma mark Public methods

- (CGFloat)luminosity {
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 0;
    
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    
    return 0.2126 * pow(red, 2.2f) + 0.7152 * pow(green, 2.2f) + 0.0722 * pow(blue, 2.2f);
}

- (CGFloat)luminosityDifference:(NSColor *)otherColor {
    CGFloat l1 = [self luminosity];
    CGFloat l2 = [otherColor luminosity];
    
    if (l1 >= 0 && l2 >= 0) {
        if (l1 > l2) {
            return (l1 + 0.05f) / (l2 + 0.05f);
        } else {
            return (l2 + 0.05f) / (l1 + 0.05f);
        }
    }
    
    return 0.0f;
}

@end
