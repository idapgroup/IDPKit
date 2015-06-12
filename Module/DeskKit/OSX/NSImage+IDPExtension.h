//
//  NSImage+IDPExtension.h
//  OSX
//
//  Created by Artem Chabannyi on 6/12/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (IDPExtension)

/**
 Calculate average value of image.
 @return Return average color value of instance.
 */
- (NSColor *)averageColor;

/**
 The underlying image data.
 @return Return CGImageRef.
 */
- (CGImageRef)CGImage;

@end
