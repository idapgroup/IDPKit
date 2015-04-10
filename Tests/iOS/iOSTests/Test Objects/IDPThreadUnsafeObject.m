//
//  IDPThreadUnsafeObject.m
//  iOS
//
//  Created by Oleksa Korin on 9/3/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPThreadUnsafeObject.h"

static NSString * const IDPGenericException = @"NSGenericException";
static NSString * const IDPGenericFormat    = @"Object %@ was mutated while being accessed.";

static const NSUInteger IDPUSecondsWaitTime = 10000;

@interface IDPThreadUnsafeObject ()

@end

@implementation IDPThreadUnsafeObject

#pragma mark -
#pragma mark Accessors

- (void)setObject:(NSObject *)object {
    [super setObject:object];
    
    usleep(IDPUSecondsWaitTime);
    
    if (self.object != object) {
        [NSException raise:IDPGenericException format:IDPGenericFormat, self];
    }
}

- (void)setValue:(NSUInteger)value {
    [super setValue:value];

    usleep(IDPUSecondsWaitTime);
    
    if (self.value != value) {
        [NSException raise:IDPGenericException format:IDPGenericFormat, self];
    }
}

@end
