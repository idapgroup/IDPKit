//
//  NSMutableString+IDPExtensions.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 1/13/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "NSMutableString+IDPExtensions.h"

@implementation NSMutableString (IDPExtensions)

- (void)appendUTF8String:(const char *)UTF8String {
    [self appendFormat:@"%s", UTF8String];
}

@end
