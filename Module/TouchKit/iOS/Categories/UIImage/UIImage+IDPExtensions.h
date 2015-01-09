//
//  UIImage+IDPExtensions.h
//  ClipIt
//
//  Created by Oleksa 'trimm' Korin on 2/25/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    IDPJPEGImageFile,
    IDPPNGImageFile,
    IDPUnknownImageFile
} IDPImageFileFormat;

@interface UIImage (IDPExtensions)

+ (NSString *)fileExtensionForFormat:(IDPImageFileFormat)format;

- (void)writeToFile:(NSString *)path atomically:(BOOL)YesOrNo inFormat:(IDPImageFileFormat)format;
- (void)writeToURL:(NSURL *)url atomically:(BOOL)YesOrNo inFormat:(IDPImageFileFormat)format;

- (NSData *)imageDataInFormat:(IDPImageFileFormat)format;

- (UIImage *)tintWithColor:(UIColor *)color;

@end
