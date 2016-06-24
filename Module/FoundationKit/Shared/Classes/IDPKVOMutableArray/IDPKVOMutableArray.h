//
//  IDPKVOMutableArray.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/23/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPMutableArray.h"

#import "IDPObjCRuntime.h"

FOUNDATION_EXPORT
NSString * const kIDPMutableArrayObjects;

FOUNDATION_EXPORT
NSString * const kIDPMutableArrayCount;

@interface IDPKVOMutableArray : IDPMutableArray

@end

@interface IDPKVOMutableArray (IDPKVCCompliance)

- (NSUInteger)countOfArray;

- (id)objectInArrayAtIndex:(NSUInteger)index;
- (NSArray *)arrayAtIndexes:(NSIndexSet *)indexes;
- (void)getArray:(id __assign *)buffer range:(NSRange)range;

- (void)insertObject:(id)object inArrayAtIndex:(NSUInteger)index;
- (void)insertArray:(NSArray *)array atIndexes:(NSIndexSet *)indexes;
- (void)removeObjectFromArrayAtIndex:(NSUInteger)index;

- (void)removeArrayAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInArrayAtIndex:(NSUInteger)index withObject:(id)object;
- (void)replaceArrayAtIndexes:(NSIndexSet *)indexes withArray:(NSArray *)array;

@end
