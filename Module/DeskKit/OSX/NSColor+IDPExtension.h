//
//  NSColor+IDPExtension.h
//  IDPMailView
//
//  Created by Artem Chabanniy on 2/18/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (IDPExtension)


/**
 Creates and returns an NSColor object with the specified red, green, blue, and alpha channel values.
 @param red
 The red channel value, expressed as a integer-point value in the range 0–255.
 @param green
 The green channel value, expressed as a integer-point value in the range 0–255.
 @param blue
 The blue channel value, expressed as a integer-point value in the range 0–255.
 alpha
 @return NSColor object
 */
+ (NSColor *)colorWithIntRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(NSInteger)alpha;

@end
