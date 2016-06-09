//
//  NSMutableArray+IDPExtensions.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/9/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "NSMutableArray+IDPExtensions.h"

@implementation NSMutableArray (IDPExtensions)

- (void)moveObjectAtIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex {
    id object = self[index];
    [self removeObjectAtIndex:index];
    [self insertObject:object atIndex:toIndex];
}

@end
