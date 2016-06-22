//
//  NSMutableArray+IDPExtensions.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/9/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "NSMutableArray+IDPExtensions.h"

#import "NSIndexPath+IDPExtensions.h"

#import "IDPReturnMacros.h"

@implementation NSMutableArray (IDPExtensions)

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex {
    id object = self[index];
    [self removeObjectAtIndex:index];
    [self insertObject:object atIndex:toIndex];
}

- (NSIndexSet *)indexesOfObject:(id)object {
    IDPReturnNilIfNil(object);
    
    return [self indexesOfObjects:@[object]];
}

- (NSIndexSet *)indexesOfObjects:(NSArray *)objects {
    IDPReturnNilIfNil(objects || objects.count);
    
    return [self indexesOfObjectsPassingTest:^BOOL(id object, NSUInteger index, BOOL *stop) {
        return [objects containsObject:object];
    }];
}

@end
