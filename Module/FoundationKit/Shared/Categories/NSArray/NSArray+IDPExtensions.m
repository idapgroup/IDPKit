//
//  NSArray+IDPExtensions.m
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSArray+IDPExtensions.h"

@interface NSArray (IDPPrivateExtensions)

- (NSUInteger)randomWithCount:(NSUInteger)count;

@end

@implementation NSArray (IDPExtensions)

- (id)randomObject {
    if (![self count]) {
        return nil;
    }
     return [self objectAtIndex:[self randomWithCount:[self count]]];
}

- (NSArray *)shuffledArray {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    NSMutableArray *shuffle = [[[NSMutableArray alloc] initWithCapacity:self.count]  autorelease];
    while ([array count]) {
        int index = arc4random()%[array count];
        [shuffle addObject:[array objectAtIndex:index]];
        [array removeObjectAtIndex:index];
    }
    return  shuffle;
}

- (id)firstObject {
    if (self.count) {
        return [self objectAtIndex:0];
    }
    return nil;
}

- (NSUInteger)randomWithCount:(NSUInteger)count {
    return arc4random_uniform(count);
}

@end
