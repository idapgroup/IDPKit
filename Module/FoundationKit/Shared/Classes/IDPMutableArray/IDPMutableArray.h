//
//  IDPMutableArray.h
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

// A mutable proxy array intended for subclassing
@interface IDPMutableArray : NSMutableArray

// methods intended for overloading, if you intend to change
// the class behaviour in subclasses

- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)addObject:(id)anObject;
- (void)removeLastObject;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

@end