//
//  IDPArrayModel.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/9/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPArrayModel.h"

#import "NSMutableArray+IDPExtensions.h"
#import "IDPArrayChangeModel+IDPClusterClass.h"

#import "IDPReturnMacros.h"

@interface IDPArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableObjects;

- (void)notifyWithChangeModel:(IDPArrayChangeModel *)changeModel;

@end

@implementation IDPArrayModel

@dynamic count;
@dynamic objects;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithArray:(NSArray *)array {
    return [self modelWithArray:array queue:nil];
}

+ (instancetype)modelWithArray:(NSArray *)array queue:(NSOperationQueue *)queue {
    return [self modelWithArray:array queue:queue target:nil];
}

+ (instancetype)modelWithArray:(NSArray *)array queue:(NSOperationQueue *)queue target:(id)target {
    return [[self alloc] initWithArray:array queue:queue target:target];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithArray:(NSArray *)array {
    return [self initWithArray:array queue:nil];
}

- (instancetype)initWithArray:(NSArray *)array queue:(NSOperationQueue *)queue {
    return [self initWithArray:array queue:queue target:nil];
}

- (instancetype)initWithArray:(NSArray *)array queue:(NSOperationQueue *)queue target:(id)target {
    self = [super initWithQueue:queue target:target];
    [self executeSyncBlock:^(IDPArrayModel *model) {
        model.mutableObjects = [NSMutableArray arrayWithArray:array ? array : @[]];
    }];
    
    return self;
}

- (instancetype)initWithQueue:(NSOperationQueue *)queue target:(id)target {
    return [self initWithArray:nil queue:queue target:target];
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.mutableObjects.count;
}

- (NSArray *)objects {
    return [self.mutableObjects copy];
}

#pragma mark -
#pragma mark Public

- (void)addObject:(id)object {
    IDPReturnIfNil(object);
    [self.mutableObjects addObject:object];
    
    [self notifyWithChangeModel:[IDPArrayChangeModel insertModelWithArray:self index:self.count]];
}

- (void)removeObject:(id)object {
    IDPReturnIfNil(object);

    NSMutableArray *objects = self.mutableObjects;
    NSIndexSet *indexSet = [objects indexesOfObject:object];
    NSMutableArray *changeModels = [NSMutableArray arrayWithCapacity:indexSet.count];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL *stop) {
        [changeModels addObject:[IDPArrayChangeModel removeModelWithArray:self index:index]];
    }];

    [objects removeObject:object];
    
    [self notifyWithChangeModel:[IDPArrayChangeModel compoundModelWithArray:self changeModels:changeModels]];
}

- (NSUInteger)indexOfObject:(id)object {
    return [self.mutableObjects indexOfObject:object];
}

- (id)objectAtIndex:(NSUInteger)index {
    IDPReturnValueIfNil(index < self.count, nil);
    
    return self.mutableObjects[index];
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    NSUInteger count = self.count;
    
    IDPReturnIfNil(object && index <= count);
    
    if (index == count) {
        [self addObject:object];
    } else {
        [self.mutableObjects insertObject:object atIndex:index];
        
        [self notifyWithChangeModel:[IDPArrayChangeModel insertModelWithArray:self index:index]];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    IDPReturnIfNil(index < self.count);
    
    [self.mutableObjects removeObjectAtIndex:index];
    [self notifyWithChangeModel:[IDPArrayChangeModel removeModelWithArray:self index:index]];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)object {
    IDPReturnIfNil(object && index < self.count);
    
    [self.mutableObjects replaceObjectAtIndex:index withObject:object];
    
    [self notifyWithChangeModel:[IDPArrayChangeModel replaceModelWithArray:self index:index]];
}

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex {
    NSUInteger count = self.count;
    
    IDPReturnIfNil(toIndex < count && index < count);
    
    [self.mutableObjects moveObjectAtIndex:index toIndex:toIndex];
    
    [self notifyWithChangeModel:[IDPArrayChangeModel moveModelWithArray:self index:toIndex fromIndex:index]];
}

- (BOOL)containsObject:(id)object {
    return [self.mutableObjects containsObject:object];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}

- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    NSUInteger count = self.count;
    
    IDPReturnIfNil(index <= count);
    
    if (object) {
        if (index == count) {
            [self addObject:object];
        } else {
            [self replaceObjectAtIndex:index withObject:object];
        }
    } else {
        [self removeObjectAtIndex:index];
    }
}

#pragma mark -
#pragma mark Private

- (void)notifyWithChangeModel:(IDPArrayChangeModel *)changeModel {
    [self notifyObserversWithState:IDPArrayModelDidChange object:changeModel];
}

@end
