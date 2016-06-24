//
//  IDPKVOMutableArrayContainer.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/23/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPKVOMutableArrayContainer.h"

#import "IDPKVOMutableArray.h"

@interface IDPKVOMutableArrayContainer ()
@property (nonatomic, weak) IDPKVOMutableArray *array;

@end

@implementation IDPKVOMutableArrayContainer

@dynamic count;

#pragma mark -
#pragma mark Initializations and Deallocations

+ (instancetype)containerWithArray:(IDPKVOMutableArray *)array {
    return [[self alloc] initWithArray:array];
}

- (instancetype)init {
    return [self initWithArray:nil];
}

- (instancetype)initWithArray:(IDPKVOMutableArray *)array {
    self = [super init];
    self.array = array;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return [self countOfArray];
}

#pragma mark -
#pragma mark KVO Getters

- (NSUInteger)countOfArray {
    return [self.array countOfArray];
}

- (id)objectInArrayAtIndex:(NSUInteger)index {
    return [self.array objectInArrayAtIndex:index];
}

- (NSArray *)arrayAtIndexes:(NSIndexSet *)indexes {
    return [self.array arrayAtIndexes:indexes];
}

- (void)getArray:(id __assign *)buffer range:(NSRange)range {
    [self.array getArray:buffer range:range];
}

#pragma mark -
#pragma mark KVO Object Modification Methods

- (void)insertObject:(id)object inArrayAtIndex:(NSUInteger)index {
    [self.array insertObject:object inArrayAtIndex:index];
}

- (void)removeObjectFromArrayAtIndex:(NSUInteger)index {
    [self.array removeObjectFromArrayAtIndex:index];
}

- (void)replaceObjectInArrayAtIndex:(NSUInteger)index withObject:(id)object {
    [self.array replaceObjectInArrayAtIndex:index withObject:object];
}

#pragma mark -
#pragma mark KVO Objects Modification Methods

- (void)insertArray:(NSArray *)array atIndexes:(NSIndexSet *)indexes {
    [self.array insertArray:array atIndexes:indexes];
}

- (void)removeArrayAtIndexes:(NSIndexSet *)indexes {
    [self.array removeArrayAtIndexes:indexes];
}

- (void)replaceArrayAtIndexes:(NSIndexSet *)indexes withArray:(NSArray *)array {
    [self.array replaceArrayAtIndexes:indexes withArray:array];
}

@end
