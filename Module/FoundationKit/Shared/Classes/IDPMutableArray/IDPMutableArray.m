//
//  IDPMutableArray.m
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMutableArray.h"

@interface IDPMutableArray ()
@property (nonatomic, retain)   NSMutableArray      *array;

@end

@implementation IDPMutableArray

@synthesize array           = _array;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.array = nil;
    
    [super dealloc];
}

- (id)init {
    return [self initWithCapacity:1];
}

- (id)initWithCapacity:(NSUInteger)numItems {
    self = [super init];
    if (self) {
        self.array = [NSMutableArray arrayWithCapacity:numItems];
    }
    
    return self;
}

#pragma mark -
#pragma mark NSArray

- (NSUInteger)count {
    return [self.array count];
}

- (id)objectAtIndex:(NSUInteger)index {
    return [self.array objectAtIndex:index];
}

#pragma mark -
#pragma mark NSMutableArray

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [self.array insertObject:anObject atIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    [self.array removeObjectAtIndex:index];
}

- (void)addObject:(id)anObject {
    [self.array addObject:anObject];
}

- (void)removeLastObject {
    [self.array removeLastObject];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [self.array replaceObjectAtIndex:index withObject:anObject];
}

@end