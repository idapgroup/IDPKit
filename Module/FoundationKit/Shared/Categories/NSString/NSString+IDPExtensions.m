//
//  NSString+IDPExtensions.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/26/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSString+IDPExtensions.h"

@implementation NSString (IDPExtensions)

- (NSString *)serialize {
    return self;
}

- (NSString *)urlEncode {
    CFStringRef stringRef = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                    (__bridge CFStringRef)self,
                                                                    NULL,
                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                    kCFStringEncodingUTF8);
    return (NSString *)CFBridgingRelease(stringRef);
}

- (BOOL)isEqualToStringWithoutWhitespace:(NSString *)aString {
    BOOL isEqual = NO;
    
    NSString *selfWithoutWhitespace = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *aStringWithoutWhitespace = [aString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    isEqual = [selfWithoutWhitespace isEqualToString:aStringWithoutWhitespace];
    
    return isEqual;
}

- (BOOL)isEmpty {
    NSString *empty = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return empty.length == 0;
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
