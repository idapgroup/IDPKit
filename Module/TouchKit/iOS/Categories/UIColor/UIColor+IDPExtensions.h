//
//  UIColor+Initialization.h
//  YouGotListings
//
//  Created by Oleksa Korin on 6/9/11.
//  Copyright 2011 RedShiftLab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIColor (IDPExtensions)

+ (UIColor *)colorWithIntRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue floatAlpha:(CGFloat)alpha;
+ (UIColor *)colorByAlphaCompositingDestinationColor:(UIColor *)dst overSourceColor:(UIColor *)src;

- (BOOL)canProvideRGBComponents;
- (CGColorSpaceModel)colorSpaceModel;
- (UIColor *)rgbColor;

- (CGFloat)red;
- (CGFloat)green;
- (CGFloat)blue;
- (CGFloat)alpha;

- (CGFloat)getColorComponentWithIndex:(NSInteger)index;

@end
