//
//  IDPArrayModel.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/9/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPModel.h"

#import "IDPArrayModelState.h"
#import "IDPBlockTypes.h"

@interface IDPArrayModel : IDPModel
@property (nonatomic, readonly)         NSUInteger  count;
@property (nonatomic, copy, readonly)   NSArray     *objects;

+ (instancetype)modelWithArray:(NSArray *)array;
+ (instancetype)modelWithArray:(NSArray *)array queue:(NSOperationQueue *)queue;
+ (instancetype)modelWithArray:(NSArray *)array queue:(NSOperationQueue *)queue target:(id)target;

- (instancetype)initWithArray:(NSArray *)array;
- (instancetype)initWithArray:(NSArray *)array queue:(NSOperationQueue *)queue;
- (instancetype)initWithArray:(NSArray *)array queue:(NSOperationQueue *)queue target:(id)target NS_DESIGNATED_INITIALIZER;

- (void)addObject:(id)object;
- (void)removeObject:(id)object;

- (NSUInteger)indexOfObject:(id)object;
- (id)objectAtIndex:(NSUInteger)index;
- (void)insertObject:(id)object atIndex:(NSUInteger)index;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object;
- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex;
- (BOOL)containsObject:(id)object;

- (id)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

- (void)performBatchBlock:(IDPObjectBlock)block;

@end
