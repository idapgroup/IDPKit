//
//  IDPKVOContext.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPKVOContext.h"

#import "NSObject+IDPExtensions.h"

@implementation IDPKVOContext

@synthesize observer    = _observer;
@synthesize keyPath     = _keyPath;
@synthesize options     = _options;
@synthesize context     = _context;

#pragma mark -
#pragma mark Class Methods

+ (id)contextWithObserver:(NSObject *)observer
                  keyPath:(NSString *)keyPath
                  options:(NSKeyValueObservingOptions)options
                  context:(void *)context
{
    IDPKVOContext *result = [IDPKVOContext object];
    result.observer = observer;
    result.keyPath = keyPath;
    result.options = options;
    result.context = context;
    
    return result;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.observer = nil;
    self.keyPath = nil;
    self.context = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Comparison

- (BOOL)isEqualToContext:(id)object {
    IDPKVOContext *context = object;
    BOOL result = context.observer == self.observer;
    result = result && [context.keyPath isEqualToString:self.keyPath];
    
    return result;
}

- (BOOL)isEqual:(id)object {
    IDPKVOContext *context = object;
    BOOL result = [self isEqualToContext:context];
    result = result && (context.context == self.context);
    
    return result;
}

- (NSUInteger)hash {
    return [self.observer hash] ^ [self.keyPath hash] ^ (NSUInteger)self.context;
}

@end
