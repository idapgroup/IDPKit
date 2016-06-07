//
//  IDPSelector.m
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 6/7/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import "IDPSelector.h"

#import <objc/runtime.h>

#import "IDPReturnMacros.h"

@interface IDPSelector ()
@property (nonatomic, assign) SEL value;

@end

@implementation IDPSelector

#pragma mark -
#pragma mark Class Methods

+ (instancetype)objectWithSelector:(SEL)selector {
    return [[self alloc] initWithSelector:selector];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSelector:(SEL)selector {
    self = [super init];
    self.value = selector;
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSUInteger)hash {
    return (NSUInteger)sel_getName(self.value);
}

- (BOOL)isEqual:(id)object {
    IDPReturnValueIfNil(!object || ![self isMemberOfClass:[object class]], NO);
    
    return [self isEqualToSelector:object];
}

- (BOOL)isEqualToSelector:(IDPSelector *)selector {
    return [self isEqualToSEL:selector.value];
}

- (BOOL)isEqualToSEL:(SEL)selector {
    return sel_isEqual(self.value, selector);
}

@end
