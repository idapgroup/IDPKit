//
//  UIImage+IDPExtensions.m
//  ClipIt
//
//  Created by Oleksa 'trimm' Korin on 2/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "UIImage+IDPExtensions.h"

static NSString * const IDPPNGFileExtension     = @"png";
static NSString * const IDPJPEGFileExtension    = @"jpeg";

@interface UIImage (IDPPrivateExtensions)

@end

@implementation UIImage (IDPPrivateExtensions)

@end

@implementation UIImage (IDPExtensions)

+ (NSString *)fileExtensionForFormat:(IDPImageFileFormat)format {
    switch (format) {
        case IDPPNGImageFile:
            return IDPPNGFileExtension;
            break;
            
        case IDPJPEGImageFile:
            return IDPJPEGFileExtension;
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (void)writeToFile:(NSString *)path atomically:(BOOL)YesOrNo inFormat:(IDPImageFileFormat)format {
    NSData *data = [self imageDataInFormat:format];
    [data writeToFile:path atomically:YesOrNo];
}

- (void)writeToURL:(NSURL *)url atomically:(BOOL)YesOrNo inFormat:(IDPImageFileFormat)format {
    NSData *data = [self imageDataInFormat:format];
    [data writeToURL:url atomically:YesOrNo];
}

- (NSData *)imageDataInFormat:(IDPImageFileFormat)format {
    NSData *result = nil;

    switch (format) {
        case IDPPNGImageFile:
            result = UIImagePNGRepresentation(self);
            break;
            
        case IDPJPEGImageFile:
            result = UIImageJPEGRepresentation(self, 0.9f);
            break;
            
        default:
            break;
    }
    
    return result;
}

- (UIImage *)tintWithColor:(UIColor *)color {
    CGSize size = self.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // draw black background to preserve color of transparent pixels
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [[UIColor clearColor] setFill];
    CGContextFillRect(context, rect);
    
    // draw original image
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    CGContextDrawImage(context, rect, self.CGImage);
    
    // tint image (loosing alpha) - the luminosity of the original image is preserved
    CGContextSetBlendMode(context, kCGBlendModeColor);
    [color setFill];
    CGContextFillRect(context, rect);
    
    // mask by alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeDestinationIn);
    CGContextDrawImage(context, rect, self.CGImage);
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return result;
}

@end
