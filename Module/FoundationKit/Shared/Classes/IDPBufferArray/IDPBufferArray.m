//
//  IDPBufferArray.m
//  liverpool1
//
//  Created by Oleksa 'trimm' Korin on 7/4/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPBufferArray.h"

@implementation IDPBufferArray

#pragma mark -
#pragma mark Public

- (void)push:(id)object {
    [self addObject:object];
}

- (id)pop {
    if (0 == [self count]) {
        return nil;
    }
    
    id<NSObject> object = (id<NSObject>)[self objectAtIndex:0];
    [[object retain] autorelease];
    [self removeObjectAtIndex:0];
    
    return object;
}

@end
