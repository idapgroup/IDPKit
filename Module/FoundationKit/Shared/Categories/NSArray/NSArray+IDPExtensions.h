//
//  NSArray+IDPExtensions.h
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IDPArrayObjectsEnumerationBlock)(id obj, NSUInteger idx, BOOL *stop);

@interface NSArray (IDPExtensions)

/**
 This method returns a random object from this array.
 @return Random object from this array.
 */
- (id)randomObject;

/**
 This method shuffle array.
 @return a new shuffled array.
 */
- (NSArray *)shuffledArray;

/**
 This method return first object from array.
 @return first object or nil if array is empty.
 */
- (id)firstObject;

@end
