//
//  NSString+IDPExtensions.h
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/26/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPSerialization.h"

@interface NSString (IDPExtensions) <IDPSerialization>

- (NSString *)urlEncode;

- (BOOL)isEqualToStringWithoutWhitespace:(NSString *)aString;
- (BOOL)isEmpty;
- (BOOL)containString:(NSString *)substring;
- (BOOL)containsStringWithCaseInsensitive:(NSString *)substring;

- (NSString *)removeEntryOfStrings:(NSArray *)entries;
- (BOOL)isAllDigits;

- (BOOL)containWord:(NSString *)word;

@end
