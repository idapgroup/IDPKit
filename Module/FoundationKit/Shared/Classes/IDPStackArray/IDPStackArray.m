//
//  IDPStackArray.m
//  liverpool1
//
//  Created by Oleksa 'trimm' Korin on 7/4/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPStackArray.h"

@implementation IDPStackArray

#pragma mark -
#pragma mark Public

- (void)push:(id)object {
    [self addObject:object];
}

- (void)pushArray:(NSArray *)objects {
    [self addObjectsFromArray:objects];
}

- (id)pop {
    if (0 == [self count]) {
        return nil;
    }
    
    id<NSObject> object = (id<NSObject>)[self lastObject];
    [[object retain] autorelease];
    [self lastObject];
    
    return object;
}

- (NSArray *)popToObject:(id)object {
    if (![self containsObject:object] && self.count != 0) {
        return nil;
    }
    
    NSArray *objects = [[self copy] autorelease];
    
    NSUInteger index = [objects indexOfObject:object] + 1;
    NSRange range = NSMakeRange(index, [objects count] - index);
    
    NSArray *result = [objects subarrayWithRange:range];
    
    [self removeObjectsInRange:range];
    
    return result;
}

@end
