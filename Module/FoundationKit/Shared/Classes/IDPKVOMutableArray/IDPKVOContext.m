//
//  IDPKVOContext.m
//  IDPKit
//
//  Created by Oleksa 'trimm' Korin on 5/20/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPKVOContext.h"

@implementation IDPKVOContext

#pragma mark -
#pragma mark Class Methods

+ (id)contextWithObserver:(NSObject *)observer
                  keyPath:(NSString *)keyPath
                  options:(NSKeyValueObservingOptions)options
                  context:(void *)context
{
    IDPKVOContext *result = [IDPKVOContext new];
    result.observer = observer;
    result.keyPath = keyPath;
    result.options = options;
    result.context = context;
    
    return result;
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
