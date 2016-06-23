//
//  IDPKVOMutableArray.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/23/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPKVOMutableArray.h"

#import "IDPKVOMutableArray+IDPPrivateExtension.h"

NSString * const kIDPMutableArrayChangesKeyPath     = @"self";

@implementation IDPKVOMutableArray

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithCapacity:(NSUInteger)count {
    self = [super initWithCapacity:count];
    
    IDPKVOMutableArrayContainer *container = [IDPKVOMutableArrayContainer new];
    self.container = container;
    container.array = self;
    
    return self;
}

#pragma mark -
#pragma mark NSMutableArray

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [self.container insertObject:anObject inArrayAtIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.container removeObjectFromArrayAtIndex:index];
}

- (void)addObject:(id)anObject {
    IDPKVOMutableArrayContainer *container = self.container;
    
    [container insertObject:anObject inArrayAtIndex:self.count];
}

- (void)removeLastObject {
    IDPKVOMutableArrayContainer *container = self.container;
    
    [container removeObjectFromArrayAtIndex:self.count - 1];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [self.container replaceObjectInArrayAtIndex:index withObject:anObject];
}

- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    [self.container insertArray:objects atIndexes:indexes];
}

- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes {
    [self.container removeArrayAtIndexes:indexes];
}

- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects {
    [self.container replaceArrayAtIndexes:indexes withArray:objects];
}

#pragma mark -
#pragma mark KVO

- (void)addObserver:(NSObject *)observer
         forKeyPath:(NSString *)keyPath
            options:(NSKeyValueObservingOptions)options
            context:(void *)context
{
    
}

- (void)removeObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               context:(void *)context
{
    
}

- (void)removeObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
{
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    
}

#pragma mark -
#pragma mark KVO Getters

- (NSUInteger)countOfArray {
    return [super count];
}

- (id)objectInArrayAtIndex:(NSUInteger)index {
    return [super objectAtIndex:index];
}

- (NSArray *)arrayAtIndexes:(NSIndexSet *)indexes {
    return [super objectsAtIndexes:indexes];
}

- (void)getArray:(id __assign *)buffer range:(NSRange)range {
    [super getObjects:buffer range:range];
}

#pragma mark -
#pragma mark KVO Object Modification Methods

- (void)insertObject:(id)object inArrayAtIndex:(NSUInteger)index {
    [super insertObject:object atIndex:index];
}

- (void)removeObjectFromArrayAtIndex:(NSUInteger)index {
    [super removeObjectAtIndex:index];
}

- (void)replaceObjectInArrayAtIndex:(NSUInteger)index withObject:(id)object {
    [super replaceObjectAtIndex:index withObject:object];
}

#pragma mark -
#pragma mark KVO Objects Modification Methods

- (void)insertArray:(NSArray *)array atIndexes:(NSIndexSet *)indexes {
    [super insertObjects:array atIndexes:indexes];
}

- (void)removeArrayAtIndexes:(NSIndexSet *)indexes {
    [super removeObjectsAtIndexes:indexes];
}

- (void)replaceArrayAtIndexes:(NSIndexSet *)indexes withArray:(NSArray *)array {
    [super replaceObjectsAtIndexes:indexes withObjects:array];
}

@end
