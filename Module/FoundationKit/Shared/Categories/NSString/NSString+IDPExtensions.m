//
//  NSString+IDPExtensions.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/26/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSString+IDPExtensions.h"

static NSString * const kIDPTrueBOOLValueSting  = @"YES";
static NSString * const kIDPFalseBOOLValueSting = @"NO";

OBJC_INLINE NSString *IDPStringifyBOOL(BOOL value) {
    return YES == value ? kIDPTrueBOOLValueSting : kIDPFalseBOOLValueSting;
}

@implementation NSString (IDPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)stringWithBOOL:(BOOL)value {
    return [self  stringWithString:IDPStringifyBOOL(value)];
}

- (NSString *)urlEncodedString {
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                    (__bridge CFStringRef)self,
                                                                    NULL,
                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                    kCFStringEncodingUTF8);
    return (NSString *)CFBridgingRelease(stringRef);
}

- (NSString *)symbolicString {
    NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    return [self stringByTrimmingCharactersInSet:characterSet];
}

- (BOOL)isEmpty {
    NSString *string = [self symbolicString];
    
    return string.length == 0;
}

- (BOOL)containsString:(NSString *)substring {
    NSRange range = [self rangeOfString:substring];

    return range.location != NSNotFound;
}

- (BOOL)containsCaseInsensitiveString:(NSString *)substring {
    NSString *string = [self lowercaseString];
    return [string containsString:[substring lowercaseString]];
}

- (NSString *)removeSubstrings:(NSArray *)substrings {
    return [self removeSubstrings:substrings
                          options:NSWidthInsensitiveSearch];
}

- (NSString *)removeSubstrings:(NSArray *)substrings
                       options:(NSStringCompareOptions)options
{
    NSMutableString *result = [NSMutableString stringWithString:self];
    for (NSString *string in substrings) {
        [result replaceOccurrencesOfString:string
                                withString:@""
                                   options:options
                                     range:NSMakeRange(0, [result length])];
    }
    
    return [result copy];
}

@end
