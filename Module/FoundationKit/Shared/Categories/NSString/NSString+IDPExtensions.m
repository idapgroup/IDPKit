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
                                                                    (CFStringRef)self,
                                                                    NULL,
                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                    kCFStringEncodingUTF8);
    NSString *string = (NSString *)stringRef;
    [[string retain] autorelease];
    
    CFRelease(stringRef);
    
    return string;
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
    if (empty.length == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)containString: (NSString*) substring {
    NSRange range = [self rangeOfString : substring];
    BOOL found = ( range.location != NSNotFound );
    return found;
}

- (BOOL)containsStringWithCaseInsensitive:(NSString *)substring {
    NSString *string = [self lowercaseString];
    return [string containString:[substring lowercaseString]];
}

- (NSString *)removeEntryOfStrings:(NSArray *)entries {
    NSString *result = self;
    for (NSString *string in entries) {
        result = [result stringByReplacingOccurrencesOfString:string withString:@""];
    }
    return result;
}

- (BOOL)isAllDigits {
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange r = [self rangeOfCharacterFromSet: nonNumbers];
    return r.location == NSNotFound;
}

- (BOOL)containWord:(NSString *)word {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    scanner.caseSensitive = YES;
    NSString *string = nil;
    BOOL contain = NO;
    
    while (![scanner isAtEnd]) {
        if ([scanner scanString:word intoString:&string]) {
            contain = YES;
            break;
        }
        scanner.scanLocation++;
    }
    
    return contain;
}

@end
