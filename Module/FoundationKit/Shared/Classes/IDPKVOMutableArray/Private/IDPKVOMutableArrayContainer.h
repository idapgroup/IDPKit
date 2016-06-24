//
//  IDPKVOMutableArrayContainer.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/23/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPObjCRuntime.h"

@class IDPKVOMutableArray;

@interface IDPKVOMutableArrayContainer : NSObject
@property (nonatomic, weak, readonly)   IDPKVOMutableArray  *array;
@property (nonatomic, readonly)         NSUInteger          count;

+ (instancetype)containerWithArray:(IDPKVOMutableArray *)array;

- (instancetype)initWithArray:(IDPKVOMutableArray *)array NS_DESIGNATED_INITIALIZER;

- (NSUInteger)countOfArray;
- (id)objectInArrayAtIndex:(NSUInteger)index;
- (NSArray *)arrayAtIndexes:(NSIndexSet *)indexes;
- (void)getArray:(id __assign *)buffer range:(NSRange)range;

- (void)insertObject:(id)object inArrayAtIndex:(NSUInteger)index;
- (void)removeObjectFromArrayAtIndex:(NSUInteger)index;
- (void)replaceObjectInArrayAtIndex:(NSUInteger)index withObject:(id)object;

- (void)insertArray:(NSArray *)array atIndexes:(NSIndexSet *)indexes;
- (void)removeArrayAtIndexes:(NSIndexSet *)indexes;
- (void)replaceArrayAtIndexes:(NSIndexSet *)indexes withArray:(NSArray *)array;

@end
