//
//  NSArray+IDPExtensions.m
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "NSArray+IDPExtensions.h"

#import "IDPMath.h"
#import "IDPReturnMacros.h"

@interface NSArray (IDPPrivateExtensions)

@end

@implementation NSArray (IDPExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)arrayWithCount:(NSUInteger)count factoryBlock:(IDPFactoryBlock)factoryBlock {
    IDPReturnNilIfNil(factoryBlock);
    
    NSMutableArray *array = [NSMutableArray new];
    for (NSUInteger i = 0; i < count; i++) {
        [array addObject:factoryBlock()];
    }
    
    return [[self class] arrayWithArray:array];
}

#pragma mark -
#pragma mark Public

- (id)randomObject {
    NSUInteger count = [self count];
    
    if (0 == count) {
        return nil;
    }
    
    return self[IDPRandomNumber(count)];
}

- (NSArray *)shuffledArray {
    NSUInteger count = [self count];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    NSMutableArray *shuffle = [NSMutableArray arrayWithCapacity:count];
    
    while (0 != count) {
        NSInteger index = IDPRandomNumber(count);
        [shuffle addObject:array[index]];
        [array removeObjectAtIndex:index];
        count--;
    }
    
    return shuffle;
}

@end
