//
//  UIColor+Initialization.m
//  YouGotListings
//
//  Created by Oleksa Korin on 6/9/11.
//  Copyright 2011 RedShiftLab. All rights reserved.
//

#import "UIColor+IDPExtensions.h"

@implementation UIColor (IDPExtensions)

+ (UIColor *)colorWithIntRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue floatAlpha:(CGFloat)alpha {
	return [UIColor colorWithRed:(float)red / 255.0f 
						   green:(float)green / 255.0f 
							blue:(float)blue / 255.0f  
						   alpha:alpha];
}

+ (UIColor *)colorByAlphaCompositingDestinationColor:(UIColor *)dst overSourceColor:(UIColor *)src {
	if (![src canProvideRGBComponents] || ![dst canProvideRGBComponents]) 
		return nil;
	
	src = [src rgbColor];
	dst = [dst rgbColor];
	
	NSInteger numComponents = 4;
	
	CGFloat srcColors[numComponents];
	CGFloat dstColors[numComponents];
	CGFloat resColors[numComponents];
	
	for (NSInteger i = 0; i < numComponents; i++) {
		srcColors[i] = [src getColorComponentWithIndex:i];
		dstColors[i] = [dst getColorComponentWithIndex:i];
		resColors[i] = 0;
	}
	
	NSInteger alpha = numComponents - 1;
	
	resColors[alpha] = srcColors[alpha] + dstColors[alpha] * (1 - srcColors[alpha]);
	
	if (resColors[alpha] == 0) {
		return [UIColor clearColor];
	}
	
	for (NSInteger i = 0; i < alpha; i++) {
		resColors[i] = srcColors[i] * srcColors[alpha] 
						+ dstColors[i] * dstColors[alpha] * (1 - srcColors[alpha]) / resColors[alpha];
	}
	
	return [UIColor colorWithRed:resColors[0] green:resColors[1] blue:resColors[2] alpha:resColors[3]];
}

- (CGColorSpaceModel)colorSpaceModel {  
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));  
}

- (BOOL)canProvideRGBComponents {  
    return (([self colorSpaceModel] == kCGColorSpaceModelRGB) ||   
            ([self colorSpaceModel] == kCGColorSpaceModelMonochrome));  
}

- (UIColor *)rgbColor {
	if (![self canProvideRGBComponents]) {
		return nil;
	}
	
	if ([self colorSpaceModel] == kCGColorSpaceModelRGB) {
		return self;
	}
	
	return [UIColor colorWithRed:[self red] green:[self green] blue:[self blue] alpha:[self alpha]];
}

- (CGFloat)red {  
	return [self getColorComponentWithIndex:0];
}  

- (CGFloat)green {  
	return [self getColorComponentWithIndex:1];
}  

- (CGFloat)blue {  
	return [self getColorComponentWithIndex:2];
}  

- (CGFloat)alpha { 
    NSAssert ([self canProvideRGBComponents], @"Must be a RGB color to use -red, -green, -blue");	
    const CGFloat *c = CGColorGetComponents(self.CGColor);  
    return c[CGColorGetNumberOfComponents(self.CGColor)-1];  
}

- (CGFloat)getColorComponentWithIndex:(NSInteger)index {
    NSAssert ([self canProvideRGBComponents], @"Must be a RGB color to use -red, -green, -blue");  
    const CGFloat *c = CGColorGetComponents(self.CGColor);  
    if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) return c[0];  
    return c[index]; 	
}

@end
