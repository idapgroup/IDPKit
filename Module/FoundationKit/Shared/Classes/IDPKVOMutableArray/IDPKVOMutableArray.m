//
//  IDPKVOMutableArray.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/23/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPKVOMutableArray.h"

#import "IDPObjCRuntime.h"

NSString * const kIDPMutableArrayChangesKeyPath     = @"self";

@interface IDPKVOMutableArray ()
@property (nonatomic, readonly) NSMutableArray  *mutableArray;

@end

@implementation IDPKVOMutableArray

#pragma mark -
#pragma mark Accessors

- (NSMutableArray *)mutableArray {
    return [self mutableArrayValueForKey:@"array"];
}

#pragma mark -
#pragma mark NSArray

- (NSUInteger)count {
    return [self countOfArray];
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self objectInArrayAtIndex:index];
}

#pragma mark -
#pragma mark NSMutableArray

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [self insertObject:anObject inArrayAtIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self removeObjectFromArrayAtIndex:index];
}

- (void)addObject:(id)anObject {
    [self insertObject:anObject atIndex:self.count];
}

- (void)removeLastObject {
    [self removeObjectFromArrayAtIndex:self.count - 1];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [self replaceObjectInArrayAtIndex:index withObject:anObject];
}


#pragma mark -
#pragma mark KVO Compliance

- (void)insertObject:(id)object inArrayAtIndex:(NSUInteger)index {
    [super insertObject:object atIndex:index];
}

- (void)insertArray:(NSArray *)array atIndexes:(NSIndexSet *)indexes {
    [super insertObjects:array atIndexes:indexes];
}

- (void)removeObjectFromArrayAtIndex:(NSUInteger)index {
    [super removeObjectAtIndex:index];
}

- (void)removeArrayAtIndexes:(NSIndexSet *)indexes {
    [super removeObjectsAtIndexes:indexes];
}

- (void)replaceObjectInArrayAtIndex:(NSUInteger)index withObject:(id)object {
    [super replaceObjectAtIndex:index withObject:object];
}

- (void)replaceArrayAtIndexes:(NSIndexSet *)indexes withArray:(NSArray *)array {
    [super replaceObjectsAtIndexes:indexes withObjects:array];
}

- (NSUInteger)countOfArray {
    return [super count];
}

- (id)objectInArrayAtIndex:(NSUInteger)index {
    return super[index];
}

- (NSArray *)arrayAtIndexes:(NSIndexSet *)indexes {
    return [super objectsAtIndexes:indexes];
}

- (void)getArray:(id __assign *)buffer range:(NSRange)range {
    [super getObjects:buffer range:range];
}

@end
