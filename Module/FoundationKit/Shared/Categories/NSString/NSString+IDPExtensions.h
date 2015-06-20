//
//  NSString+IDPExtensions.h
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/26/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *IDPStringifyBOOL(BOOL value);

@interface NSString (IDPExtensions)

/// Returns @"YES" or @"NO" string according the value
+ (instancetype)stringWithBOOL:(BOOL)value;

- (NSString *)urlEncodedString;

- (BOOL)isEmpty;
- (BOOL)containsString:(NSString *)substring;
- (BOOL)containsCaseInsensitiveString:(NSString *)substring;

/**
 *	Returns the string containing symbolic characters.
 *
 *	@return String without whitespaces and new line characters
 */
- (NSString *)symbolicString;

/**
 *	Removes substrings from strings using case sensitive search ignoring width differences in characters that have full-width and half-width forms.
 *
 *	@param substrings Array of substrings to remove.
 *
 *	@return String without substrings.
 */
- (NSString *)removeSubstrings:(NSArray *)substrings;

/**
 *	Removes substrings from strings.
 *
 *	@param substrings Array of substrings to remove.
 *	@param options    A mask specifying substring search options.
 *
 *	@return String without substrings.
 */
- (NSString *)removeSubstrings:(NSArray *)substrings
                       options:(NSStringCompareOptions)options;

@end
