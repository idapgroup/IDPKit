//
//  IDPWeakrefArray.m
//  AlarmClock
//
//  Extended by Oleksandr Korin on 04/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPWeakArray.h"

#import "NSObject+IDPExtensions.h"

#pragma mark -
#pragma mark IDPMutableWeakArray

@interface IDPMutableWeakArray ()

@end

@implementation IDPMutableWeakArray

@dynamic weakReferences;

#pragma mark -
#pragma mark NSArray

- (id)objectAtIndex:(NSUInteger)index {
    IDPWeakReference *reference = [super objectAtIndex:index];
    return reference.object;
}

#pragma mark -
#pragma mark NSMutableArray

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    IDPWeakReference *reference = [IDPWeakReference referenceWithObject:anObject];
    [super insertObject:reference atIndex:index];
}

- (void)addObject:(id)anObject {
    IDPWeakReference *reference = [IDPWeakReference referenceWithObject:anObject];
    [super addObject:reference];
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    IDPWeakReference *reference = [IDPWeakReference referenceWithObject:anObject];
    [super replaceObjectAtIndex:index withObject:reference];
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)weakReferences {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSUInteger i = 0; i < [self count]; i++) {
        [result addObject:[super objectAtIndex:i]];
    }
    
    return [NSArray arrayWithArray:result];
}

@end